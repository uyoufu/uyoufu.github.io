---
layout: post
category: MS二次开发
title: MS 关于 Fraction 的使用说明
tagline: by 明不知昔
tags: 
  - Bentley 二次开发
published: true
---

在利用 MS 二开的时候，我们经常会等分线段，通常我们会用到 fraction 来操作，在此记录下 MS 中 fraction 小坑，以作提醒。

<!--more-->

## 原理介绍

fraction 对于 B样条曲线 来说不是各段长度相等的等分点。

fraction 在开始时总是 0，然后结束时总是 1。

fraction 只有在下列基础类型时，才是线性增加的

- line segment，线段
- circular arc，圆或者圆弧
- transition spirals，螺旋线

而在其它复杂类型的曲线中， fraction 的含义与曲线类型的内部参数化有关。

- 对于有N个线段（即N+1个点）的线串 (Linestring)，各个顶点的 fraction 分别为 0，1/N，2/N，…1。
- 对于bspline 曲线，fraction 表示节点范围的分数。
- 对于椭圆弧（elliptic arc），分数与角度变化成正比，公式为：X = center + vector0 * cos(theta) + vector90 * sin (theta)

## 源代码

在此，分享一个等分线段的算法，若有不足之处，还请指教。

``` C#
/// <summary>
/// 用 fraction 获取 curve 上的点
/// </summary>
/// <param name="curve"></param>
/// <param name="fractionGlobal">值在 [0,1] 之间</param>
/// <returns></returns>
public static DPoint3d Fraction2Point(this CurveVector curve,double fractionGlobal,out DVector3d vectorAtFraction)
{
    // 如果 <=0,反向延长
    if (fractionGlobal <= 0)
    {
        curve.GetStartEnd(out DPoint3d pa, out DPoint3d pb, out DVector3d ua, out DVector3d ub);
        double length = curve.SumOfLengths();
        DPoint3d pnt = pa - ua * length * fractionGlobal;
        vectorAtFraction = ua;
        return pnt;
    }
    else if (fractionGlobal >= 1)
    {
        curve.GetStartEnd(out DPoint3d pa, out DPoint3d pb, out DVector3d ua, out DVector3d ub);
        double length = curve.SumOfLengths();
        DPoint3d pnt = pb + ub * length * fractionGlobal;
        vectorAtFraction = ub;
        return pnt;
    }

    // 在 (0,1) 之间
    // 计算每一个曲线的fraction
    List<Tuple<double, double>> segFractionList = new List<Tuple<double, double>>();
    double totalLength = curve.SumOfLengths();
    double accumulation = 0;
    foreach(CurvePrimitive cp in curve)
    {
        double startLength = accumulation;
        double endLength = startLength + cp.GetLength();
        segFractionList.Add(new Tuple<double, double>(startLength / totalLength, endLength / totalLength));
        accumulation = endLength;
    }
    // 获取在哪个范围
    int index = -1;
    for(int i = 0; i < segFractionList.Count; i++)
    {
        if (segFractionList[i].Item1 <= fractionGlobal && fractionGlobal <= segFractionList[i].Item2)
        {
            index = i;
            break;
        }
    }

    if (index < 0)
    {
        throw new Exception("Fraction2Point 中获取 curveprimitive index 失败");
    }

    // 获取 index 下的 curveprimitive
    CurvePrimitive currentCp = curve.GetPrimitive(index);
    if (currentCp == null)
    {
        throw new Exception("Fraction2Point 中用 index 获取 curveprimitive失败");
    }

    // 获取起终点
    currentCp.GetStartEnd(out DPoint3d cpa, out DPoint3d cpb,out DVector3d cpua,out DVector3d cpub);
    if(fractionGlobal== segFractionList[index].Item1)
    {
        vectorAtFraction = cpua;
        return cpa;
    }
    else if(fractionGlobal == segFractionList[index].Item2)
    {
        vectorAtFraction = cpub;
        return cpb;
    }

    CurveLocationDetail locationStart = currentCp.ClosestPointBounded(cpa);
    double signedDis = (fractionGlobal - segFractionList[index].Item1)*totalLength;
    CurveLocationDetail currentLocation = currentCp.PointAtSignedDistanceFromFraction(locationStart.Fraction, signedDis, false);
    currentCp.FractionToPoint(currentLocation.Fraction, out DPoint3d result, out vectorAtFraction);
    return result;
}
```
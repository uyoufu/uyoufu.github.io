---
layout: post
category: .NET
title: PropertyGrid 中实现动态的下拉选项
tagline: by 明不知昔
tags: 
  - .NET
  - C#
published: true
---

在使用 PropertyGrid 控件中，有时候我们在属性的上面添加类型转换特性 (TypeConverterAttribute) 来自定义下拉选项。

这个时候，我们可能会有这样的要求，一个属性的改变会导致另一个属性的候选项发生改变，也就是说，我们需要为特定属性设置动态的下拉选项。

<!--more-->

此处以 StringConverter 为例。

```c#
public class RebarDiameterConverter:StringConverter
{
    private List<string> _diameters = new List<string>() { "φ8","φ10","φ12", "φ14", "φ16", "φ18", };

    //true enable,false disable
    public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
    {
        return true;
    }

    public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
    {
        if(context!=null && context.Instance is ISwRebarProperty rebar)
        {
            _diameters = swOpenRoadsSDK.ParseSpecificationXml.Instance.GetSpecifications(rebar.FeatureName);
        }
        return new StandardValuesCollection(_diameters.ToArray()); //编辑下拉框中的items
    }

    //true: disable text editting.    false: enable text editting;
    public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
    {
        return true;
    }
}
```

在 GetStandardValues 方法中，会传递下来一个 context, 而 context.Instance 就是调用该转换器的实例，所以，将它转换成相应的对象，然后利用对象里面的值来动态生成下拉选项。
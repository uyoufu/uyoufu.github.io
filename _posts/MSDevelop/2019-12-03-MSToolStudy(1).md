---
layout: post
category: MS二次开发
title: MS DgnTool 学习（一）
tagline: by 明不知昔
tags: 
  - MS二次开发
  - DgnTool
published: true
---

DgnTool 是在 MS 上二次开发时会经常用到的交互类，重要性便不言而喻了。在此记录自己的学习心德。

<!--more-->

## 继承关系

``` mermaid
graph BT
locate[LocateSubEntityTool]-->iview[IViewTransients]
region[DgnRegionElementTool]-->iview

locate-->graphic[ElementGraphicsTool]

graphic-->eleset[DgnElementSetTool]
eleset-->primitive[DgnPrimitiveTool]
region-->eleset
eleset-->redraw[IRedrawOperation]
eleset-->modify[ModifyOp]
modify-->imodify[IModifyElement]

primitive-->tool[DgnTool]
tool-->counted[RefCountedBase]
counted-->countedlist[RefCounted < IRefCounted >]

countedlist-->icount[IRefCounted]

```

## DgnTool


---
layout: post
category: mongoose
title: mongoose中嵌套内容修改后save失效
tagline: by 明不知昔
tags: 
  - mongodb
  - mongoose
  - js
published: true
---

今天遇到这样一个问题，我有一个字段 `elments`，它是一个数组，数组里面是对象。当我修改数组中某个对象的某个字段后，再调用 `document.save()` 想保存修改，却发现无法保存修改后的值。

``` json
{
  // 模型名称
  name: {
    type: String,
    trim: true,
    required: true,
  },

  // 里面元素的属性
  elements: Array,
}
```

<!--more-->

示例代码，基于`eggjs` 框架：

``` javascript
await this.ctx.model.ModelFile.insert({
    name: 'test',
    elements:[
        {
            name: 'circle',
            area: '200',
        },
        {
            name: 'rectangle',
            area: '300'
        }
    ]
})
```



1. 修改非嵌套字段时可以正常保存

``` javascript
const doc = await this.ctx.model.ModelFile.findOne({name:'test'})
doc.name = 'test1'
await doc.save()

// name 修改为了 test1
```

2. 整体修改嵌套字段时，也可以正常保存

``` javascript
const doc = await this.ctx.model.ModelFile.findOne({name:'test'})
const rectangleElements = doc.elements[1]
rectangleElements.area = 400
doc.elements = [doc.elements[0],rectangleElements]
await doc.save()

// elements 中的 rectangle 面积被修改为了 400
```

3. 单独修改引用对应的值时，保存不生效

``` javascript
const doc = await this.ctx.model.ModelFile.findOne({name:'test'})
const rectangleElements = doc.elements[1]
rectangleElements.area = 400
await doc.save()

// elements 中的 rectangle 面积还是 300
```

针对第 3 种情况，由于 `elements` 里面的元素没有特定的约束，可以随意修改，为了在修改后可以调用 `save()`，需要在保存之前调用 `markModified()`。

改成如下形式就可以了：

``` javascript
const doc = await this.ctx.model.ModelFile.findOne({name:'test'})
const rectangleElements = doc.elements[1]
rectangleElements.area = 400

doc.markModified("elements")
await doc.save()

// elements 中的 rectangle 面积被修改为了 400
```


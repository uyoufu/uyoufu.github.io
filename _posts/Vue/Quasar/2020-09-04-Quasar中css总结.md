---
layout: post
category: vue
title: Quasar中css总结
tagline: by 明不知昔
tags: 
  - Quasar
published: true
---

用了一段时间的quasar了，它里面封装的 css 类确实很好用，但是在帮助文档中，描述得零零散散，不方便使用，遂总结一下。

<!--more-->

## [字体](http://www.quasarchs.com/style/typography#%E6%A0%87%E9%A2%98)

### 文字大小

text-[ h1~6, subtitle1, subtitle2, body1~2, caption, overline ]

### 字体粗细

text-weight-[ thin, light, regular, medium, bold, bolder ]

### 字体对齐

text-[ right, left, center, justify, bold, italic, no-wrap, stike, uppercase, lowercase, captitalize ]

### 字体颜色

text-[颜色名称]：text-teal

## [颜色](http://www.quasarchs.com/style/color-palette)

### 基本色

primary（淡蓝），secondary（淡绿），accent（淡紫），dark（黑色），positive（深绿），negative（红色），Info（亮蓝），warning（黄色）

### 其它颜色

每种颜色由浅到深分为 1-14 级

red, pink, purple, deep-purple, indigo（靛蓝）, blue, light-blue, cyan, teal（青色）, green,  light-green, lime, yellow, amber, orange, deep-orange, brown, grey, blue-grey

### 在 css 中使用

在应用程序的`*.vue`文件中，可以使用`$primary`，`$red-1`等颜色。

```css
<!-- 注意lang="sass" -->
<style lang="sass">
div
  color: $red-1
  background-color: $grey-5
</style>
```

## [间距](http://www.quasarchs.com/style/spacing)

### 语法

```
q-[p|m][t|r|b|l|a|x|y]-[none|auto|xs|sm|md|lg|xl]
    T       D                   S

T - type
  - values: p (padding), m (margin)

D - direction
  - values:
      t (top), r (right), b (bottom), l (left),
      a (all), x (both left & right), y (both top & bottom)

S - size
  - values:
      none,
      auto (ONLY for specific margins: q-ml-*, q-mr-*, q-mx-*),
      xs (extra small),
      sm (small),
      md (medium),
      lg (large),
      xl (extra large)
```

### 例子

```html
<!-- 所有方向小的padding -->
<div class="q-pa-sm">...</div>

<!-- 项部中margin, 右边小margin -->
<q-card class="q-mt-md q-mr-sm">...</q-card>
```

## [阴影](http://www.quasarchs.com/style/shadows)

| css 类名              | 说明                               |
| ------------------- | -------------------------------- |
| `no-shadow`         | 移除任何阴影                           |
| `inset-shadow`      | 设置一个插入阴影                         |
| `shadow-1`          | 设置1的深度                           |
| `shadow-2`          | 设置2的深度                           |
| `shadow-N`          | 其中`N`是1到24的整数                    |
| `shadow-transition` | 在阴影上应用CSS转换; 最好与`hoverable`类一起使用 |
| shadow-up-1         | 设置1的深度                           |
| shadow-up-2         | 设置2的深度                           |
| shadow-up-N         | 其中N是1到24的整数                      |

## [可见性](http://www.quasarchs.com/style/visibility)

### 常见功能

| 类名                 | 说明                                                                  |
|:------------------ |:------------------------------------------------------------------- |
| `disabled`         | 游标更改为“disable”，不透明度设置为较低值。                                          |
| `hidden`           | 将`display`设置为`none`。与下面的类相比 - `hidden`类意味着元素不会显示并且不会占用布局中的空间。       |
| `invisible`        | 将`visibility`设置为`hidden`。与上面的类相比，`invisible`类意味着元素不会显示，但它仍然占用布局空间。  |
| `transparent`      | 背景颜色是透明的。                                                           |
| `dimmed`           | 在您的元素上应用深色透明覆盖层。不要在已经有**:after**伪元素的元素上使用。                          |
| `light-dimmed`     | 在您的元素上应用白色透明覆盖层。不要在已经有**:after**伪元素的元素上使用。                          |
| `ellipsis`         | 截取文本并在没有足够的可用空间时显示省略号。                                              |
| `ellipsis-2-lines` | 当两行中没有足够的可用空间时，截断文本并显示省略号（仅适用于Webkit浏览器）。                           |
| `ellipsis-3-lines` | 当三行中没有足够的可用空间时，截断文本并显示省略号（仅适用于Webkit浏览器）。                           |
| `z-top`            | 将元素定位在任何其他组件的顶部，但位于Popovers、提示框、通知框之后。                              |
| `z-max`            | 将元素定位在任何其他组件（包括Drawer，Modals，Notifications，Layout header/footer…）之上 |

## [定位](http://www.quasarchs.com/style/positioning)

### 对齐

| 类名            | 说明                        |
|:------------- |:------------------------- |
| `float-left`  | 浮动到左侧                     |
| `float-right` | 浮动到右侧                     |
| `on-left`     | 在右侧设置一个小边距;通常用于有兄弟元素的图标元素 |
| `on-right`    | 在左侧设置一个小边距;通常用于有兄弟元素的图标元素 |

## [辅助类](http://www.quasarchs.com/style/other-helper-classes)

### 鼠标相关

| 类名                   | 说明                            |
|:-------------------- |:----------------------------- |
| `non-selectable`     | 用户将无法选择DOM节点及其文本              |
| `scroll`             | 应用CSS调整使所有平台上的滚动工作达到最佳状态      |
| `no-scroll`          | 隐藏DOM节点上的滚动条                  |
| `no-pointer-events`  | DOM元素不会成为鼠标事件的目标 - 点击、悬停等     |
| `all-pointer-events` | `no-pointer-events`的反义词       |
| `cursor-pointer`     | 改变DOM元素上的鼠标指针，看起来好像在可点击的链接上   |
| `cursor-not-allowed` | 更改DOM元素上的鼠标指针，使其看起来好像不会执行任何操作 |
| `cursor-inherit`     | 将DOM元素上的鼠标指针更改为与父选项相同         |
| `cursor-none`        | 没有鼠标光标被渲染                     |

### 大小相关

| 类名              | 说明                     |
|:--------------- |:---------------------- |
| `fit`           | 宽度和高度设置为100％           |
| `full-height`   | 高度设置为100％              |
| `full-width`    | 宽度设置为100％              |
| `window-height` | 高度设置为100vh，顶部和底部边距为0   |
| `window-width`  | 宽度设置为100vw，左边距和右边距0    |
| `block`         | 将`display`属性设置为`block` |

### 方向有关

| 类名                | 说明        |
|:----------------- |:--------- |
| `rotate-45`       | 旋转45度     |
| `rotate-90`       | 旋转90度     |
| `rotate-135`      | 旋转135度    |
| `rotate-180`      | 旋转180度    |
| `rotate-205`      | 旋转205度    |
| `rotate-270`      | 旋转270度    |
| `rotate-315`      | 旋转315度    |
| `flip-horizontal` | 水平翻转DOM元素 |
| `flip-vertical`   | 垂直翻转DOM元素 |

### 边界相关

| 类名                 | 说明            |
|:------------------ |:------------- |
| `no-border`        | 删除任何边框        |
| `no-border-radius` | 删除边框可能具有的任何半径 |
| `rounded-borders`  | 应用通用边框半径      |

## [Flex](http://www.quasarchs.com/layout/grid/introduction-to-flexbox)

### 设置方向

| 类名               | 说明                                         |
|:---------------- |:------------------------------------------ |
| `row`            | Flex行                                      |
| `row inline`     | 内联Flex行                                    |
| `column`         | Flex列                                      |
| `column inline`  | 内联Flex列                                    |
| `row reverse`    | 将`flex-direction`设置为`row-reverse`的Flex行    |
| `column reverse` | 将`flex-direction`设置为`column-reverse`的Flex列 |

### 包裹

| 类名             | 说明                      |
|:-------------- |:----------------------- |
| `wrap`         | 如有必要进行包裹（默认为“on”，不需要指定） |
| `no-wrap`      | 即使有必要，也不要包裹             |
| `reverse-wrap` | 如有必要逆向包裹                |

### 对齐

- 沿主轴
  
  ![img](https://cdn.quasar.dev/img/flexbox-main-axis-align---2.svg)

- 垂直于主轴
  
  ![img](https://cdn.quasar.dev/img/flexbox-cross-axis-align.svg)

- 多条主轴且有多余空间时
  
  ![img](https://cdn.quasar.dev/img/flexbox-content-align.svg)

### 自对齐

**子元素可以覆盖父元素上指定的对齐方式**。 这允许对单个Flex项进行对齐。

可用值有： `self-start`, `self-center`, `self-baseline`, `self-end`, `self-stretch`

![img](https://cdn.quasar.dev/img/flexbox-self.svg)

### 大小

与 flex 值使用类似

Quasar使用一个12分的列系统来分配子行的大小。 以下是可用的CSS辅助类的一些示例：

```html
<div class="row">
  <div class="col-8">two thirds</div>
  <div class="col-2">one sixth</div>
  <div class="col-auto">auto size based on content and available space</div>
  <div class="col">fills remaining available space</div>
</div>
```

在上面的例子中，由于8/12 = 2/3 = 66％，col-8占据了行宽的三分之二（2/3），而col-2占据了六分之一（2/12 = 1 / 6〜16.67％）。

CSS辅助类`col-auto`使单元格只填充需要渲染的空间。 另一方面，`col`试图填充所有可用的空间，同时如果需要也可以缩小。

CSS辅助类`col-grow`使单元格至少填充需要渲染的空间，并有可能在有更多空间可用时增长。

CSS辅助类`col-shrink`使单元格最多填充需要呈现的空间，并且当没有足够的可用空间时有可能收缩。

### 顺序

**您可以使用`order-first`和`order-last` CSS辅助类来设置子元素的顺序**。

默认情况下，Flex项按源(source)顺序排列。 但是，order属性控制它们在flex容器中的显示顺序。 如果您需要更多粒度，请使用`order` CSS属性并分配所需的值。

例子：

```html
<div class="row">
  <div style="order: 2">Second column</div>
  <div class="order-last">Third column</div>
  <div class="order-first">First column</div>
</div>
```

以下是CSS`order`属性的工作原理：

![img](https://cdn.quasar.dev/img/flexbox-order.svg)
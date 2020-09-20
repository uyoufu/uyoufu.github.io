---
layout: post
category: js
title: exports、module.exports 和 export、export default 到底是咋回事？
tagline: by 明不知昔
tags: 
  - js
published: true
---

## 前言

最近使用 node 和 vue 一起编程，想到 ES6 各种 export 、export default。阿西吧，头都大了....

头大完了，那我们坐下先理理他们的使用范围。

```
require:  node 支持的引入

module.exports / exports: 只有 node 支持的导出

export / import : 只有es6 支持的导出引入
```

这一刻起，我觉得是时候要把它们之间的关系都给捋清楚了，不然我得混乱死。话不多少，咱们开干！！

<!--more-->

# node模块

## 理解

Node里面的模块系统遵循的是 CommonJS 规范。

那问题又来了，什么是CommonJS规范呢？

由于js以前比较混乱，各写各的代码，没有一个模块的概念，而这个规范出来其实就是对模块的一个定义。

**CommonJS定义的模块分为: 模块标识(module)、模块定义(exports) 、模块引用(require)**

先解释 exports 和 module.exports

在一个 node 执行一个文件时，会给这个文件内生成一个 exports 和 module 对象，
而 module 又有一个 exports 属性。他们都指向一块{}内存区域，关系如下图。

```js
exports = module.exports = {};
```

![](https://user-gold-cdn.xitu.io/2017/7/31/6227d4e0917f4af649d9f9e750eddb09?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

那下面我们来看看代码的吧。

```js
//utils.js
let a = 100;

console.log(module.exports); //能打印出结果为：{}
console.log(exports); //能打印出结果为：{}

exports.a = 200; //这里辛苦劳作帮 module.exports 的内容给改成 {a : 200}

exports.a = 100; //修改内存里面的值为100

exports = '指向其他内存区'; //这里把exports的指向指走
```

```js
//test.js
var a = require('/utils');
console.log(a) // 打印为 {a : 100} 
```

从上面可以看出，其实 require 导出的内容是 module.exports 的指向的内存块内容，并不是exports 的。

简而言之，区分他们之间的区别就是 exports 只是 module.exports 的引用，辅助后者添加内容用的。下面的摘抄[nodejs官方的代码](https://nodejs.org/docs/latest-v12.x/api/modules.html#modules_module_exports)：

```javascript
function require(/* ... */) {
  const module = { exports: {} };
  ((module, exports) => {
    // Module code here. In this example, define a function.
    function someFunc() {}
    exports = someFunc;
    // At this point, exports is no longer a shortcut to module.exports, and
    // this module will still export an empty default object.
    module.exports = someFunc;
    // At this point, the module will now export someFunc, instead of the
    // default object.
  })(module, module.exports);
  return module.exports;
}
```

用白话讲就是，exports 只辅助 module.exports 操作内存中的数据，辛辛苦苦各种操作数据完，累得要死，结果到最后真正被 require 出去的内容还是 module.exports 的，真是好苦逼啊。

其实大家用内存块的概念去理解，就会很清楚了。

然后呢，为了避免糊涂，尽量都用 module.exports 导出，然后用 require 导入。

## node 模块的导出方式

上面讲了 exports, module.exports 的区别

接下来总结一下使用 CommonJS 规范时，有哪些导出形式

### 导出函数

```javascript
// 定义模块
// user.js
const getName = () => {
  return 'Jim';
};

exports.getName = getName;
```

```javascript
// 使用模块
// index.js
const user = require('./user');
console.log(`User: ${user.getName()}`);
```

```javascript
// 结果
User: Jim
```

### 导出多个函数和值

```javascript
// 定义
// user.js
const getName = () => {
  return 'Jim';
};

const getLocation = () => {
  return 'Munich';
};

const dateOfBirth = '12.01.1982';

exports.getName = getName;
exports.getLocation = getLocation;
exports.dob = dateOfBirth;
```

```javascript
// 使用
// index.js
const user = require('./user');
console.log(
  `${user.getName()} lives in ${user.getLocation()} and was born on ${user.dob}.`
);
```

```javascript
// 结果
Jim lives in Munich and was born on 12.01.1982.
```

在导出的过程中，可以与原变量有不同的名字

## 语法变化

我们可以在文件的任何地方导出方法或者值:

```javascript
exports.getName = () => {
  return 'Jim';
};

exports.getLocation = () => {
  return 'Munich';
};

exports.dob = '12.01.1982';
```

## 导出默认值

上面的方式是对函数和值进行分别导出，这种方式适合于帮助类。但当你只想导出一个对象的时候，可以使用 ` module.exports`:

```javascript
class User {
  constructor(name, age, email) {
    this.name = name;
    this.age = age;
    this.email = email;
  }

  getUserStats() {
    return `
      Name: ${this.name}
      Age: ${this.age}
      Email: ${this.email}
    `;
  }
}

// 此处直接将类赋值给 module.exports
module.exports = User;
```

## ES6 中的模块导出导入

说实话，在 es 中的模块，就非常清晰了。不过也有一些细节的东西需要搞清楚。

比如 export 和 export default，还有 导入的时候，import a from .., import {a} from ..，总之也有点乱，那么下面我们就开始把它们捋清楚吧。

## export 和 export default

首先我们讲这两个导出，下面我们讲讲它们的区别：

- export 与 export default 均可用于导出常量、函数、文件、模块等

- 在一个文件或模块中，export、import 可以有多个，export default 仅有一个

- 通过 export 方式导出，在导入时要加{ name }，export default 则不需要

- export 导入时，只能使用定义时的名称，而 export default 导入时，可以是任意名称

- export 能直接导出变量表达式，export default 不行

上面的两种方式，export 适合于一个模块中有 0 个或者多个 export 的情况；export default 则只能有一个。

```javascript
// 导出独立的特征
// Exporting individual features
export let name1, name2, …, nameN; // also var, const
export let name1 = …, name2 = …, …, nameN; // also var, const
export function functionName(){...}
export class ClassName {...}

// 导出列表
// Export list
export { name1, name2, …, nameN };

// 导出时重命名
// Renaming exports
export { variable1 as name1, variable2 as name2, …, nameN };

// 导出时解构并重命名
// Exporting destructured assignments with renaming
export const { name1, name2: bar } = o;

// Default exports
export default expression;
export default function (…) { … } // also class, function*
export default function name1(…) { … } // also class, function*
export { name1 as default, … };

// 聚合模块：用于聚合其它模块并在当前模块导出
// Aggregating modules
export * from …; // does not set the default export 
export * as name1 from …; // Draft ECMAScript® 2O21
export { name1, name2, …, nameN } from …;
export { import1 as name1, import2 as name2, …, nameN } from …;
export { default } from …;
```

# 总结

- 在 node 中使用 module.exports exports 和 require
- 在 ES6 中使用 export export default 和 import

# 致谢

1. [exports、module.exports 和 export、export default 到底是咋回事](https://juejin.im/post/6844903489257095181)

2. [Understanding module.exports and exports in Node.js](https://www.sitepoint.com/understanding-module-exports-exports-node-js/)

3. [MDN export](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export)
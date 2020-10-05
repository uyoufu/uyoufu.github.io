---
layout: post
category: MS Develop
title: MDL开发中如何创建makefile文件
tagline: by 明不知昔
tags: 
  - Bentley 二次开发
  - MDL
published: true
---

## 什么是 makefile ?

makefile关系到了整个工程的编译规则。一个工程中的源文件不计其数，并且按类型、功能、模块分别放在若干个目录中，makefile定义了一系列的规则来指定，哪些文件需要先编译，哪些文件需要后编译，哪些文件需要重新编译，甚至于进行更复杂的功能操作，因为makefile就像一个Shell脚本一样，其中也可以执行操作系统的命令。

> 因为 windows 集成的开发环境为我们做了上述工作，所以在平时开发的时候，没有太多的感觉。

<!--more-->

## MDL 的开发需要熟悉的几种 mke 语法:

1. 注释：以#号开头的行为注释行

2. 变量定义（Bentley 的说明中称它为宏，仅此处使用变量一词）
   如 `appName = HelloWorld` 这样的形式。appName 被称为变量，HelloWorld 被当成值赋予给 appName。
   也可以对变量赋予多个值,值之间用空格分开，也可以使用 `\` 换行，比如：
   
   ```makefile
   objects = main.o kbd.o command.o display.o \
      insert.o search.o files.o utils.o
   ```

3. 变量使用：以 `$(变量名)` 形式，比如 `$(appName)` 为 HelloWorld

4. 依赖定义
   定义格式如下：
   
   ```makefile
   target... : prerequisites...
    command1
    ...
    commandN
   ```
   
   **特别注意的是：command 前面必须是 Tab**
   
   上面的参数说明如下：
   
   - target
     可以是一个 object file（目标文件），也可以是一个执行文件，还可以是一个标签（label）。对于标签这种特性，在后续的“伪目标”章节中会有叙述。    
   
   - prerequisites
     生成该 target 所依赖的文件
   
   - command
     该target要执行的命令（任意的shell命令）
     坦白说，可以这样理解：
     
     > **prerequisites中如果有一个以上的文件比 target 文件要新的话，command 命令就会被执行。**

## 宏

### 在 makefile 中定义宏
|形式|描述|
|---|---|
|macro = definition|将 definition 的值赋给 macro。标准赋值方法，用得比较多|
|macro =% definition|先计算 definition 的值，再赋值给 macro|
|macro + definition|将 definition 添加到 marco 值后面，和编程中 += 用法颇似|
|macro +% definition|先计算 definition 的值，然后再追加到 macro 上面|

### 宏的使用
|形式|描述|
|---|---|
|$(name)|通过迭代替换展开|
|${name}|通过迭代替换展开，如果最后一个字符是路径分隔符，则删除它|
|$[name]|展开值;将宏展开成迭代字符串值，且不做任何进一步的替换|

### 保留的宏和其展开值
|宏|展开值|
|---|---|
|$@|当前目标文件|
|$?|所有比目标文件更新的依赖文件|
|$=|最新的依赖文件|
|$<|当前的依赖文件|
|$*|目标文件的基础文件|
|$%|第一个目标文件的目录|

每个操作平台都预定了宏，可以通过 `bmake -p` 来查看

### 实例
```makefile
%if defined (_MakeFilePath) 
baseDir = $(_MakeFilePath) 
%else
baseDir = $(MS)/mdl/examples/basic/
%endif
```
## 依赖定义规则符号解释

## 依赖定义规则实例（来自 mdl.mki）
```makefile
.mt.r: 
$(msg)
> $(o)temp.cmd
-o$@
%if privateInc
-i$(privateInc)
%endif<BR> 
$(rscCompIncs)
$(altIncs)
-i$(publishInc)
-i$(publishIdsInc)
-i$(stdlibInc)
$%$*.mt$(RTypeCmd) @$(o)temp.cmd
<
$(RTypeCmd) @$(o)temp.cmd 
~time
```

## 后记

如果想了解更多 makefile 语法，可以参考：

- [概述 &mdash; 跟我一起写Makefile 1.0 文档](https://seisman.github.io/how-to-write-makefile/overview.html)
- SDK帮助文档MicroStationApi.chm的Creating a Makefile and Using the bmake Utility
- 要想更深入地理解mke文件，还需要您读系统的mki文件，这些文件定义了许多系统内置的宏定义和规则

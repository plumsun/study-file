# Shell（Shell Scirpt）

## 概念

### 1.介绍

#### 概念

Shell 是一个用 C 语言编写的程序，是一种命令程序，又是一种程序设计语言。

> 编写一个程序并且运行，通常是需要一个对应编程语言的编辑器和一个可以解释执行的解释器即可。

#### 运行环境

- Bourne Shell(`sh`)

  Unix 默认的 Shell。它的 Shell 解释器位于 `/bin/sh`（Unix 系统默认解释器位置）和 `/usr/bin/sh`这两个位置，有些 Unix 系统中，`/usr/bin/sh`会指向系统默认的解释器。

- Bourne Again Shell(`bash`)

  GNU 项目的一部分，是 Bourne Shell 的增强版本，当前大多数 Unix/Linux 系统的默认 Shell。提供了更多功能，如命令补全、数组、循环、条件语句、函数等。解释器路径：`/bin/bash`。

- C Shell(csh)

  具有 C 语言风格的语法。

- K Shell(ksh)

  结合了 Bourne Shell 和 C Shell 的优点，提供了更多的功能和扩展，是一种功能强大的 Shell。

  .....

### 2.规范

正常情况下，Shell 脚本的第一行是这样的：`#!/bin/bash`.

`#!`是一个约定标记，通常告诉系统这个脚本要用什么类型的解释器去解释执行。



### 3.运行

#### 1.作为可执行程序运行

```bash
chmod +x file.sh # 为 file.sh 赋予执行权限
./file.sh # 执行脚本
```

> 加上前缀 ./ 通常是为了告诉系统在当前目录下找对应的脚本文件，如果没有的话，系统会到 PATH (环境变量) 找对应的脚本文件，当你的脚本文件只存在于当前目录下。



#### 2.作为解释器参数

```bash
/bin/bash file.sh # 直接运行解释器，参数就是脚本文件名
/bin/sh file.sh
```



#### 3.其余方式

##### a. source

b. sh

c. bash


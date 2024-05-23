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

在当前 bash 环境下读取并执行 FileName 中的命令。该 filename 文件可以无 "执行权限"。

```bash
source fileName # 作用与 . 类似
```

##### b. sh

打开一个子 shell 来读取并执行 FileName 中命令。该 filename 文件可以无 "执行权限"。

```bash
sh FileName
或
bash FileName
```

##### c. bash

打开一个子 shell 来读取并执行 FileName 中命令，该 filename 文件需要 "执行权限"。

```bash
./FileName
```

> `sh`与 `./` 运行一个 shell 脚本时会启动另一个命令解释器。



## 变量

### 1.变量定义

变量是用于存储数据值的名称。

定义变量时，变量名不加美元符号（$，PHP语言中变量需要），如：

```bash
file="test.sh"
```

注意，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。同时，变量名的命名须遵循如下规则：

- **只包含字母、数字和下划线：** 变量名可以包含字母（大小写敏感）、数字和下划线 **`_`**，不能包含其他特殊字符。
- **不能以数字开头：** 变量名不能以数字开头，但可以包含数字。
- **避免使用 Shell 关键字：** 不要使用Shell的关键字（例如 if、then、else、fi、for、while 等）作为变量名，以免引起混淆。
- **使用大写字母表示常量：** 习惯上，常量的变量名通常使用大写字母，例如 `PI=3.14`。
- **避免使用特殊符号：** 尽量避免在变量名中使用特殊符号，因为它们可能与 Shell 的语法产生冲突。
- **避免使用空格：** 变量名中不应该包含空格，因为空格通常用于分隔命令和参数。



有效变量名定义示例：

```bash
RUNOOB="www.runoob.com"
LD_LIBRARY_PATH="/bin/"
_var="123"
var2="abc"
```

无效变量名定义示例：

```bash
# 避免使用if作为变量名
if="some_value"
# 避免使用 $ 等特殊符号
variable_with_$=42
?var=123
user*name=runoob
# 避免空格
variable with space="value"
```



**注意**

等号两侧避免使用空格：

```bash
# 正确的赋值
variable_name=value

# 有可能会导致错误
variable_name = value
```



除了显式地直接赋值，还可以用语句给变量赋值，如：

```bash
# 下列语句表示将 /etc 下目录的文件名循环出来并传递给 file 变量。
for file in `ls /etc`
或
for file in $(ls /etc)
```



### 2.变量使用

使用一个定义过的变量，只要在变量名前面加美元符号即可，如：

```bash
your_name="test"
echo $your_name
echo ${your_name}
```

**变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界**，**`推荐给所有变量加上花括号`**，比如下面这种情况:

```bash
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script"
done
# 运行结果
I am good at AdaScript
I am good at CoffeScript
I am good at ActionScript
I am good at JavaScript
```

> 如果不给skill变量加花括号，写成echo "I am good at \$skillScript"，解释器就会把 \$skillScript 当成一个变量（其值为空），代码执行结果就不是我们期望的样子了。

```bash
for skill in Ada Coffe Action Java; do
    echo "I am good at $skillScript"
done
# 运行结果
I am good at 
I am good at 
I am good at 
I am good at 
```



**变量重新赋值**

```bash
#!/bin/bash
your_name="test"
echo $your_name
your_name="gege"
echo $your_name
# 运行结果
test
gege
```

> 这样会对 your_name 进行重新赋值，但注意，第二次赋值的时候不能写 \$your_name="alibaba"，**使用变量的时候才加美元符（$）**。

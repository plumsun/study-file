## CSS

CSS 是层叠样式表的简称，有时会称为 CSS 样式表或者是级联样式表。它也是一种标记语言，主要用来美化或者设置 HTML 页面的文本内容（字体、大小、颜色等）、图片外形（宽高、形状等）以及版面的布局和外观显示样式。

#### CSS 运行

正常浏览器加载页面步骤：

1.  浏览器载入 HTML 文件（比如从网络上获取）。
2.  将 HTML 文件转化成一个 DOM（Document Object Model），DOM 是文件在计算机内存中的表现形式。
3.  接下来，浏览器会拉取该 HTML 相关的大部分资源，比如嵌入到页面的图片、视频和 CSS 样式。JavaScript 则会稍后进行处理。
4.  浏览器拉取到 CSS 之后会进行解析，根据选择器的不同类型（比如 element、class、id 等等）把他们分到不同的“桶”中。浏览器基于它找到的不同的选择器，将不同的规则（基于选择器的规则，如元素选择器、类选择器、id 选择器等）应用在对应的 DOM 的节点中，并添加节点依赖的样式（这个中间步骤称为渲染树）。
5.  上述的规则应用于渲染树之后，渲染树会依照应该出现的结构进行布局。
6.  网页展示在屏幕上（这一步被称为着色）。



>   一个 DOM 有一个树形结构，标记语言中的每一个元素、属性以及每一段文字都对应着结构树中的一个节点（Node/DOM 或 DOM node）。节点由节点本身和其他 DOM 节点的关系定义，有些节点有父节点，有些节点有兄弟节点（同级节点）。DOM 是 CSS 样式和文件内容的结合。



#### 语法规范

CSS 主要由两部分组成：选择器、声明（可以有多条）。简单示例（有点类似于 JSON 格式）：

```css
h1 {
    color: red; 
    font-size: 25px; 
}
```

>   注意：
>
>   -   CSS 中每个声明都应该是 `键值对` 形式。
>   -   声明之间应通过`; `进行区分。



**代码风格**

不是强制性的，只是为了方面观看。

1.  样式书写风格，CSS 样式主要分为`紧凑型`和`展开型`：

    ```css
    /* 紧凑型 */
    h1 { color: red; font-size: 12px; }
    
    /* 展开型 */
    h2 {
        color: red; 
        font-size: 12px; 
    }
    ```

2.  CSS 样式通常都是以小写为主。

3.  空格

    -   属性值应以空格开始，`;`后应保留一个空格。
    -   选择器和大括号之间应保留一个空格。



#### CSS 样式应用格式

1.  ##### 外部样式表

    CSS 的样式单独写在一个 `.css`文件中，这是最常用和最有用的方式。可以通过一个 CSS 文件来链接或者应用到不同的 HTML 页面上，`link` 标签可以用来在`HTML`文件中来链接外部文件。

    

    link标签属性：

    -   rel，主要表示当前链接的外部文件以什么类型注入到 HTML 文件中。常见的有：icon（图标）、license（版权）、stylesheet（样式表）等等。
    -   href，主要用来指定外部文件路径，可以是一个网址或者是相对路径。
    -   

    代码示例：

    ```htMl
    <link href="main.css" rel="stylesheet" />
    ```

    

2.  ##### 内部样式表

    一个内部样式表驻留在 HTML 文档内部。要创建一个内部样式表，你要把 CSS 放置在包含在 HTML `<head>` 元素中的 `<style>` 元素内。

    代码示例：

    ```html
    <!doctype html>
    <html lang="zh-CN">
      <head>
        <meta charset="utf-8" />
        <title>我的 CSS 测试</title>
        <style>
          h1 {
            color: blue;
            background-color: yellow;
            border: 1px solid black;
          }
          p {
            color: red;
          }
        </style>
      </head>
      <body>
        <h1>Hello World!</h1>
        <p>这是我的第一个 CSS 示例</p>
      </body>
    </html>
    ```

    

3.  ##### 内联样式

    内联样式是影响单个 HTML 元素的 CSS 声明，包含在元素的 `style` 属性中

    ```html
    <!doctype html>
    <html lang="zh-CN">
      <head>
        <meta charset="utf-8" />
        <title>我的 CSS 测试</title>
      </head>
      <body>
        <h1 style="color: blue;background-color: yellow;border: 1px solid black;">
          Hello World!
        </h1>
        <p style="color:red;">这是我的第一个 CSS 示例</p>
      </body>
    </html>
    ```




### 特性

#### 层叠性（覆盖）

相同的选择器设置相同的样式，此时一个样式就会覆盖（层叠）另一个冲突的`样式`。

1.  样式冲突的情况下，遵循`就近原则`，哪个样式离结构近，就执行哪个样式。
2.  样式不冲突，不会出现层叠现象。

#### 继承性

CSS 中子标签会继承父标签中的某些样式，主要是一些文本属性、字体属性、颜色属性，例如文本颜色、字体大小等等。

>   子标签也会继承父标签的`行高`（行高属性值可以不带类型，直接简写为数字）。

#### 优先级

当同一个元素指定了多个选择器，会出现优先级问题，CSS 选择器优先级（从大到小）：

| 选择器                               | 权重    |
| ------------------------------------ | ------- |
| 继承/ \*                             | 0,0,0,0 |
| 元素选择器、标签选择器、伪元素选择器 | 0,0,0,1 |
| 类选择器/伪类选择器                  | 0,0,1,0 |
| ID选择器                             | 0,1,0,0 |
| 内联样式                             | 1,0,0,0 |
| !important 重要的                    | 无穷大  |

有些特殊的选择器会触发`权重叠加`，后代选择器、子代选择器等一些复合选择器。

比如：

```css
/* 后代选择器选中 ul 标签中的 li 标签，此时 li 标签的权重 = ul 标签权重(0,0,0,1) + li 标签权重(0,0,0,1) = (0,0,0,2) */
ul li {}
/* 简单的标签选择器 选中 li 标签，此时 li 标签的权重 = li 标签权重(0,0,0,1) */
li {}
/*  */
```

所以此时 `ul li {}` 选择器的样式会`层叠`（覆盖）`li {}` 选择器中冲突的样式。



>   CSS 选择器优先级：`!important 重要的`>`内联样式`>`ID选择器`>`类选择器/伪类选择器`>`元素选择器（标签选择器）`>`继承/ *`
>
>   `!important`主要使用在样式上，跟在样式值后面，例如：`font-size: 12px!important;`

### 选择器

由元素和其他部分组成合起来告诉浏览器哪个 HTML 元素应当是被选为应用规则中的 CSS 属性值的方式，选择器所选择的元素被称为：“选择器的对象”。主要指定的是要修改的标签，可以是标签名称，标签标识等能代表对应目标标签的值。

##### 列表

选择器可以通过列表的方式把多个选择器进行组合，成为一个选择器列表，列表中每个选择器都采用同样的 CSS 规则：

```css
/* 多个选择器可以通过 , 进行组合 */
h1, .special {
    color: red;
}
```

>   如果选择器列表中某个选择器无效，那么整体规则都会被忽略。



#### 分类

##### 基础选择器

简单点说就是由单个选择器组成。

1.  标签选择器（类型选择器），用 HTML 标签作为选择器，按标签名称分类，为页面中某一类标签指定统一的 CSS 样式。

    ```css
    /* 选择所有 span 标签的元素 */
    span {
        color: red;
    }
    ```

    

2.  :red_circle: 类选择器 ，通过 `.class 名` 来选中对应的标签元素，class 是 HTML 中所有标签的共同属性。

    ```css
    /* 选择  class 为 test 的元素 */
    .test {
        color: red;
    }
    ```

    

3.  :red_circle: id选择器 ，通过 `#id`来选择对应属性 id 的标签元素，id 是 HTML 中所有标签的共同属性。

    ```css
    /* 选择 id 为 text 的元素 */
    #text {
        color: chocolate;
    }
    ```

4.  全局选择器，选中整个 HTML 文档中的元素，主要用`*`代指。

    ```css
    /* 选择所有元素 */
    * {
        color: red;
    }
    ```



##### 复合选择器

###### :red_circle:属性选择器

通过指定标签的属性值来进行选择。

-   标签[属性="value"]，表示选择带有属性值为 value 的标签。
-   标签[属性~="value"]，表示选择带有属性值为 value 的标签，用于属性值为多个的时候（属性值为多个中间用空格分开）。
-   标签[属性|="value"]，表示选择属性值中包含 value 的标签，采用统配符模式，例如 value1 包含 value 就会被选择到。
-   标签[属性^="value-"]，表示选择属性值以 value 开头的标签。
-   标签[属性^="-value"]，表示选择属性值以 value 结尾的标签。
-   标签[属性\*="value"]，表示选择属性值中包含 value 的标签，采用统配符模式，例如 value1 包含 value 就会被选择到。

>   采用属性选择器时，默认是大小写敏感的，可以通过 `i` 字符忽略大小写，比如 `test[class="value" i] {}`



###### :red_circle:伪类选择器

选择处于特定状态的元素，比如当它们是这一类型的第一个元素时，或者是当鼠标指针悬浮在元素上面的时候，简单示例：`:pseudo-class-name`，以单引号开始。代码示例：

```css
/* 选择 article 标签中第一个 p 标签 */
article p:first-child {
  font-size: 120%;
  font-weight: bold;
}
/* 当用户光标移动到 a 标签上时颜色改变 */
a:hover {
  color:hotpink;
}
```

>   伪类选择器包含很多种：
>
>   -   链接伪类（主要针对 a 链接标签）：
>
>       -   :link，选择所有为被访问的标签。
>
>       -   :visited，选择所有已经访问过的标签。
>
>       -   :active，选择活动的链接（鼠标按下未松开的标签）。
>
>       -   :hover，上面提到过，只会在用户将指针挪到元素上的时候才会激活，一般就是链接元素。
>
>   -   :focus，选择获取焦点的元素，一般用于`input`表单元素。
>
>   -   :first-of-type：指定类型的第一个子元素。
>
>   -   last-of-type：指定类型的最后一个子元素。
>   -   nth-of-type(n)：类似于nth-child(n)，只不过针对的是类型
>   -   first-child：父元素中指定标签的第一个子元素。
>   -   last-child：父元素中指定标签的最后一个子元素。
>   -   nth-child(n)：父元素中指定标签的第 n 个子元素，n 可以设置一些关键字：
>       -   even：父元素中偶数个子元素。
>       -   odd：父元素中奇数个子元素。
>       -   n：如果设置为 n 的话会选择所有子元素（从 0 开始每次 +1）。
>       -   2n：类似于 even。
>       -   2n+1：类似于 odd。
>       -   5n：5的倍数。
>       -   n+5：从第5个开始到最后。
>       -   数字：父元素中第 n 个子元素
>
>   注意：
>
>   -   nth-child(n) 执行顺序，假如当前选择器写法为：`body div:nth-child(n) {}`
>       -   先对 body 标签中所有子标签打上序号，过滤出序号为 n 的子标签。
>       -   然后过滤出的子元素进行比较，判断是否是 div，如果是就设置样式，如果不是就丢弃。
>   -   nth-of-type(n) 执行顺序，假如当前选择器写法为：`body div:nth-of-type(n) {}`
>       -   先对 body 标签中指定的 div 子标签打上序号
>       -   过滤出序号为 n 的子标签。



###### 伪元素选择器

主要针对的是标签中的内容，可以通过 **CSS 创建一个新的标签元素**，简单示例：`::pseudo-element-name`，以双引号开头。

代码示例：

```css
/* 在class为 box 的标签文本开头加入以下内容 */
.box::before {
  content: "This should show before the other content. ";
}
```

>   常用的伪元素：
>
>   -   ::first-line：文本第一行
>   -   ::before：在元素内部的前面插入内容，必须具有 content 属性。
>   -   ::after：在元素内部的后面插入内容，必须具有 content 属性。
>
>   **注意**
>
>   1.  通过伪元素选择器创建的标签属于**行内元素**。
>   2.  通过伪元素选择器创建的标签在**文档树**中不存在。
>   3.  伪元素选择器的权重为 1。



###### :red_circle:关系选择器

-   **后代选择器**，通过单个空格组合两个元素，格式：`父类 后代 {}`，这种形式会选择父类元素中所有的目标后代元素。代码示例：

    ```css
    /* 选择 div 元素后代的所有 span 元素 */
    div span {
    	color: red;
    }
    ```

    >   特点：后代选择器不单单只会选中当前元素的子元素，还会选中子元素中`所有符合条件的元素`，只要元素的`顶级父类是当前元素`都会选中。

-   **子代选择器**，通过 `>`组合两个元素，格式：`父类 > 子类 {}`，这种形式只会选中父类元素中所有符合条件的`子类元素`。代码示例：

    ```css
    /* 选择 div 元素子类的所有 span 元素 */
    div > span {
    	color: red;
    }
    ```

    >   特点：子类选择器只会选择下一级中符合条件的元素，不会选择多级。



###### 并集选择器

通过 `,` 组合多个元素，格式：`元素1,元素2,元素3 {}`，代码示例：

```css
/* 选择 span、div、class为test的元素后代的所有 a元素 */
span,div,.test a {
	color: red;
}
```



### 样式

#### 常用样式

##### 字体样式（font）

针对于文本字体的一些常用样式。

| 属性         | 含义        | 描述                                                         |
| ------------ | ----------- | ------------------------------------------------------------ |
| 字体类型     | font-family | 指定文本的字体，可以配置多个，用 `,`隔开。                   |
| 字体大小     | font-size   | 指定文字的大小，类型可以是：1px（像素），1%（占用当前网页的1%）。默认值 16。行高可以与字体大小简写为 `font-size/2`，此时行高等于 `font-size * 2` |
| 字体粗细     | font-weight | 类型：normal（正常）、bold（加粗）、number（100,200等等）等。 |
| 字体样式     | font-style  | 正常：normal，斜体：italic                                   |
| 字体复合属性 | font        | 可以将字体属性组合输写，例如 font: font-style font-weight font-size/line-height font-family.严格遵循顺序font-size和font-family必须存在，其他属性可以省略 |

##### 文本样式（text）

针对于文本的一些常用样式。

| 属性            | 含义         | 描述                                                         |
| --------------- | ------------ | ------------------------------------------------------------ |
| color           | 颜色         | 指定文本颜色，值可以指定颜色英文名、十六进制、RGB 代码       |
| text-align      | 文本对齐方式 | 指定文本在块区中的水平对齐方式，值：left 左对齐（默认值）、right 右对齐、center 居中。 |
| text-decoration | 装饰文本     | 为文本添加装饰，值：none没有（默认值）、underline（下划线）、overline（上划线）、line-through（删除线）。 |
| text-indent     | 文本缩进     | 对`段落`文本的第一行进行缩进，值为：1px（像素）、1em（常用，相对于当前文字 font-size 的大小）。 |
| line-height     | 行间距       | 控制文本每行之间的距离。包含上间距、文本高度 font-size、下间距。三者相加才算是完整的行间距。 |

##### 背景样式（background）

| 属性                                                  | 含义                               | 描述                                                         |
| ----------------------------------------------------- | ---------------------------------- | ------------------------------------------------------------ |
| background-color                                      | 背景颜色                           | 用来指定当前元素的背景颜色，比如：transparent（透明）        |
| background-image                                      | 背景图片                           | 可以把图片设置成元素背景，值为：none（无）、`url(图片相对路径或者绝对路径)` |
| background-repeat                                     | 背景平铺                           | 设置背景图片的铺排方式，no-repeat（不平铺）、repeat（纵向和横向平铺，默认值）、repeat-x（横向平铺）、repeat-y（纵向平铺） |
| background-position                                   | 背景图片位置                       | 设置当前背景图片在元素的中位置，值为：`x y`坐标轴信息可以是数值或者百分比、方位名词（top（上）、center、left、bottom）。值是方位名词是没有先后顺序，如果是坐标轴则必须按照顺序，方位名词可以和坐标信息混用。 |
| background-attachment                                 | 背景图像固定                       | 设置背景图片是否随着页面滚动而发生滚动，值为 scroll（滚动，默认值），fixed（固定）。 |
| background                                            | 背景属性组合                       | 组合书写的格式要求：`背景颜色 背景图片地址 背景平铺模式 图片滚动模式 图片位置`，严格要求顺序。 |
| background: rgba( 0, 0, 0, 0)                         | 透明效果（CSS新增属性，IE9+ 支持） | 设置当前元素背景的透明度，前面三位是背景的 `rgb` 颜色值，最后一个元素值是背景透明度，取值范围 `0 ~ 1` |
| background: linear-gradient(起始方向,颜色1,颜色1....) | 背景线性渐变                       | 让元素背景颜色从一种颜色过渡到另一种。（需要添加浏览器私有前缀） |

>   背景图片位置的值有三种情况：
>
>   1.  值为方位名词，此时垂直和水平的位置`没有先后顺序`，浏览器会根据方位名词自动设置背景位置。
>   2.  值为坐标轴信息，此时垂直的水平的位置有`先后顺序`，第一个值为 `x` 轴信息，第二个值为 `y` 轴信息。
>   3.  值为方位名词和坐标轴混用形式，此时垂直的水平的位置有`先后顺序`，第一个值为 `x` 轴信息，第二个值为 `y` 轴信息。
>
>   透明效果的透明度值一般是小数，小数值的整数为可以省略，写法示例：`rgba( 0, 0, 0, .3)`
>
>   background-image 不能和 background 同时使用，background 会覆盖掉 image;



#### CSS3 新样式

有兼容性问题，只支持 `IE9+` 以上的浏览器。

##### 圆角边框

`border-radius`用来设置边框的弧度，值为 `数字`。示例：`border-radius: 13px;`，这是一个简写属性，后面可以跟`不同个数的值`。四个值，分别代表：`左上角`、`右上角`、`右下角`、`左下角`，顺时针处理。

>   如果想单独设置某一个角的弧度，可以使用精确的样式属性：border-top-left-radius（左上角），border-top-right-radius（右上角）等等。

原理是通过指定的`半径大小`进行画圆，再将画好的圆填充到边框角落部分，形成圆角效果。

>   圆形效果：
>
>   1.  当前容器为正方形
>   2.  设置边框圆角的值 = 宽度或者高度/2（或者 50%）即可。
>
>   圆角矩形效果：
>
>   1.  当前容器为矩形
>   2.  设置边框圆角的值 = 高度/2（或者 50%）即可实现圆角矩形效果。

##### 盒子阴影

可以使用 `box-shadow`为盒子添加阴影效果。有 6个值，按顺序每个值分别代表：

1.  `h-shadow`，必需，设置水平阴影的位置，允许负值。
2.  `v-shadow`，必需，设置垂直阴影的位置，允许负值。
3.  `blur`，可选模糊距离，影子的虚实度（透明度）。
4.  `spread`，可选，阴影尺寸。
5.  `color`，可选，阴影的颜色。
6.  `inset`，可选，将外部阴影改为内部阴影，`outset`外阴影、`inset`内阴影。

>   注意：
>
>   1.  默认盒子阴影是`外阴影`，但是`不可以显示指定`，否则盒子阴影失效。
>   2.  盒子阴影不会占用盒子的空间。

##### 文字阴影

可以采用 `text-shadow` 设置文本阴影，有四个值，描述跟格子阴影类似，分别是：`h-shadow`、`v-shadow`、`blur`、`color`。





### 元素显示模式

元素显示模式就是元素（标签）以什么方式进行显示，比如：`div`标签自己独占一行可以称为块元素，一行可以放多个 `span`标签可以称为行内元素。

#### 块元素

块元素简单点解释就是当前元素独自占据一行的空间。常见的块元素：标题标签（`h1-h6`）、段落标签（`p`）、`div`标签、列表标签（`li、ol、ul`）等等。

**特点：**

1.  独占一行空间。
2.  可以控制宽度、高度、内外边距属性。
3.  宽度默认是容器（父级元素）的`100%`。
4.  是一个容器或者盒子，里面可以放置其他`行内元素`或者`块元素`。

>   **注意**：文字类标签（标题标签、段落标签）内`不能使用块元素`。

#### 行内元素

行内元素有点类似于盒子中的物品，一个盒子可以放一个或者多个物品，对应的一行也可以放置多个行内元素。常见的行内元素：文本标签（`strong 、b、em、i、del、s`等等）、超链接标签（`a`）、`span`标签。

**特点**

1.  一行可以显示多个行内元素。
2.  行内元素不能直接设置宽度和高度，设置是无效的。
3.  默认的宽度是行内元素`本身内容`的宽度。
4.  行内元素只能容纳`文本`或者`其他行内元素`。

>   **注意**：链接标签中不能再放置链接，但是可以放置`块级元素`

#### 行内块元素

行内块元素同时具有块元素和行内元素的特点，常见的行内块元素：图片标签（`img`）、表单元素（`input`）、表格标签（`td`）。

**特点**

1.  一行上可以显示多个行内块元素，每个元素之间会存在`空白缝隙`。
2.  默认宽度就是本身内容的宽度（行内元素的特点）。
3.  行内块元素的高度、宽度、内外边距都可以直接控制（块级元素的特点）。

#### 显示模式的转换

特殊情况下，可以通过 `display`属性将一个模式的元素转换为另一种模式，来使用另一种模式的特性，比如行内元素转换为块级元素。

-   :red_circle:`display: block;`，将某一种元素转换为块级元素。
-   `display: inline;`，将某一种元素转换为行内元素。
-   :red_circle:`display: inline-block;`，将某一种元素转换为行内块元素。



### 盒子模型

一个 HTML 网页上显示的内容都是由一个个大小不一的`盒子`组成，每个盒子中都包含自己独有的元素、样式。

CSS 盒子模型本质就是一个盒子容器，用来封装 HTML 元素的，主要包括：边框、内外边距、实际内容。

<img src="C:\Users\admin\Desktop\study-file\study-file\前端\img\format,f_auto.png" alt="img" style="zoom:67%;" />

#### 组成

-   边框（border），定义当前盒子的`形状`。

    边框样式主要由上下左右四条边组成，可以针对每条边设置不同的样式。

    -   top，上边框
    -   right，有边框
    -   left，左边框
    -   bottom，下边框

    常用属性：`border-width` 边框宽度（粗细），`border-style` 样式、`border-color` 颜色三部分组成。

    | 样式            | 含义                                                         |
    | --------------- | ------------------------------------------------------------ |
    | border-width    | 边框粗细，单位 px                                            |
    | border-style    | 边框样式，常用值为：none（无边框，默认值）、 solid（实线）、dotted（点线）、dashed（虚线）。 |
    | border-color    | 边框颜色                                                     |
    | border          | 简写，`粗细 样式 颜色`没有顺序。                             |
    | border-collapse | 控制边框之间距离，collapse 表示相邻的边框合并在一起。        |

    >   **边框会影响盒子的大小，如果对边框的粗细进行定义的话，那么实际的盒子大小 = 盒子原本大小 + ( 边框粗细 \* 2 )**

-   内容（content），盒子中内存的元素（html 标签）。

-   内边距（padding），定义盒子中内容与边框的距离。

    盒子的内边距存在上（top）、下（bottom）、左（left）、右（right）四种，可以分别设置不同的值。

    | 值的个数                     | 描述                                                         |
    | ---------------------------- | ------------------------------------------------------------ |
    | padding: 5px;                | 1个值，代表上下左右都有5像素内边距。                         |
    | padding: 5px 10px;           | 2个值，代表上下内边距是5像素，左右内边距是10像素。           |
    | padding: 5px 10px 20px;      | 3个值，代表上内边距5像素，下内边距20像素，左右内边距10像素。 |
    | padding: 5px 10px 20px 30px; | 4个值，上是5像素，右内边距10像素，下内边距20像素，左内边距30像素。 |

    >   简写的值顺序是按照`顺时针`的方式依次读取。
    >
    >   也可以直接设置某一边内边距距离，比如：padding-top（上边距）。
    >
    >   -   **内边距会影响盒子的大小，如果对内边距进行定义的话，那么实际的盒子大小 = 盒子原本大小 + ( 内边距 \* 2 )**
    >   -   **假如盒子不指定宽高的话，内边距不会把盒子大小撑开。**

-   外边距（margin），定义盒子和盒子之间的距离，简写的形式跟内边距一样。。

    盒子的外边距存在上（top）、下（bottom）、左（left）、右（right）四种，可以分别设置不同的值。

    **外边距合并问题**

    1.  相邻块元素垂直外边距合并，当上下两个块级元素（兄弟元素）的外边相遇时，假如上面元素有下外边距，下面元素有上外边距，会出现外边距合并的情况，会取`两者之间最大值`，其余的外边距样式会失效（覆盖掉）。

        ![image-20231126215803525](C:\Users\admin\Desktop\study-file\study-file\前端\img\image-20231126215803525.png)

        解决方法：只给一个块元素添加 margin（外边距）值。

    2.  嵌套元素垂直外边距合并（塌陷），对于两个嵌套关系的块级元素，父元素有上外边距同时子元素也有上外边距，此时两个上外边距会合并成一个最大值，父元素采用合并后的上外边距，子元素上外边距失效。

        <img src="C:\Users\admin\Desktop\study-file\study-file\前端\img\image-20231126215729339.png" alt="image-20231126215729339" style="zoom: 67%;" />

        解决方案：

        -   为父元素设置上边框。
        -   为父元素设置上内边距。
        -   父元素添加 `overflow: hidden;`。

    >   应用场景
    >
    >   将当前`块级元素`水平居中，需要满足两个元素：
    >
    >   1.  块级元素必须设置宽度。
    >   2.  块级元素的左右外边距都设置为 auto。
    >
    >   如果想让`行内元素`也有同样的效果，可以直接将当前行内元素的 `text-align: center;`。

##### 网页自带内外边距

某些网页元素会带有默认的内外边距，大小跟浏览器类型有关。在元素布局前，可以通过一些手段将默认的内外边距清除掉。

1.  使用全局选择器清除所有标签的内外边距。

    ```css
    * { padding: 0; margin: 0; }
    ```

    

>   **注意**：行内元素有兼容性问题，所以尽量只设置左右内外边距，不要设置上下内外边距。



### 浮动

网页布局的本质->用 CSS 来摆放盒子，把盒子摆放到相应的位置。

#### 网页布局基本准则

多个块级元素纵向排列使用标准流，横向排列使用浮动。



#### 传统布局方式

1.  普通流（标准流/文档流），就是按照元素规定好的默认方式排列，比如块级元素、行内元素、行内块级元素。
2.  浮动，可以改变元素的默认排列方式，
3.  定位

>   一个页面基本上都会同时采用三种布局方式进行页面布局。（移动端会有新的布局方式）

#### 使用

`float`，创建浮动框，将其移动到一边，直到左边缘或者右边缘触及包含块或另一个浮动框的边缘。值为：left，right，none.

代码示例：

```css
div {
	float: left;
}
```

#### 特性

1.  浮动元素会脱离标准流（脱标）。

    -   脱离标准流的控制（浮）移动到指定位置（动）。
    -   浮动的盒子`不会保留原先的位置`。

2.  浮动元素会一行显示，并且`顶部对齐`。

3.  浮动元素具有行内块元素特点。

4.  :red_circle: 浮动会压住盒子，但不会压住盒子中的内容：文字、图片。

    >   浮动最开始是为了实现**文字环绕**效果。

#### 浮动应用场景

1.  将多个块级元素一行排列显示（中间没有空隙）。
1.  浮动元素通常和标准流父元素同时使用，这样这个浮动元素只会在父元素盒子内移动。



>   注意：
>
>   -   一个元素浮动，最好其余的兄弟元素也要浮动。
>   -   如果当前元素浮动，相邻的后一个元素会占用当前元素在盒子中的位置，不会影响之前的元素。



#### 清除浮动

通常情况下，父元素不会给予高度，但如果子元素存在浮动样式的话，不会占用父元素的空间，会影响后面元素的排版。

-   清除浮动元素造成的影响。
-   如果父元素有高度的情况下，可以不用清除浮动
-   清除浮动后，父元素就会根据浮动元素自动检测高度。父元素有了高度，就不会影响下面的标准流。

**清除浮动样式**

代码示例：

```css
选择器 { clear: 属性值; }
```

属性值：`left`（清除左侧浮动）、`right`（清除右侧浮动）、`both`（清除两端浮动）



**方法**

1.  **额外标签法（隔墙法）**，在浮动元素后添加一个`空标签`，这个标签元素必须`是块级元素`，将浮动元素隔开。

    缺点：会出现很多无意义的标签，结构化差。

2.  **父级添加 `overflow`**，在父级元素中添加 `overflow: hidden;`样式，overflow 的样式值可以为：hidden、auto、scroll。

    缺点：不能显示溢出的部分。

3.  **父级添加 `after` 伪元素**，为父元素标签添加伪元素 `after`。代码示例：

    ```css
    .clearfix:after {
    	content: "";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    .clearfix {
        /* 兼容 IE6，IE7 */
        *zoom: 1;
    }
    ```

    

4.  **父级添加双伪元素**，为父元素添加 `before` 和 `after`两个伪元素，代码示例：

    ```css
    .clearfix:before,
    .clearfix:after {
    	content: "";
        display: table;
    }
    .clearfix:after {
        clear: both;
    }
    .clearfix {
        /* 兼容 IE6，IE7 */
        *zoom: 1;
    }
    ```

    

### 定位

应用场景：让某个元素可以自由的在一个盒子内移动位置，并且压住其他盒子。

#### 组成

定位 = 定位模式 + 边偏移（top、right、left、bottom）。

##### 定位模式

用于指定一个元素在文档中的定位方式。定位模式决定元素的定位方式，通过 `position` 属性设置，值位：

-   `static`：静态定位，按照标准流特性摆放位置，没有边偏移，静态定位在布局时很少用到，是**元素默认定位方式**。

-   `relative`：相对定位，元素在移动位置的时候，是相对于它原来的位置来说的。

    -   相对于自己原来的位置来移动的（移动位置的时候参照点是自己原来的位置）。
    -   原来的标准流的位置继续占有，后面的盒子仍然以标准流的方式对待它。（不脱标，继续保留原来位置）

-   `absolute`：绝对定位，在元素移动位置时，相对于它`父元素`来说。

    >   -   如果没有父元素或者父元素没有定位，则以浏览器为准定位（Document文档）。
    >   -   如果父元素有定位（相对、绝对、固定定位），则以最近一级的`有定位父元素`为参考点。
    >
    >   绝对定位元素居中，水平居中（**垂直居中类似**）：
    >
    >   1.  让定位元素占用父级元素的 `50%`。
    >   2.  让定位元素的左外边距为当前元素长度的一半：`margin-left: 50%;`

-   `fixed`：固定定位，以`浏览器可视窗口`为参照移动元素。

    -   跟父元素没有关系。
    -   不跟滚动条一起滚动。
    -   固定定位不在占有原先位置。

    >   固定定位小技巧，让元素一直固定在版心旁边：
    >
    >   1.  让固定元素先固定在整个浏览器可视区的左右 `50%`位置，比如：`left: 50%;`
    >   2.  再通过外边距控制固定元素，让固定元素处于版心的`50%`位置，比如：`margin-left: 50%;`

-   `sticky`：粘性定位，固定定位和相对定位的结合。

    -   以浏览器的可视窗口为参照点元素（固定定位）
    -   占有原先位置。（相对定位）
    -   必须添加位置样式值（top、left、right、bottom）其中一个才有效。

##### 定位叠放次序

在使用定位布局时，可能会出现盒子重叠的情况。通常会通过 `z-index`控制定位盒子的前后次序，提高层级，默认值是`auto`。

-   数值越大，盒子越高。
-   属性值相同时，后来者居上。
-   数字后面没有单位。
-   只有定位的盒子才会有`z-index`属性。

#### 特性

1.  设置了绝对定位和固定定位的行内元素，可以直接设置宽高。（类似于浮动特性）
2.  块级元素添加绝对定位和固定定位，如果不给宽高，默认宽高是内容的大小。



>   -   脱标盒子不会触发外边距塌陷：浮动元素、绝对定位、固定定位元素都不会触发外边距合并的问题。
>   -   绝对定位、固定定位会压住盒子的所有，包含盒子中的内容。



### 元素显示和隐藏

让一个元素在页面中显示或者隐藏起来。

1.  `display`，显示隐藏，设置一个元素如何显示。

    -   :red_circle: none：隐藏目标元素。
    -   block：除了将目标元素转换为块级元素外，还包含`显示元素`的意思。

    >   **display隐藏元素不会占有原来位置。**

2.  `visibility(可见性)`，显示隐藏

    -   visible：元素可视。
    -   hidden：元素隐藏。

    >   **visibility元素隐藏后还会占有原来的位置。**

    

3.  `overflow`，溢出显示隐藏，主要针对盒子中**溢出的内容**进行样式设置。

    -   visible：显示盒子中溢出的内容，会超出盒子的大小。
    -   hidden：隐藏盒子中溢出的内容。
    -   auto：以溢出的位置自动添加滚动条，不溢出不会显示滚动条。
    -   :red_circle:scroll：为溢出的内容提供**滚动条**，即使不溢出也会提供。

    >   如果有定位的盒子，overflow会把溢出的元素或者内容都会隐藏掉。



### 精灵图

主要针对是的**背景图片**，那些**不需要频繁更换**的图片。

**核心原理**：将网页中的一些小背景图整合到一张大图中，这样服务器只需要请求一次即可。

**作用**：为了减少服务器接收和发送请求的次数，提高页面加载速度。

#### 使用

通过`background—position`定位到精灵图中目标图片。

**注意事项**

1.  精灵图主要是对于小的背景图片使用。
2.  主要借助于背景位置实现。
3.  一般情况下精灵图都是负值。（网页坐标：`x轴`：左负右正，`y轴`：上正下负。）

**缺点**：

1.  精灵图片比较大。
2.  图片本身放大或者缩小会导致图片失真。
3.  一旦图片制作完毕想要更换非常复杂。

### 字体图标

**使用场景**：主要用于显示网页中通用、常用的一些小图标。

**好处**：

1.  轻量：图标字体要比图像占用小，一旦字体加载出来，图标就会马上渲染出来，减少服务器请求。
2.  灵活：本质是文字，可以随意改变样式，大小，颜色等等。
3.  兼容：支持所有浏览器。

字体图标使用：网上通常会有字体图标样式库，如果需要使用某个字体图标，只需要下载下来，引入到页面即可使用。

### 三角

网页中的一些常见的三角形，可以直接使用 CSS 画出来，比如下三角：

```css
div {
    width: 0;
    height: 0;
    border: 50px solid transparent;
    border-top-color: red;
}
```

>   如果需要当前盒子实现三角效果：
>
>   -   那么当前盒子**不能指定宽高**。
>   -   其余三边要透明。



##### 简单对话框案例

```html
<div class="one" style="position: relative;
            width: 100px;
            height: 200px;
            background-color: blue;">
        <span class="two" style="position: absolute;
            bottom: 100%;
            left: 10px;
            width: 0;
            height: 0;
            line-height: 0;
            font-size: 0;
            border: 5px solid transparent;
            border-bottom-color: blue;"></span>
</div>
```



### 用户界面样式

界面样式：更改一些用户操作样式，用于提高用户体验。

#### 鼠标样式

通过 `cursor`改变用户鼠标样式。值：

-   default：默认
-   pointer：小手
-   move：移动
-   text：文本
-   not-allowed：禁止



#### 表单样式

##### 表单轮廓

通过 `outline` 设置表单元素的轮廓线。取消文本框的轮廓线：

```html
<input type="text" style="outline: none;">
```



##### 防止文本域（表单域）拖拽

通过 `resize` 设置文本域元素的拖拽选项。取消文本域的拖拽：

```html
<textarea name="" id="" cols="30" rows="10" style="resize: none; outline: none;"></textarea>
```



### 小技巧

#### 单行文字垂直居中

让文字的行高等于块级元素的高度，可以让文字在当前块中垂直居中，说白了就是让文字的高度`顶满`盒子高度。

```css
div {
    line-height: 100%;
}
```



#### 设置元素垂直对齐方式

通过 `vertical-align`设置**行内元素**或者**行内块元素**垂直对齐方式。值：

-   baseline：默认，元素放在**父元素**的**基线**上。
-   top：把元素顶端与行中**最高元素**的**顶端对齐**。
-   middle：把此元素放置在**父元素的中部**。
-   bottom：把元素的顶端与行内**最低元素**的**顶端对齐**。



<img src="C:\Users\admin\Desktop\study-file\study-file\前端\img\image-20231216160051681.png" alt="image-20231216160051681" style="zoom:50%;" />

>   **注意**：正常情况由于元素垂直对齐方式的默认值是 `baseline`，如果当前父元素包含文字会导致当前元素与父元素**底部出现缝隙**（不考虑边距问题），此时可以采用改动当前元素垂直对齐方式来解决（或者将当前元素改为块级元素）。



设置图片和文字垂直居中：

```html
<div style="border: 2px solid red;">
        <img src="images/20130502185029_EkKYh.png" alt="" style="vertical-align: middle;">
        <span>hello world!</span>
</div>
```



#### 溢出文字显示方式

1.  单行文本溢出文字省略号显示

    ```css
    text {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    ```

>   -   `white-space: nowrap;`：强制一行显示文字。（默认是：`normal` 自动换行）
>   -   `overflow: hidden;`：超出的部分隐藏。
>   -   `text-overflow: ellipsis;`：超出文字用省略号代替。



2.   多行文本溢出文字省略号显示

>   多行文本溢出使用省略号显示有兼容性问题，适合移动端（是webKit内核）和 **webKit浏览器**。

```css
text {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}
```

>   -   `display: -webkit-box;`：弹性伸缩盒子模型显示。
>   -   `-webkit-line-clamp: 2;`：限制在一个块元素显示的文本行数。
>   -   `-webkit-box-orient: vertical;`：设置或检索伸缩盒子对象的子元素的排列方式。



#### 布局技巧

##### 外边距

如果一个块级元素内包含多个行内元素，并且行内元素带有边框和统一的浮动布局，会导致某条边出现**重叠问题**。简单点就是会导致某条边框的变粗。通常会采用**外边距负值**解决。

```css
test {
   float: left;
   border: 1px solid red;
   margin-left: -1px;
}
```

>   注意：
>
>   1.  要改变哪条边的外边距要看是**依赖哪边浮动**，如果是**块级元素**通常是改变`下边距`。
>   2.  外边距的值通常是边框的大小。
>   3.  如果当前有些伪类样式，此时会出现**目标边框消失**的问题，解决方式：
>       1.  提高当前元素的层级，比如使用**相对定位**。
>       2.  如果当前元素已经存在了相对定位，就使用 [z-index](#定位叠放次序) 提高当前元素的层级（默认是 auto）。



##### 文字围绕效果

**浮动** 起初就是为了实现文字环绕效果产生的。假设一个盒子中包含一个图片标签和一个文本标签：

1.  为当前图片添加浮动效果，此时图片标签的层级会变高，文本标签会移动到图片的**原先位置**。
2.  虽然文本标签出现了位置移动，但是其中的**文本内容**不会跟随盒子移动，会**环绕着浮动元素**显示。

>   **浮动元素不会压住文字**。



##### 行内块技巧

假设一个盒子中包含多个行内元素，并且需要将行内元素实现**水平居中**效果。解决方案：

1.  将行内元素转化为行内块元素（行内元素不能定义宽高）
2.  对父盒子添加 `text-align`样式（会将当前盒子内的内容和元素都水平对齐）。 

##### 三角强化

实现特殊三角形，比如直角三角型。解决方案（实现右直角三角形）：

```css
.test {
        width: 0;
        height: 0;
        line-height: 0;
        font-size: 0;
    	/* 为下边框或者上边框设值边框 */
        border-bottom: 100px solid transparent;
    	/* 为右边框设置值，注意因为是右直角所以不设置左边框的值 */
        border-right: 100px solid blue;
}
```

>   如果要实现等腰，直角这种特殊的三角形需要将在原有三角的情况下，**将其余某个或者多个边设为透明，并提高某个边的三角高度**即可实现。



##### CSS 初始化

在做页面样式布局时，通常都会先对网页整体进行样式初始化，防止**浏览器默认样式**影响整体布局。简单初始化样式代码：

```css
/* 浏览器默认内外边距初始化为 0 */
* {
    margin: 0;
    padding: 0;
}

/* 防止斜体标签倾斜 */
em,
i {
    font-style: normal;
}
/* 去除列表序号 */
li {
    list-style: none;
}
/* 去除图片边框和将图片改为中线水平对齐，防止图片和盒子出现缝隙 */
img {
    border: 0;
    vertical-align: middle;
}
/* 改变按钮鼠标样式为小手 */
button {
    cursor: pointer;
}
/* 去除链接标签下划线 */
a {
    color: #666;
    text-decoration: none;
}
/* 改变链接标签经过时的颜色 */
a:hover {
    color: #c81623;
}
/* 改变按钮和表单元素中 文字字体样式 */
button,
input {
    font-family: Microsoft YaHei, Heiti SC, tahoma, arial, Hiragino Sans GB, "\5B8B\4F53", sans-serif;
}

body {
    /* 抗锯齿性，防止文字放大后出现毛边 */
    -webkit-font-smoothing: antialiased;
    background-color: #fff;
    /* \5B8B\4F53 宋体，采用Unicode防止css解析中文时出现乱码 */
    font: 12px/1.5 Microsoft YaHei, Heiti SC, tahoma, arial, Hiragino Sans GB, "\5B8B\4F53", sans-serif;
    color: #666;
}
/*  */
.hide,
.none {
    display: none;
}
/* 清除浮动 */
.clearfix:after {
    visibility: hidden;
    clear: both;
    display: block;
    content: ".";
    height: 0;
}

.clearfix {
    *zoom: 1;
}
```



## CSS3 新特性

### 选择器

[属性选择器](#属性选择器)

[伪类选择器](#伪类选择器)

#### [伪元素选择器](#伪元素选择器)

##### 使用场景

1.  **引入字体图标**，简单案例：

    ```html
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <style>
        @font-face {
            font-family: 'icomoon';
            src: url('icomoon/fonts/icomoon.eot?p4ssmb');
            src: url('icomoon/fonts/icomoon.eot?p4ssmb#iefix') format('embedded-opentype'),
                url('icomoon/fonts/icomoon.ttf?p4ssmb') format('truetype'),
                url('icomoon/fonts/icomoon.woff?p4ssmb') format('woff'),
                url('icomoon/fonts/icomoon.svg?p4ssmb#icomoon') format('svg');
            font-weight: normal;
            font-style: normal;
            font-display: block;
        }
    
        div {
            position: relative;
            width: 300px;
            background-color: #bababa;
        }
    
        div::after {
            position: absolute;
            top: 1px;
            right: 10px;
            font-family: 'icomoon';
            content: '\ea3e';
        }
    </style>
    
    <body>
        <div>字体图标</div>
    </body>
    
    </html>
    ```

    

2.  **清除浮动**，简单示例：

```css
.clearfix:after {
	content: "";
    display: block;
    height: 0;
    clear: both;
    visibility: hidden;
}
.clearfix {
    /* 兼容 IE6，IE7 */
    *zoom: 1;
}

.clearfix:before,
.clearfix:after {
	content: "";
    /* 将当前盒子模型转化为表格，保证before和after两个盒子在同一行 */
    display: table;
}
.clearfix:after {
    clear: both;
}
```





>   伪类选择器、属性选择器权重都为10；
>
>   伪元素选择器权重为1；



### 盒子模型

CSS3 可以通过 `box-sizing` 来指定盒子模型，防止盒子设置了边框或者内边距导致盒子原本大小发生变动的情况。值为：

-   `content-box`，**默认值**，盒子的大小 = width + padding + border.
-   `border-box`，盒子大小（width） = padding + border. （前提是padding和border不会超过width大小，否则还是会变大）

### 函数

#### 滤镜

通过 filter 函数可以将图片或者颜色做**模糊**处理，值为函数：

-   url(10px)
-   burl()

>   函数参数为数值，数值越大，越模糊。

```css
.test {
    filter: burl(80%);
}
```



#### 计算

通过 calc 函数可以在设置一些 CSS 属性值进行计算操作（`+、-、*、/`），简单示例：

```css
.test {
    width: calc(100%-80px);
}
```



### 过渡

通过 `transition` 可以为属性设置过渡样式，包含四个值：过渡属性，花费时间，运动曲线，何时开始：

1.  过渡属性，当前要变化的 CSS 属性，比如宽度、高度、颜色、字体等等，如果想要变化所有可以设置为 `all`。
2.  花费时间，表示从原始状态过渡到变化之后状态所花费的时间，单位是 秒。
3.  运动曲线，默认是 ease ，linear 匀速、ease 逐渐慢下来、ease-in 加速、ease-out 减速、ease-in-out 先加速后减速，可以省略。
4.  何时开始，时间单位，默认是 0s，延迟属性，表示指定时间后触发过渡。

>   谁来变化，为谁**加过渡**。



###### 应用场景

1.  **进度条**，简单代码示例：

    ```css
    .test {
        width: 100px;
        height: 100px;
        background-color: blue;
        transition: width 0.3s, height 0.3s;
    }
    
    .test:hover {
        width: 200px;
        height: 200px;
    }
    ```




### 2D 转换

transform 转换可以实现元素的位移、旋转、缩放等效果。

`transform-origin`: 设置中心点位置

```css
test {
    /* 设置 x y 轴坐标点，可以设置像素、方位名词，默认是 （50% 50%） 元素中心点位置 */
    transform-origin: 20% 20%;
}
```



#### 移动

translate 使元素沿着X、Y轴移动，不会影响其他元素的位置。

```css
.test {
    transform: translate(100px,100px);
    transform: translateX(100px);
    transform: translateY(100px);
}
```

> translate 中的百分比单位是相对于`自身`元素的百分比。
>
> 对行内元素没有效果。



通过 `转换` 实现水平和垂直居中：

```css
.div1 {
    position: relative;
    height: 500px;
    width: 500px;
    background-color: red;
}

.div2 {
    /* 通过 tranform 实现水平和垂直居中 */
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    height: 200px;
    width: 200px;
}
```



#### 旋转

rotate 让元素在二维平面内顺时针或者逆时针旋转，rotate 里面只能跟度数，单位是 deg。

- 角度为正时，顺时针，反之亦然。
- 默认旋转的中心点是元素的中心点。

```css
.test {
    transform: rotate(50deg);
}
```



#### 缩放

scale 让元素放大或者缩小，不会影响其他元素。

- 默认以中心点进行放大或者缩小。
- 将宽和高设置为目标倍数计算方式：宽 \* 1，高 \* 1。
- 值没有单位，如果小于1则是缩小，如果大于1则放大（x,y都设置为1相当于不变）。

```css
.test {
    transform: scale(x,y);
    /* 保持原状 */
    transform: scale(1);
    /* 宽和高都放大2倍，*2 */
    transform: scale(2,2);
    /* 宽和高都缩小 0.2 倍 */
    transform: scale(0.2,0.2);
}
```



#### 综合写法

顺序：移动 旋转 缩放。

```css
test{
	transform: translate(20px,20px) rotate(50deg) scale(2);
}
```

> 顺序不对会影响转换的效果，当同时有位移和其他属性的时候，尽量将位移放到最前方。





### 动画

`animation` 动画，可以通过设置多个节点来精确控制一个或者一组动画，对比过渡来说，动画可以实现更多变化，更多控制，**连续播放**等等。

可以元素样式`逐渐变化`为新样式的动画效果，可以改变任意多个样式，可以改变多次。

**具体流程**：定义动画 -> 使用动画。

1. 定义动画，使用 `keyframes` 定义动画，类似定义类选择器。

    ```css
    @keyframes 动画名称 {
        0%{
            width: 100px;
        }
        100%{        
            width: 200px;
        }
    }
    ```

    > 0% 和 100% 称为动画序列。
    >
    > 0% 是动画的开始，100% 是动画的结尾；也可以使用 from 表示 0%，to 表示100%

2. 使用动画，通过 `animation-name: 动画名称;` 进行调用，通过 `animation-duration: 花费时间;` 控制转变时间区间。

    ```css
    test {
    	animation-name: test;
    	animation-duration: 1s;
    }
    ```

#### 常用属性

- @keyframes：定义动画
- animation：动画属性简写。
- animation-name：指定动画名称，**必须**。
- animation-duration：指定动画完成一个周期所需时间，**必须**。
- animation-timing-function：指定动画速度曲线，默认：`ease`。

    可以通过 steps 自定义步长，通过指定步长对动画流程完成平均分配。

    ```css
    test {
        animation-timing-function: steps(10);
    }
    ```

- animation-delay：指定动画何时开始，默认：0。
- animation-iteration-count：指定动画播放次数，默认：1，还有infinite。
- animation-direction：指定动画是否在下一周期逆向播放，默认：normal（正常），alternate：逆播放。
- animation-play-state：指定动画是否正在运行或者暂停，默认：running（运行），pause：暂停。
- animation-fill-mode：指定动画结束后状态，默认：backwards（回到起始），forwards：保持原状。

> 动画一来一回算播放两次效果。

<img src="./img/image-20240715202249044.png" alt="image-20240715202249044" style="zoom: 80%;" />

动画简写顺序：动画名称 花费时间 运动曲线 何时开始 播放次数 逆播放 结束状态。（不包含 animation-play-state）

```css
test {
    /* 除名称和花费时间外都可以省略 */
    animation: test 1s ease 1s infinite normal running forwards;
}
```





### 3D 转换

**web 三维坐标系**

- X轴：水平向右，右边延伸为正，左边为负。
- Y轴：水平向下，下边延伸为正，上边为负。
- Z轴：垂直屏幕，往外延伸为正，向里为负。

<img src="./img/image-20240716175813345.png" alt="image-20240716175813345" style="zoom:67%;" />

#### 3D 位移

`translate3d`可以在 2D 移动的基础上多加一个可以移动的方向，就是Z轴方向。

- `translateZ(100px)`：设置元素在Z轴上移动距离。
- `translate3d(100px,100px,100px)`：设置元素在x,y,z轴上移动的距离。

```css
test {
    transform: translateZ(100px);
    transform: translate3d(100px,100px,100px);
}
```

> 设置Z轴移动距离时尽量使用 px 做单位。

#### 3D 旋转

`rotate3d(x,y,z,deg)` 可以让元素在三维平面内沿着x，y，z轴或者自定义轴旋转。

```css
test {
	transform: rotateX(45deg);
	transform: rotateY(45deg);
	transform: rotateZ(45deg);	
    /* 沿着x轴旋转45度 */
	transform: rotate3d(1,0,0,45deg);	
}
```

> backface-visibility: hidden; 3D环境下元素背面朝向用户时是不可见的。

#### 透视

`perspective` 在2D平面产生近大远小的视觉效果，单位是 px。

<img src="./img/image-20240716181829835.png" alt="image-20240716181829835" style="zoom: 67%;" />

**透视一般写在被观察元素的父盒子上面**。

- d：表示视距，视距是一个人眼睛到屏幕的距离，视距越大，物体显示效果越小（眼睛离屏幕越远）。
- z：z轴，物体距离屏幕的距离，z轴值越大，看到的物体就越大。

#### 3D呈现

`transfrom-style` 3D呈现，用来控制**子元素**是否开启三维环境（默认：flat，子元素处于二维平面）。

```css
test {
	/* 开启3d环境 */
	transform-style: preserve-3d;
}
```





### 私有前缀

主要是为了兼容老版本的浏览器。

- -moz-：为了适配火狐浏览器。
- -ms-：为了适配IE浏览器。
- -webkit-：为了适配苹果、谷歌浏览器。
- -o-：为了适配Opera浏览器。

```css
test {
	-moz-transform-style: preserve-3d;
    -ms-transform-style: preserve-3d;
    -webkit-transform-style: preserve-3d;
    -o-transform-style: preserve-3d;
    transform-style: preserve-3d;
}
```


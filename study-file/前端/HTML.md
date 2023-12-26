## HTML

#### HTML语法规范

1.  HTML标签是由尖括号包围的关键词，例如`<html>`。
2.  HTML标签通常是成对出现的，例如`<html>`和`</html>`，通常称为双标签，第一个标签称为开始标签，第二个标签称为结束标签。
3.  有些特殊标签必须是单个标签，例如`<br />`，通常称为单标签。

**标签关系**

双标签之间的关系分为：包含关系和并列关系。

-   包含关系，类似于 `<head>`和`<title>`
-   并列关系，类似于 `<body>`和`<head>`



#### 基本结构标签

每个网页中都会包含一个基本结构标签，页面内容都是在这些基本标签上编写的。

-   `<html>`，HTML标签，根标签。
-   `<head>`，表示文档的头部，在head标签中必须设置title标签。
-   `<title>`，表示文档的标题，让页面拥有一个属于自己的网页标题。
-   `<body>`，表示文档的主体，元素包含文档的所有内容，页面内容基本都是放到body中。





#### 基本标签

`<!DOCTYPE html> `，文档声明标签，告诉浏览器这个页面的采用什么类型来显示，html默认指`HTML5`。

`<html lang="en">`，告诉浏览器或者搜索引擎这个是一个英文网站，本页面采用英文显示。如果想切换为中文：`lang="zh-Cn"`。

`<meta charset="UTF-8">`，标识当前文本的编码集。



##### SEO

SEO (Search Engine Optimization) 搜索引擎优化，是一种利用搜索引擎的规则提高网站在有关搜索引擎内自然排名的方式。

SEO 的目的是**对网站进行深度优化**，从而帮助网站获取免费的流量，进而在搜索引擎上提升网站的排名，提高网站的知名度。

页面必须具有三个标签会符合 SEO 优化：

-   `title`，网站标题，**不可替代**。是搜索引擎了解网页的入口和对网页主题归属的最佳判断点。**建议**：`网站名（产品名）- 网站的简单介绍`（尽量不超过30个汉字）。
-   `description`，网站说明，简单说明当前网站或者产品的业务功能。
-   `keywords`，网站关键词，最好限制为 6 ~ 8 个关键词，关键词之间用英文逗号分隔。

样例：

```html
<title>品优购 - 正品低价、品质保障、配送及时、轻松购物！</title>
<meta name="description"
      content="品优购-专业的综合网上购物商城，为您提供正品低价的购物选择、优质便捷的服务体验。商品来自全球数十万品牌商家，囊括家电、手机、电脑、服装、居家、母婴、美妆、个护、食品、生鲜等丰富品类，满足各种购物需求。" />
<meta name="Keywords" content="网上购物,网上商城,家电,手机,电脑,服装,居家,母婴,美妆,个护,食品,生鲜,京东" />
```



##### TDK











### 常用标签



#### 基本标签

`<!DOCTYPE html> `，文档声明标签，告诉浏览器这个页面的采用什么类型来显示，html默认指`HTML5`。

`<html lang="en">`，告诉浏览器或者搜索引擎这个是一个英文网站，本页面采用英文显示。如果想切换为中文：`lang="zh-Cn"`。

`<meta charset="UTF-8">`，标识当前文本的编码集。



#### 1.标题标签

都是双标签。

`<h1> - <h6>`，语义：网页标题，单词head的缩写

代码示例：

```htmL
<h1>一级标题</h1>
<h2>二级标题</h2>
<h3>三级标题</h3>
<h4>四级标题</h4>
```

>   特点：
>
>   -   加了标题标签的文字会变粗，字号变大。
>   -   文字独占一行

#### 2.段落、换行标签

-   `<p>`，双标签，`paragraph`段落标签，语义：可以将HTML文档分割为若干段落。代码示例：

    ```html
    <!-- p:段落标签 -->
    <p>段落标签，第一段</p>
    ```

    >   特点：
    >
    >   -   文本内容会根据标签页窗口大小自动换行
    >   -   段落和段落之间保留空隙。

-   `<br>`，`break`换行标签，语义：强制换行。代码示例：

    ```html
    <!-- p:段落标签 -->
    <p>段落标签，第一段</p>
    <br />
    ```

    >   特点：
    >
    >   -   单标签
    >   -   只是对文档内容做另起一行操作，不会新创建一个段落。

#### 3.文本格式化标签

双标签，标签语义：突出重要性，比普通文本更重要。

-   加粗，`<strong>`、`<b>`，推荐使用strong。
-   倾斜，`<em>`、`<i>`，推荐使用em。
-   删除，`<del>`、`<s>`，推荐使用del。
-   下划线，`<ins>`、`<u>`，推荐使用ins。

#### 4.div和span标签

-   **块级元素 vs. 行内元素：**

    -   `<div>` 是块级元素，它独占一行，可以设置宽度、高度以及边距等样式属性。它适合用于创建页面的大块结构，例如页面的主体区域、容器、布局等。
    -   `<span>` 是行内元素，它不会独占一行，宽度默认由其内容决定。它适合用于对文本或其他行内元素进行样式化、标记或包裹。

    **默认样式和布局：**

    -   `<div>` 元素的默认样式为块级显示，会以块的形式占据可用空间。
    -   `<span>` 元素的默认样式为行内显示，它不会独占一行，只占据其内容的宽度。

    **嵌套关系：**

    -   <div> 可以容纳其他块级元素和行内元素，包括其他的 <div> 和 <span> 元素。

    -   `<span>` 通常被用来包裹文本或其他行内元素，比如用来设置特定文本的样式。

    总之，`<div>` 用于创建页面结构和布局，而 `<span>` 用于对文本或行内元素进行样式化或包裹。它们在页面设计和样式设置中有不同的用途和作用。

代码示例：

```html
<div>
    容器1
    <span>子容器1.1</span>
</div>
<div>
    容器2
    <span>子容器2.1</span>
</div>
```



#### 5.图像标签

`<img> (image)`标签用于在HTML页面中插入图像信息，单标签。

包含属性：

-   `src`，必须属性，指定图像文件的路径和文件名。
-   alt，替换文本，当图片不能正常显示时用文本代替。
-   title，提示信息，鼠标移动到图片上时显示的信息。
-   width，图片宽度。
-   height，图片高度。
-   border，图片像素，边框粗细。

代码示例：

```html
<img src="5d2a97c4b68341088876b4b5f2117107!400x400.jpeg" alt="头像" title="头像" style="border: 1000px;">
```



>   注意：
>
>   1.  属性必须位于标签上。
>   2.  属性之间没有先后顺序，属性之间用空格分开。
>   3.  属性采用key-value形式赋值。



#### 6.路径

路径主要分为相对路径、绝对路径。

-   相对路径，相对于当前文件的目标文件位置，以当前文件位置为基础。示例：`images/test.img`
-   绝对路径，目标文件在本地文件系统中的路径。示例：`D:/test/test.img`

>   绝对路径基本都是以盘符或者根目录开始。



#### 7.超链接标签

`<a>`双标签，标签主要用于定义超链接，将一个页面链接到另一个页面。

属性：

-   href，必须属性，跳转目标必须是一个url地址。
-   target，目标窗口的弹出方式，新窗口（`_blank`）、当前窗口（`_self`）默认值。

语法规范：

```html
<a href="http://www.baidu.com" target="_blank">文本信息</a>
```

分类：

-   外部链接，href指定的是一个url地址。

-   内部链接，href指定当前网站中其他HTML页面。

-   空链接，href的值为`#`，默认跳转到当前网页的顶部。

-   下载链接，href指定一个文件，比如exe文件，zip压缩包等等，不是一个前端文件。

-   锚点链接，href的属性值是 `#标签名/唯一标识` ，这个标签名当前网页中目标标签的名字，代码示例：

    ```html
    <a href="#s">锚点链接</a>
    <h2 id="s">锚点</h2>
    ```

    

-   网页元素链接，主要是以当前网页中一个特殊的形式（元素）来表示链接，可以是一个图片、文本、视频、表格等等。代码示例：

    ```html
     <a href="http://www.baidu.com" target="_top">
        <img src="images/test.jpeg" alt="头像" title="头像"/>
     </a>
    ```



#### 9.特殊字符

虽然 html 不区分大小写，但实体字符对大小写敏感。

<img src="C:\Users\admin\Desktop\study-file\study-file\前端\img\image-20231123170236406.png" alt="image-20231123170236406" style="zoom: 80%;" />



### 表格标签

表格标签主要是用来显示数据。

#### 1.表格基本标签

-   `<table>` 是用来定义表格的标签，**属性**：
    -   align，表格在当前网页的对齐方式，left、center、right。
    -   border，表格的边框，1表示有边框，`""`默认值表示没有。
    -   cellpadding，单元格中文本与边框的空白，默认1像素。
    -   cellspacing，单元格之间的空白，默认2像素。
    -   width，表格的宽度。
-   `<th>` 用来定义表格的表头，
-   `<tr>` 是用来定义表格中的行，
-   `<td>` 是用来定义表格中的列

包含关系：table >  tr > th = td

代码示例：

```html
<table align="center" border="1" cellpadding="5px" cellspacing="0px" width="500">
        <tr>
            <th>表头</th>
            <th>表头</th>
            <th>表头</th>
            <th>表头</th>
        </tr>
        <tr >
            <td>单元格1</td>
            <td>单元格2</td>
            <td>单元格1</td>
            <td>单元格2</td>
        </tr>
</table>
```

#### 2.表格结构标签

处于 `<table>`表格标签中。

-   `<thead>`，表示表格头部区域，内部必须拥有 `<tr>` 标签，一般位第一行。
-   `<tbody>`，表示表格主体区域。

代码示例：

```html
<table align="center" border="1" cellpadding="5px" cellspacing="0px" width="500">
    <thead>
        <tr>
            <th>表头</th>
            <th>表头</th>
            <th>表头</th>
            <th>表头</th>
        </tr>
    </thead>
    <tbody>
        <tr >
            <td>单元格1</td>
            <td>单元格2</td>
            <td>单元格1</td>
            <td>单元格2</td>
        </tr>
    </tbody>
</table>
```



#### 3.单元格合并

**方式**：

-   跨行，rowspan="合并个数"，以当前单元格向下合并。
-   跨列，colspan="合并个数"，以当前单元格向右合并。

代码示例：

```html
<table align="center" border="1" cellpadding="5px" cellspacing="0px" width="500">
        <thead>
            <tr>
                <th >表头1</th>
                <th colspan="2">表头2</th>
                <th>表头3</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>单元格1</td>
                <td rowspan="2">单元格2</td>
                <td>单元格3</td>
                <td>单元格4</td>
            </tr>
            <tr>
                <td>单元格1</td>
                <td>单元格3</td>
                <td>单元格4</td>
            </tr>
        </tbody>
</table>
```



### 列表标签

列表主要是用来对页面进行布局，让显示内容整齐、有序。

>   `list-style: none;`清除列表序号。

#### 1.无序列表

`<ul>`表示HTML中的无序列表，`<li>`标签表示列表中的每一行。

>   特点：
>
>   -   无序列表的各个列表项没有顺序之分，是并列的。
>   -   ul标签中只能包含li标签，li标签中可以包含任何元素
>   -   无序列表会带有自己的样式属性，可以通过css设置。

代码示例：

```html
<ul>
    <li>1</li>
    <li>2</li>
    <li>3</li>
    <ul>
        <li>a</li>
        <li>b</li>
        <li>c</li>
    </ul>
</ul>
<ul>
        <li>a</li>
        <li>b</li>
        <li>c</li>
</ul>
```



#### 2.有序列表

`<ol>`标签定义有序列表，列表按数字或字母进行排序，使用 `<li>`表示列表的一行，类似于无序列表。代码示例：

```html
<ol>
    <li>a</li>
    <li>b</li>
    <li>c</li>
</ol>
```



#### 3.自定义列表

常用于对术语或者名词进行解释和描述，定义列表的列表项前没有任何项目符号。

`<dl>`用于定义描述列表， `<dt>`用来表示列表的项目，`<dd>`用来表示列表中项目的描述项。

>   特点：
>
>   -   dl 标签中只能包含 dt 标签和 dd 标签。
>   -   dt 标签和 dd 标签的个数没有限制。
>   -   dt 标签和 dd 标签中可以放置任何元素。

代码示例：

```html
<dl>
        <dt>名词</dt>
        <dd>解释1</dd>
        <dd>解释2</dd>
        <dd>解释3</dd>
        <dd>解释4</dd>
</dl>
```



### 表单标签

主要用于收集和传递信息，一个正常的表单主要有三部分组成：表单域、表单控件（表单元素）、提示信息。



#### 1.表单域

包含表单元素的区域，HTML中使用 `<form>`来表示一个表单域，进行信息的收集和传递，`<form>`标签会把当前区域内的表单元素信息提交到服务器。

**属性**：

-   action，提交的目标地址，是一个url地址。
-   method，提交的方式，可以是get、post等。
-   name，当前表单域的名称。

代码示例：

```html
<form action="" method="get" name="表单1">
</form>
```



#### 2.表单控件

-   ##### input 输入框

    input 输入信息，input 标签包含一个 `type`属性，根据不同的属性值来表示不同的输入框类型，比如：密码、文本、复选框、按钮等等。

    **属性**：

    -   **type 类型**

        | 类型     | 描述                                               |
        | -------- | -------------------------------------------------- |
        | button   | 普通按钮。                                         |
        | checkbox | 复选框，如果是多个要通过 name 属性进行类别区分。   |
        | file     | 文件上传控件。                                     |
        | hidden   | 隐藏输入框。                                       |
        | image    | 图像提交按钮。                                     |
        | password | 密码输入框。                                       |
        | radio    | 单选按钮，如果是多个要通过 name 属性进行类别区分。 |
        | reset    | 重置按钮。                                         |
        | submit   | 提交按钮。                                         |
        | text     | 文本输入框，默认支持20个字符。                     |

        >   注意：如果想让一个表单元素在提交过程中不发送到后台，那就不要加 name 属性，不然在提交时会将表单元素的value属性一起带到后台

    -   name，用于指定 input 元素的名字，同种类型的多个单选框或者复选框，name 值要一致。

    -   value，规定 input 元素中的内容，例如单选框，如果选中的话会在提交时将当前单选框的value值发送到后台。

    -   checked，规定当前表单首次加载时是否被选中，只要值不为空即可实现效果。

    -   maxlength，输入字符的最大长度。

    代码示例：

    ```html
    <form action="hello-word.html" method="get" name="表单1">
            用户名： <input type="text" name="username" value="请输入用户名" maxlength="10" /> <br>
            密码： <input type="password" name="username" value="请输入密码" maxlength="10" /> <br>
            <span>
                文件上传：<input type="file" name="file" value="文件上传" /><br>
            </span>
            <input type="image" value="图像提交按钮" /><br>
            性别：
            男： <input type="radio" name="sex" value="男" />
            女： <input type="radio" name="sex" value="女" />
            未知： <input type="radio" name="sex" value="未知" /><br>
            <input type="hidden" name="hidden" value="隐藏框" /><br>
            复选框 <input type="checkbox" name="ext" value="复选框1" />
            复选框 <input type="checkbox" name="ext" value="复选框2" />
            复选框 <input type="checkbox" name="ext" value="复选框3" />
            复选框 <input type="checkbox" name="ext" value="复选框4" />
            复选框 <input type="checkbox" name="ext" value="复选框5" checked="checked" /><br>
            <input type="reset" value="重置按钮" />
            <input type="submit" value="提交按钮" />
            <input type="button" value="普通按钮" /> <br>
        </form>
    
    ```

    **label 标签**

    主要是为 input 标签进行标注处理，需要绑定一个 input 标签，当光标悬停到 label 标签中的文字时，自动选择对应的表单元素。

    通过 for 属性来指定对应的表单元素 id。代码示例：

    ```html
    <label for="text">用户名</label>
    <input id="text" type="text" name="username" value="请输入用户名" maxlength="10" /> <br>
    ```

    

-   ##### select 下拉框

    如果当前信息有多种，并且想要节约页面空间，可以使用 select 下拉框对信息进行列表管理。每个下拉项通过 option 标签进行定义。

    select 标签属性：name，当前下拉框对应属性名称。

    option 标签属性：

    -   value：当前下拉项的值，如果选中可以将 select 标签的值置为当前下拉项标签的 value。
    -   selected：定义当前下拉项是否是下拉框的默认值，如果不定义默认下拉框中第一项是默认值。

    代码示例：

    ```html
    <label for="select">下拉框</label>
            <select name="select" id="select">
                <option value="1" selected>1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
    </select>
    ```

-   ##### textarea 文本框

    主要是用来输入文本内容，可以通过属性设置文本输入行数和每行字符数量。

    属性：

    -   cols：限制每行字符数量。
    -   rows：限制文本框中行数。

    代码示例：

    ```html
    <label for="content">文本框</label>
    <textarea name="content" id="content" cols="30" rows="10">
    ```



## HTML5 新特性

>   会有兼容性问题，IE9+以上浏览器才支持。

### 新增布局标签

#### 语义化标签

之前要定义某一区域或者盒子时，通常会使用 div 来定义，如果一个页面中包含多个区域会导致 div 标签过多，并且 div 标签本身是不带语义的。HTML5 对 div 做了一些简单实现，提供了一些带语义的区域标签：

1.  头部标签 `<header>`
2.  导航标签 `<nav>`
3.  内容标签 `<article>`
4.  区域标签 `<section>`
5.  侧边栏标签 `<aside>`
6.  尾部标签 `<footer>`

新版页面布局简单示例：

<img src="C:/Users/admin/Desktop/study-file/study-file/前端/img/image-20231217145710112.png" alt="image-20231217145710112" style="zoom: 40%;" />

>   **注意**
>
>   -   这种语义化标准是针对搜索引擎的。
>   -   这种语义化标签可以使用多次。
>   -   在 IE9+ 中，需要将这些元素转化为块级元素。



#### 多媒体标签

通过这两个多媒体标签，可以在页面中嵌入音频和视频，不需要再用 flash 或者浏览器插件。

##### 音频 `<audio>`

当前 audio 标签只支持三种音频格式：

-   MP3：支持各种浏览器。
-   Wav：不支持 IE 浏览器。
-   Ogg：不支持 IE 浏览器和 Opera 浏览器。



**常用属性**

1.  autoplay：自动播放，值为 autoplay。

    >   Chrome 默认禁用自动播放。

2.  controls：播放控件，值为 controls

3.  loop：是否循环播放，值为 loop。

4.  src：音频url地址。



##### 视频 `<video>`

当前 video 标签只支持三种视频格式：

-   MP4：支持各种浏览器。
-   WebM：支持Chrome、Firefox、Opera。
-   Ogg：支持Chrome、Firefox、Opera。



**常用属性**

1.  autoplay：视频加载完成后是否自动播放，值为 autoplay。
2.  controls：播放控件，值为 controls
3.  width：视频播放器宽度。
4.  height：视频播放器高度。
5.  loop：是否循环播放，值为 loop。
6.  preload：是否预加载视频，如果设置了自动播放此属性**无效**，值为 auto（预先加载）、none。
7.  src：视频url地址。
8.  poster：加载等待图片url地址。
9.  muted：静音播放，值为 muted。





>   视频标签和音频标签会存在浏览器兼容性问题，如果要使用通常的解决方案是在 video 标签内添加 source 标签，比如：
>
>   -   `<source src="xxx.mp4" type="video/mp4"/ >`
>   -   `<source src="xxx.mp3" type="audio/mp3"/ >`



### 新增表单标签

-   email：限制输入必须为邮箱。
-   url：限制输入必须为url。
-   date：限制输入必须为日期。
-   time：限制输入必须为时间。
-   month：限制输入必须为月份。
-   week：限制输入必须为周。
-   number：限制输入必须为数字。
-   tel：限制输入必须为手机号。
-   search：搜索框。
-   color：颜色选择器。

### 新增表单属性

-   required：表示当前表单元素的内容**必填**，值为 required。
-   placeholder：表单提示信息，存在默认值时不提示。
-   autofocus：自动聚焦属性，页面加载完成自动聚焦到指定表单，autofocus 自动聚焦。
-   autocomplete：是否联想之前输入过的值，要求当前表单元素存在 name 属性，并且之前**成功提交**过，off 关闭，on 打开。
-   multiple：针对文件表单元素，是否支持多选。
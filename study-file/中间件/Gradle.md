## Gradle

1.gradle脚本内容

- 插件引入：声明所需的插件
- 属性定义（可选）：定义扩展属性
- 局部变量（可选）：定义局部变量
- 属性修改（可选）：指定project自带属性
- 仓库定义：指明要从哪个仓库下载jar包
- 依赖声明：声明项目中需要那些依赖
- 自定义任务（可选）：自定义一些任务

```groovy
//定义扩展属性（给脚本用的脚本）
buildScript{
    repositories{
        mavenCentral()
    }   
}

//应用插件，这里引入gradle的Java插件，此插件提供Java构建和测试所需的一切
apply plugin:'java'
//定义扩展属性（可选）
ext{
    foo="foo"
}

//定义局部变量（可选）
def bar="foo"

//修改项目属性（可选）
group 'pkap'
version '1.0-snapshot'

//定义仓库，gradle可以使用maven库，ivy库，私服，本地文件
repositories{
    jcenter()
}

//定义依赖，这里采用g:n:v简写方式，加号代表最新版本（可选）
dependencies{
    compile group: 'commons-net', name: 'commons-net', version: '3.6'
}

//自定义任务（可选）
task printFoobar{
    println "${foo}_${bar}"
}
```


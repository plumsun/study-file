# SpringBoot

### 1.概念

```markdown
springBoot是spring的子项目，核心思想是自动装配，通过springboot能够快速整合第三方框架，无需重复编写繁重的spring配置，降低了使用的成本，并且内置了Tomcat服务器
```

### 2.核心思想

```markdown
大致分为以下6点：
    1.独立运行：springboot可以以jar包的形式独立运行
    2.内置容器：springboot可以选择内嵌Tomcat，jetty或者undertow服务器
    3.简化配置：提供基础的pom文件简化maven配置
    4.自动配置：根据项目依赖来自动配置spring框架，极大地减少了项目使用的配置
    5.提供生产就绪型功能：提供可以在生产环境下使用的功能，性能指标，应用信息和应用健康检查
    6.无代码生成和xml配置：不生成代码，无需xml配置即可实现spring的所有配置
```

### 3.springBoot和springMVC，spring的区别

```markdown
1.spring框架就像一个家族，拥有众多的衍生品如boot，security,jpa。
2.而springMVC是spring基础上的一个mvc框架，主要负责处理web开发的路径映射与视图渲染，属于spring框架中web层开发的一部分
3.springBoot也是spring的一个mvc框架，主要功能就是简化开发者的使用，使开发者无需重复编写spring配置降低了成本，跟springmvc的主要区别是，springboot专注于单体微服务接口开发，和前端解耦。
```

### 4.依赖导入的两种方式

```xml
<!--第一种,通过springboot-parent依赖来维护依赖的版本信息-->
<parent></parent>
<!--第二种，通过引入spring-boot-dependencie依赖维护当期项目的依赖版本信息-->
<dependencyManagement></dependencyManagement>
```

### 5.配置文件加载优先级

```markdown
对于springboot应用，默认的配置文件根目录下的application配置文件，可以是properties格式，也可以是yaml格式
当引入spring-cloud-context依赖后，会进行加载根目录下得到bootstarp配置文件
这个配置文件是由父类applicationcontext加载，比application优先加载，并不会被覆盖
使用springcloud配置中心时，需要在bootstarp配置配置中心的地址，从而实现applicationcontext加载时，从配置中心加载配置信息
```

### 6.profile用来完成不同环境下配置动态切换。

```markdown
spring.profile.active:
```



### 7.读取配置方式

```markdown
1.environment:environment.getProperty("配置名")获得application.yml中的配置信息
2.@Value:支持和@PropertySource注解一起使用，指定使用配置文件
3.@ConfigurationProperties:@ConfigurationProperties(prefix="config-properties"),配合@EnableConfigurationProperties(value=ConfigInfo.class)，开启自动配置，装配ConfigInfo的实例化对象，并且交予spring管理，在下面直接使用@Autowired注入configInfo对象
```

### 8.自动装配流程

```markdown
1.系统加载@SpringBootApplication然后加载@EnableAutoConfiguration
2.@EnableConfiguration是开启核心配置的注解，注解上@Import({AutoConfigurationImportSelector.class})
3.AutoConfigurationImportSelector中getCandidateConfigurations(annotationMetadata,attributes)加载所有配置
4.getCandidateConfigurations底层中使用loadSpringFactories()方法
5.而这个方法会通过类加载器去META-INF/spring.factories中加载已配置好的信息，因此使用springboot自动配置的关键有两点：
	a.启动器starter
		要想自动配置生效，只需要引入springboot提供的starter（启动器）即可，springboot会自动管理依赖及版本信息
	b.全局配置yml文件
		springboot的默认配置，都会读取默认配置,而这些属性可以通过自定义application.yml文件来进行覆盖，这样虽然使用的还是默认配置，但是配置中的值已经是我们自定义的
```

### 9.启动流程

```markdown
1.创建springApplication实例，并调用run方法
2.创建springApplication实例主要完成三件事
	1.记录当前自动字节码
	2.判断当前项目类型，普通Servlet，响应WebFlux,NONE
	3.加载/META-INF/Spring.factories文件，初始化ApplicationContextInitializer和ApplicationListener实例
3.而后会调用run方法创建spring容器，执行流程如下：
	1.准备监听，监听spring启动的各个过程
	2.创建并配置环境参数Environment
	3.创建ApplicationContext上下文对象
	4.调用prepareContext()方法初始化上下文对象，准备运行环境
	5.执行refreshContext(上下文对象)准备Bean工厂，这个方法底层调用了一个BeanDefinition和BeanFactory的后处理器，初始化各种bean,初始化Tomcat
	6.后面还会执行一个afterRefresh():这个方法主要是为了加载扩展
	7.最后发布容器初始化完毕的事件
```


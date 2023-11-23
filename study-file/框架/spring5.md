

# spring





## 1.spring概述

spring是一个开源免费的框架(容器)，是一个轻量级、非入侵式的框架，支持事务处理，对框架整合的支持.Spring首先它是一个开源而轻量级的框架。其核心容器的主要组件是Bean工厂（BeanFactory）。Bean工厂使用控制反转（IOC）模式来降低程序代码之间的耦合度，并提供了面向切面编程（AOP）的实现。

-   控制反转(IOC)，将bean（对象）的创建过程交给spring管理。

-   面向切面编程(AOP)，在不修改源码的情况下对方法进行增强。

#### bean初始化流程

-   实例化bean对象(通过构造方法或者工厂方法)
-   设置对象属性(setter等)（依赖注入）
-   如果Bean实现了BeanNameAware接口，工厂调用Bean的setBeanName()方法传递Bean的ID。（和下面的一条均属于检查Aware接口）
-   如果Bean实现了BeanFactoryAware接口，工厂调用setBeanFactory()方法传入工厂自身
-   将Bean实例传递给Bean的前置处理器的postProcessBeforeInitialization(Object bean, String beanname)方法
-   调用Bean的初始化方法
-   将Bean实例传递给Bean的后置处理器的postProcessAfterInitialization(Object bean, String beanname)方法
-   使用Bean
-   容器关闭之前，调用Bean的销毁方法

#### Bean的作用域

```properties
singleton:单例模式
prototype:多例模式
request:每次请求共享一个bean
session:同一个session共享一个bean
globalSession:全局作用域，作用于容器整个上下文对象
```





## springIOC、AOP

```markdown
1. AOP:
		为面向切面编程，是通过预编译方式和运行期动态代理实现程序功能的统一维护的一种技术。利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。简单来说，就是在不修改原代码码的情况下对方法进行功能增强。
2. IOC
		在传统的程序设计中，如果在web层要调用service层的方法，就必须在web层主动创建service层实现类对象，但是在spring中，创建对象的工作不再由调用者主动完成，而是把创建对象的控制权交给spring的bean工厂， 调用者只负责接收这个对象。
```



### IOC

控制反转，是面向对象设计的一种思想，基于ioc容器完成对象的管理。在spring中ioc的实现是把对象的创建、对象之间的联系、调用交给BeanFactory,ApplicationContent进行管理

**好处**：

-   降低了类与类之间的耦合度。
-   不需要开发者再显示的维护对象的创建过程。

#### 底层原理

spring中的ioc主要是通过xml文件、工厂设计模式、反射实现。

1.  在bean.xml文件中定义需要使用的bean对象
2.  在工厂类中解析对应的bean.xml文件，获取定义的对象的字节码文件地址
3.  通过对象的字节码文件路径获取class对象，创建一个对应的类实例。

SpringIOC针对对象创建有两种方式：

1.  `BeanFactory`，IOC容器的基本实现，是Spring内部使用接口，不建议开发人员使用。采用懒加载思想，在加载xml配置文件时不会创建对象，只有在获取对象或者使用对象时才会动态创建。
2.  `ApplicationContent`，`BeanFactory`的子接口，提供的api功能比`BeanFactory`更全面，建议开发人员使用。采用饥饿加载，在加载xml配置文件时就会创建对象。

#### 创建bean

##### 1.构造方法

```markdown
class属性指向bean的全限定路径或者实现类的全限定路径，底层通过反射机制,调用对应bean的构造方法创建指定bean，默认情况下使用无参构造
```

**配置文件**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	
    
    <bean id="UserMapper" class="com.demo.dao.impl.UserMapperImpl"/>
    
    <bean id="UserServiceDao" class="com.demo.service.impl.UserServiceDaoImpl">
        <constructor-arg name="name" value="李四"/>
        <!--指定引用类型属性的值-->
        <constructor-arg name="userMapper" ref="UserMapper"/>
    </bean>
</beans>
```



##### 2.静态实例工厂

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	
    <bean id="指定bean" class="com.demo.Utils.FactoryUserMapper" factory-method="getUserMapper2"/>
    <!--
		factory-method:指定工厂类中创建类的静态方法
	-->
</beans>
```



##### 3.动态实例工厂

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	
    <bean id="工厂对象的标识" class="工厂类"></bean>
    <bean id="指定bean" factory-bean="工厂对象" factory-method="工厂对象的动态方法"></bean>
</beans>
```





##### 基于xml

**解析配置文件API**

| 名字                   | 单例                            | 多例                |
| ---------------------- | ------------------------------- | ------------------- |
| **ApplicationContext** | **spring容器初始化时,创建bean** | 调用方法时,创建bean |
| **BeanFactroy**        | **调用方法时,创建bean**         | 调用方法时,创建bean |



##### bean标签

**属性**

```markdown
id:bean的唯一标识
class:指定对象的全限定路径
init-method:bean创建时调用方法
destroy-method:bean销毁时调用方法
scope:实例模式
	singleton :单例模式
	prototype :多例模式
```

**子标签constructor-arg**

```markdown
在配置文件确定成员变量的三种方式:
    name:指定成员变量名
    type:指定成员变量类型
    index:指定成员变量所在索引位置
赋值:
	value:基本类型的属性赋值
	ref:引用类型的属性赋值,来自于spring创建的对象的唯一标识
```

**子标签property**

```markdown
name:指定成员变量名
value:基本类型的属性赋值
ref:引用类型的属性赋值,来自于spring创建的对象的唯一标识
```

**生命周期**

```markdown
1.多例
    创建:spring容器创建,bean创建
    销毁:spring容器销毁,bean不会销毁(不会调用destroy方法)
2.单例
    创建:spring容器创建,bean创建
    销毁:spring容器销毁,bean销毁(调用destroy方法)


注意:这里的对象销毁并不是真正的销毁,而是依据destroy-method指定的方法是否被调用,
bean的销毁需要gc处理,不能手动销毁
```



### Spring依赖注入 DI

*创建对象的方式都是使用xml配置文件*

#### 基于配置文件

##### 1.通过有参构造

**dao层**

```java
// dao层
package com.demo.dao;

public interface UserMapper {
	
}

// dao实现类
package com.demo.dao.impl;

import com.demo.dao.UserMapper;

public class UserMapperImpl implements UserMapper {
	
}
```

**service层**



```java
package com.demo.service;

public interface UserService {
    void getUserService();
    void show();

}

// 实现类
package com.demo.service.impl;

import com.demo.service.UserService;

public class UserServiceImpl implements UserService {
    private String name;
    //dao层
    private UserMapper userMapper;

    
    //有参构造
    public UserServiceImpl(String name,UserMapper userMapper){
        
    }

	//展示成员变量中的值
    @Override
    public void show() {
        System.out.println(name+"="+userMapper);
    }
}

```



**配置文件**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="UserMapper" class="com.demo.dao.impl.UserMapperImpl"/>
    
    <bean id="UserService" class="com.demo.service.impl.UserServiceImpl">
        <constructor-arg name="name" value="李四"/>
        <!--指定引用类型属性的值-->
        <constructor-arg name="userMapper" ref="UserMapper"/>
    </bean>
</beans>
```

**测试类**

```java
import com.demo.dao.UserMapper;
import com.demo.service.UserServiceDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyTest05 {

    public static void main(String[] args) {
        /**
         * 通过有参构造依赖注入
         */
        //通过spring容器获取对象
        ApplicationContext context =
                new ClassPathXmlApplicationContext("classpath:UserBeans01.xml");
        UserServiceDao bean = (UserServiceDao) context.getBean("UserServiceDao");
        //打印获取到的对象
        System.out.println("bean = " + bean);
        //调用方法
        bean.show();//李四=com.demo.dao.impl.UserMapperImpl@55d56113
    }
}

```



##### 2.通过set方法

```java
// service层实现类
package com.demo.service.impl;

import com.demo.dao.UserMapper;
import com.demo.service.UserServiceDao;

public class UserServiceImplSet implements UserService {
    private String name;
    private UserMapper userMapper;

    public void setName(String name) {
        this.name = name;
    }

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public UserServiceImplSet() {
        System.out.println("对象创建成功");
    }

    //打印成员变量值
    @Override
    public void show() {
        System.out.println(name+"="+userMapper);
    }
}

```



**配置文件**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="UserMapper" class="com.demo.dao.impl.UserMapperImpl"/>
    
    <bean id="UserServiceDao" class="com.demo.service.impl.UserServiceImplSet">
		
        <!--
			name:1.类中有对应属性(set方法名去掉set之后的驼峰名字)
                 2.类中无对应属性(set方法名去掉set之后的名字)
		-->
        <property name="name" value="李四"/>
        <!--指定引用类型属性的值-->
        <property name="userMapper" ref="UserMapper"/>
    </bean>
</beans>
```



 **测试类**

```java
import com.demo.dao.UserMapper;
import com.demo.service.UserServiceDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MyTest05 {

    public static void main(String[] args) {
        /**
         * 通过有参构造依赖注入
         */
        //通过spring容器获取对象
        ApplicationContext context =
                new ClassPathXmlApplicationContext("classpath:UserBeans02.xml");
        UserServiceDao bean = (UserServiceDao) context.getBean("UserServiceDao");
        //打印获取到的对象
        System.out.println("bean = " + bean);
        //调用方法
        bean.show();//李四=com.demo.dao.impl.UserMapperImpl@a67c67e
    }
}

```

**简写方式**

```xml
<bean id="UserMapper" class="com.demo.dao.impl.UserMapperImpl"/>
<!-- set方式的依赖注入的简写：p名称空间，需要创建对应的set 方法，并引入 xmlns:p="http://www.springframework.org/schema/p" -->
<bean id="UserServiceDao" class="com.demo.service.impl.UserServiceImplSet"
          p:name="李四"
          p:userMapper-ref="UserMapper"
          />
<!-- 构造方式依赖注入的简写：c名称空间，需要创建有参构造方法 并引入 xmlns:c="http://www.springframework.org/schema/c" -->
<bean id="UserServiceDao" class="com.demo.service.impl.UserServiceImplSet"
          c:name="李四"
          c:userMapper-ref="UserMapper"
          />
```



**复杂类型注入**

```xml
<bean id="userService6" class="com.demo.service.impl.UserServiceImpl4">
    <property name="games">
        <list>
            <value>lol</value>
            <value>吃鸡</value>
            <value>王者荣耀</value>
        </list>
    </property>
    <property name="username">
        <set>
            <value>郑爽</value>
            <value>张恒</value>
        </set>
    </property>
    <property name="map">
        <map>
            <entry key="a" value="aa"></entry>
            <entry key="b" value="bb"></entry>
        </map>
    </property>
</bean>
```



##### JdbcTemplate案例

案例原型:

web层

```java
public class MyTest{
    private UserService service;
    
    @Before
    public void getService(){
        ApplicationContext context = new ClassPathXmlApplicationContext();
        service = (UserService) context.getBean("UserService");
    }
    
    @Test
    public void test(){
        List<User> users = service.findAll();
        System.out.println(users);
    }
}
```



service层

```java
public interface UserService{
    List<User> findAll();
}
public class UserServiceImpl implements UserService{
    
    private UserMapperDao dao;
    
    public void setDao(UserMapperDao dao){
        this.dao=dao;
    }
    
    @Override
    public List<User> findAll(){
        return dao.findAll();
    }
}
```



dao层

```java
public interface UserMapperDao{
    List<User> findAll();
}
```

```java
public class UserMapperDaoImpl implements UserMapperDao{
    
    private JdbcTemplate template;
    
    public void setTemplate(JdbcTemplate template){
        this.template=template;
    }
    
    @Override
    public List<User> findAll(){
        return template.query("select * from user",new BeanPropertyRowMapper<>(User.class));
    }
    
}
```



配置文件

```properties
jdbc.url=jdbc:mysql://localhost:3306/spring01?useUnicode=true&characterEncoding=utf8&useSSL=false
jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.username=root
jdbc.password=root
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">
    
    
    <!--引入外部配置文件-->
    <context:property-placeholder location="jdbc.properties"/>
    
    <!--通过 ${} 调用文件中的内容-->
    <bean id="dataSource" calss="org.springframework.jdbc.datasource.DriverManagerDataSource">
        <property name="url" value="${jdbc.url}" />
        <property name="driverClassName" value="${jdbc.driverClassName}" />
        <property name="username" value="${jdbc.username}" />
        <property name="password" value="${jdbc.password}" />
    </bean>
    
    <bean id="template" calss="org.springframework.jdbc.core.JdbcTemplate">
        <constructor-arg name="dataSource" ref="dataSource"/>
    </bean>
    
    <bean id="UserMapperDao" class="com.demo.dao.UserMapperDaoImpl">
        <property name="template" ref="template"/>
    </bean>
    
    <bean id="UserService" class="com.demo.service.UserServiceImpl">
        <property name="dao" ref="UserMapperDao"/>
    </bean>
    
</beans>
```



#### 基于注解

##### 创建对象

```css
@Component:	除了3层的对象创建,默认使用类名驼峰形式当做bean的唯一标识
@Controller: web表现层对象创建
@Service:	service业务层对象创建
@Repository: dao持久层对象创建
```

##### 依赖注入

```css
@Autowired:自动注入(自动通过属性类型到spring容器中寻找对应bean)
    若是找到多个同类型bean,通过属性名进行筛选一个进行注入.
    筛选不到,报错
@Qualifier:在Autowired的基础上,选择指定id的bean进行注入
@Resource(name = ""):整合Autowired和Qualifier,选择指定id的bean进行注入
@Value:注入基本数据类型
```



### bean的生命周期

```css
@Scope:bean实例模式
    prototype:多例
    singleton:单例
@PostConstruct:指定bean创建时调用的方法
@PreDestroy:指定bean销毁时调用的方法
```



### 纯注解

```css
@ComponentScan:注解扫描
@PropertySource:引入外部配置文件
@Configuration:声明配置类
@Bean:将返回值装配到spring容器(可以动态传参)
@Import:导入配置类
```



### 整合Junit

```css
@RunWith:替换运行器
@ContextConfiguration:指定配置类或者配置文件
```





### AOP(面向切面编程)

概念:通过动态代理在不修改源码的情况下对方法进行增强

### 相关术语

```properties
aspect切面=配置增强和切入点的关系
pointcut切入点=controller中将要被增强的方法
advice增强=增强的功能
joinpoint连接点=所有可以被增强的方法
target目标=被代理对象
proxy代理=代理对象
weaving织入=增强运用到切入点的过程
```

### aop配置

***在切面中配置增强和切入点的关系***

### 基于xml

```xml
<!--配置aop-->
<aop:congif>
    <!--声明切面-->
	<aop:aspect ref="">
        <!--
			expression:切入点表达式
 			ref:增强所在的bean
			method:增强的方法名
		-->
        <!--声明切入点-->
        <aop:pointcut id="" expression="* com.demo.controller.*.*(..)"></aop:pointcut>
        <!--
			通知类型:
  				before:前置通知
				after:最终通知
				round:自定义通知
				after-throwing:异常通知
				after-returning:后置通知
		-->
        <!--声明通知(增强)-->
    	<aop:before method="增强" pointcut-ref="切入点"></aop:before>
    </aop:aspect>
</aop:congif>
```



> **通知类型为round时,可以在增强中使用ProceedingJoinPoint中的proceed()方法来执行原有的功能**



### 开启注解aop

```xml
<aop:aspectj-autoproxy></aop:aspectj-autoproxy>
```

### 注解

```css
@Aspect:声明切面类
@After("execution(切入点表达式)"):声明增强
@Pointcut("execution(切入点表达式)"):声明切入点
@EnableAspectJAutoProxy:开启注解aop
```



<hr style="color: red">
## spring事务

**作用于service层,事务不能管理private方法,因为aop切不到私有方法**

```java
PlatformTransactionManager:事务管理器
```

### 创建流程

```java
1.创建事务管理器对象
2.配置事务的策略(属性)
3.配置事务的aop
```

### 属性

```properties
传播行为:
	REQUIRED:适用于增删改操作
	SUPPORTS:适用于查询
	REQUIRES_NEW:非主要业务不对主业务构成影响
	MANDATORY:必须在事务的环境运行
超时时间:默认-1,表示永不超时,事务不提交或者回滚会一直等待
是否只读:
	false:读写
	true:读
```

### XML事务配置

```XML
1.配置transactionManager事务管理器对象
<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
</bean>
2.配置事务策略(属性)
<!--配置事务增强-->
<tx:advice id="唯一标识" transaction-manager="transactionManager">
	<!--声明事务的属性-->
    <tx:attributes>
        <!--
			name:需要开启事务的方法
			read-only:是否只读
			timeout:事务退出时间
			isolation:隔离级别
			propagation:传播行为
		-->
    	<tx:method name="*" read-only="true" timeout="-1" isolation="DEFAULT" propagation="SUPPORTS"></tx:method>
    </tx:attributes>
</tx:advice>
3.声明事务的aop
<aop:config>
    <!--配置事务aop-->
	<aop:advisor advice-ref="事务策略唯一标识" pointcut=""></aop:advisor>
</aop:config>
```

##### 开启注解事务

```xml
<tx:annotation-driven></tx:annotation-driven>
```

### 注解

```css
@Transactional:开启事务
    定义在方法,接口和类上
@EnableTransactionManagement:开启注解事务
```



##### 事务失效

```
1.方法权限修饰符不是public
	a.将方法修饰符改为public
	b.开启AspectJ代理模式
2.当前类未被spring管理
	
3.当前方法中异常被捕获，但未进行抛出
4.当前方法抛出的异常类型不符合要求
	a.使用rollbackfor修改异常类型
	b.抛出spring支持的异常类型，runtimeException
5.当前方法未被事务管理，却调用了被事务管理的方法
6.数据库本身不支持事务
7.使用this调用其他方法，外层的事务失效
	a.把两个方法拆开，放到不同类里
	b.使用自己的实例调用
	c.通过AopContext.currentProxy()获取代理类调用
	d.去掉里层方法上的事务注解，放到外层方法上
```

##### 传播行为

```
Propagation.NOT_SUPPORTED:放弃事务支持
```

##### 修改回滚异常

```
rollbackfor=Exception.class
```







## spring监听器



***将spring容器介入到springMVC容器中(web项目)***



### 配置spring监听器

**web.xml**

```xml
<!--ServletContext初始化参数-->
<context-param>
    <param-name>contextConfigLogcation</param-name>
    <param-value>classpath:applicationContext.xml</param-value>
</context-param>
<listener>
    <listener-class>ContextLoaderListener</listener-class>
</listener>
```

#### 底层实现流程

```markdown
1.servletContextListener监听到ServletContext对象创建时,创建spring容器
2.将spring容器保存到servletContext域对象中
3.servlet从域对象中获取即可
```





## spring5新特性

##### 通用日志

spring5默认支持Log4j2日志框架。

##### 支持@Nullable注解

@Nullable 注解可以修饰方法、属性、参数。

-   方法，表示方法的返回值可以为空。
-   属性，表示当前属性值可以为空。
-   参数，表示当前方法的参数可以为空。

##### 支持junit5


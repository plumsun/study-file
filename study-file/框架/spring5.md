# spring

-   spring是一个开源免费的框架(容器).
-   spring是一个轻量级,非入侵式的框架.
-   控制反转(IOC),面向切面编程(AOP).
-   支持事务处理,对框架整合的支持.

```markdown
spring是一个轻量级的控制反转(IOC)和切面编程(AOP)的框架
```

## 组成

![image-20210116192015990](C:%5CUsers%5CAdmin%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210116192015990.png)

![image-20210116192126180](C:%5CUsers%5CAdmin%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210116192126180.png)

-   spring Boot
    -   一个快速开发的脚手架
    -   基于springBoot可以快速的开发单个微服务
-   spring Cloud
    -   SpringCloud是基于SpringBoot实现的





# IOC

***控制反转:通过spring容器创建bean***



## 创建bean

### 1.构造方法

```markdown
class属性指向bean的全限定路径或者实现类的全限定路径
底层通过反射机制,调用对应bean的构造方法创建指定bean
```

配置文件

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



### 2.静态实例工厂

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



### 3.动态实例工厂

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
	
    <bean id="工厂对象的标识" class="工厂类"></bean>
    <bean id="指定bean" factory-bean="工厂对象" factory-method="工厂对象的动态方法"></bean>
</beans>
```





## 基于xml

**解析配置文件API**

| 名字                   | 单例                            | 多例                |
| ---------------------- | ------------------------------- | ------------------- |
| **ApplicationContext** | **spring容器初始化时,创建bean** | 调用方法时,创建bean |
| **BeanFactroy**        | **调用方法时,创建bean**         | 调用方法时,创建bean |



### bean标签

#### 属性

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

#### 生命周期

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



### Spring依赖注入

*创建对象的方式都是使用xml配置文件*

#### 1.通过有参构造

##### dao层

```java
package com.demo.dao;

public interface UserMapper {
	
}
```

```java
package com.demo.dao.impl;

import com.demo.dao.UserMapper;

public class UserMapperImpl implements UserMapper {
	
}
```

##### service层

**Dao层**

```java
package com.demo.service;

public interface UserServiceDao {
    void getUserService();
    void show();

}
```

**Impl层**

```java
package com.demo.service.impl;

import com.demo.service.UserServiceDao;

public class UserServiceDaoImpl implements UserServiceDao {
    private String name;
    //dao层
    private UserMapper userMapper;

    
    //有参构造
    public UserServiceDaoImpl(String name,UserMapper userMapper){
        
    }

	//展示成员变量中的值
    @Override
    public void show() {
        System.out.println(name+"="+userMapper);
    }
}

```



##### 配置文件

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

#### **测试类**

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



### 2.通过set方法

#### service层

**Impl层**

```java
package com.demo.service.impl;

import com.demo.dao.UserMapper;
import com.demo.service.UserServiceDao;

public class UserServiceDaoImplSet implements UserServiceDao {
    private String name;
    private UserMapper userMapper;

    public void setName(String name) {
        this.name = name;
    }

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public UserServiceDaoImplSet() {
        System.out.println("对象创建成功");
    }

    //打印成员变量值
    @Override
    public void show() {
        System.out.println(name+"="+userMapper);
    }
}

```



#### 配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="UserMapper" class="com.demo.dao.impl.UserMapperImpl"/>
    
    <bean id="UserServiceDao" class="com.demo.service.impl.UserServiceDaoImplSet">
		
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



#### **测试类**

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

### 简写方式

```xml
<!-- set方式的依赖注入的简写：p名称空间-->
    <bean id="userService5" class="com.itheima.service.impl.UserServiceImpl3"
        p:gameName="坦克大战"
        p:sex="male"
        p:userDao-ref="userDao"
        p:age="8"></bean>
<!-- 构造方式依赖注入的简写：c名称空间-->
    <bean id="userService4" class="com.itheima.service.impl.UserServiceImpl2" c:gameName="打豆豆"
            c:age="16"
            c:sex="all"
            c:userDao-ref="userDao"></bean>
```



### 复杂类型注入

```xml
<bean id="userService6" class="com.itheima.service.impl.UserServiceImpl4">
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



## JdbcTemplate案例

### 案例原型:

#### web层

```java
public class MyTest{
    private UserServiceDao service;
    
    @Before
    public void getService(){
        ApplicationContext context = new ClassPathXmlApplicationContext();
        service = (UserServiceDao) context.getBean("UserServiceDao");
    }
    
    @Test
    public void test(){
        List<User> users = service.findAll();
        System.out.println(users);
    }
}
```



#### service层

```java
public interface UserServiceDao{
    List<User> findAll();
}
```

```java
public class UserServiceDaoImpl implements UserServiceDao{
    
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



#### dao层

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
        return template.query("select * from user",
                              new BeanPropertyRowMapper<>(User.class));
    }
    
}
```



#### 配置文件

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
    
    <bean id="UserServiceDao" class="com.demo.service.UserServiceDaoImpl">
        <property name="dao" ref="UserMapperDao"/>
    </bean>
    
</beans>
```



## 基于注解

### 创建对象

```css
@Component:	除了3层的对象创建,默认使用类名驼峰形式当做bean的唯一标识
@Controller: web表现层对象创建
@Service:	service业务层对象创建
@Repository: dao持久层对象创建
```

### 依赖注入

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





# AOP(面向切面编程)

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
    	<aop:通知类型 method="增强" pointcut-ref="切入点"></aop:before>
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

# spring事务

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


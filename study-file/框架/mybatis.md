### springmvc集成mybatis

#### 配置信息

##### 1.mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!-- 注册外部属性文件 -->
    <properties resource="jdbc.properties"/>
    <!-- 配置别名 第一种方法:直接指定别名-->
    <typeAliases>
        <typeAlias alias="Goods" type="com.Li.entity.Goods"/>
        <typeAlias alias="Type" type="com.Li.entity.Type"/>
    </typeAliases>
    <!-- 配置别名 第二种方法:扫描包 -->
<!--    <typeAliases>-->
<!--        <package name="com.Li.entity"/>-->
<!--    </typeAliases>-->
    <!-- 配置环境,默认环境id为development -->
    <environments default="development">
        <environment id="development">
            <!-- 配置事务管理类型为 JDBC -->
            <transactionManager type="JDBC"/>
            <!-- 配置数据源类型为连接池 -->
            <dataSource type="POOLED">
                <!-- 分别配置数据库连接的驱动,url,用户名,密码 -->
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/test?characterEncoding=utf8"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>
    <!-- 配置映射文件的位置,可以有多个映射文件 -->
    <mappers>
        <mapper resource="GoodsMapper.xml"/>
        <mapper resource="TypeMapper.xml"/>
    </mappers>
</configuration>


```

##### 2.springmvc.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd">
    <!-- bean definitions here -->
    <!-- 配置数据源 -->
    <bean id="dataSource"
          class="org.springframework.jdbc.datasource.DriverManagerDataSource">
        <property name="driverClassName">
            <value>com.mysql.jdbc.Driver</value>
        </property>
        <property name="url">
            <value>jdbc:mysql://localhost:3306/test?characterEncoding=utf8
            </value>
        </property>
        <property name="username">
            <value>root</value>
        </property>
        <property name="password">
            <value>root</value>
        </property>
    </bean>
    <!-- 配置sqlSessionFactory -->
    <bean id="sqlSessionFactory"
          class="org.mybatis.spring.SqlSessionFactoryBean">
        <!-- 注入DataSource -->
        <property name="dataSource" ref="dataSource" />
        <!-- 引用mybatis配置文件 -->
        <property name="configLocation"
                  value="classpath:mybatis-config.xml"></property>
    </bean>


    <!-- 配置SqlSessionTemplate -->
    <bean id="sqlSessionTemplate"
          class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory"
                         ref="sqlSessionFactory" />
    </bean>

</beans>

```

##### 3.mapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--
   mapper标签:配置各类声明
   namespace：名称空间，由于映射文件可能有多个，为了防止crud语句的唯一标识被重复，需要设置空间名称。
 -->

<mapper namespace="com.itheima.dao.CustomerDao">
    <!--
        select:查询的statement（声明），用来编写查询语句
        id:语句的唯一标识
        resultType：配置返回的结果集类型
        parameterType：传递的参数类型，可以省略
    -->

    <select id="findAll" resultType="customer">
        select * from customer
    </select>
    <!-- 多表联合查询 -->
    <resultMap id="goodsResultMapper" type="Goods">
        <id property="id" column="id" />
        <result property="goodsname" column="goodsname" />
        <result property="price" column="price" />
        <result property="quantity" column="quantity"/>
        <!-- 关联属性 -->
        <association property="type" javaType="Type">
            <id property="tid" column="tid" />
            <result property="typename" column="typecname" />
        </association>
    </resultMap>
    <!-- 多表连接查询 -->
    <select id="searchGoodsById" parameterType="int" resultMap="goodsResultMapper">
        select tid,typename,id,goodsname,price,quantity from type,goods
        where type.tid=goods.typeid
          and goods.id=#{id}
    </select>
    <resultMap id="typeResultMap" type="com.Li.entity.Type">
        <id property="tid" column="tid" />
        <result property="typename" column="typename" />
        <!-- 关联属性的映射关系 -->
        <collection property="goodslist" ofType="Goods">
            <id property="id" column="id" />
            <result property="goodsname" column="goodsname" />
            <result property="price" column="price" />
            <result property="quantity" column="quantity" />
        </collection>
    </resultMap>

    <!-- 多表连接查询 -->
    <select id="findTypeById" parameterType="int" resultMap="typeResultMap">
        select tid,typename,id,goodsname,price,quantity from type,goods
        where type.tid=goods.typeid
          and type.tid=#{tid}
    </select>
</mapper>
```





# mybatis

## 类和接口

### Resource

- getResourceAsStream()

    - 加载核心配置文件

### SqlSessionFactoryBulider

- build

    - 创建会话工厂对象

- 会话工厂创建类

### SqlSessionFactory

- openSession

    - 创建会话对象
    - 设置事务自动提交

- 会话工厂类

### SqlSession

- 加载SQL语句

    - selectOne
    - getMapper

- 底层是对Connection连接对象的封装
- commit

    - Mybatis中事务默认手动提交

## 映射方式

### 1.xml文件

### 2.注解

## 缺点

### 1.编写SQL语句工作量大

### 2.数据库移植性差,不能更换数据库

### 3.半自动化框架,功能有缺失,需要手写数据库查询

## 作用

### 1.简单

### 2.使用灵活,便于管理和优化

### 3.解耦,通过提供DAO层，将业务逻辑和数据访问逻辑分离，使系统的设计更清晰，更易维护，更易进行单元测试。SQL语句和代码的分离，提高了可维护性

## 配置文件

### 核心配置文件mybati-config.xml

- properties(属性)

    - resource用于加载外部配置文件
    - property(子标签)

        - name
        - value

    - 作用:定义全局变量

- typeAliases(类型别名)

    - typeAlias手动设置类型别名
    - package包扫描映射别名

        - 别名:类名小写

    - 注意

        - 基本类型别名是_基本类型名称;
        - 包装类型别名时包装类首字母小写;

- settings(设置)

    - 子标签(setting)

        - mapUnderscoreToCamelCase

            - 开启驼峰映射
            - 表中的字段名必须符合经典命名规则

        - value:true

- mappers(映射器)

    - resource

        - 加载工程中相对路径下的映射文件

    - package

        - 全包扫描加载

            - 注解开发优先

        - 前提条件

            - 1.接口名必须和映射文件名一致
            - 2.接口和映射文件路径必须相同
            - 3.映射文件中的命名空间必须和接口的全限定名一致

### 映射文件(UserMapper,xml)

- 注意

    - 1.dao层的接口名要与xml映射文件命名空间要一致
    - 2.接口中的方法要与XML文件中crud标签ID一致

- 结构

    - <mapper></mapper>
        - 动态SQL
        - resultMap结果集

            - <resultMap></resultMap>

        - SQL片段

            - <sql></sql>

        - 属性

            - namespace

                - 命名空间

##### mapper文件绑定

**一. mapper接口和映射文件都在同一个包下，都在src/main/java/* 时，配置如下**

mybatis-config.xml

```xml
<mappers>
        <package name="com.ssm.dao"/>
</mappers>
```

pom.xml

```xml
<!--
	如果接口和映射文件放在java下的同一个包中需要加下面的代码,
	加上这个配置以后就可以正常访问了，这个配置意思是扫描java目录下的资源文件
-->
<resource>
   <directory>src/main/java</directory>
   <includes>
     <include>**/*.xml</include>
     </includes>
   <filtering>false</filtering>
</resource>
```

 **二.mapper接口在main/java目录下，mapper映射文件在resources下并且包名相同，只需指定mapper接口所在的包即可**

mybatis-config.xml

```xml
<mappers>
  <package name="com.ssm.dao"/>
</mappers>
```

 **三.mapper接口和mapper映射文件存放位置不同名称也不相同**

mybatis-config.xml

```xml
<mappers>
        <!--mappper映射文件存放位置-->
        <mapper resource="com/ssm/mapper/UserDao.xml"/>
        <!--mapper接口存放位置-->
        <package name="com.ssm.dao.UserMapper"/>
</mappers>
```





## 结果集映射

### resultType

- 基本类型

    - 对应的基本数据类型别名或者全名

- 类

    - 完整类路径或者类的别名

- List集合

    - 泛型类型

- Map集合

    - 一条

        - map

    - 多条

        - 在动态代理接口上运用注解@Mapkey("主键名")
        - value:类对象

### resultMap

自定义结果集,自行设置结果集的封装方式
属性
id      标签名(唯一标识)
type  封装类型
autoMapping   自动映射(当类中属性名和表中字段名相同时)
子标签
<id name="" ,property=""/> 主键映射
<result name="" ,property=""/> 普通字段映射
	属性
column	表中字段名
property   映射的类属性名

- 使用时不要用驼峰匹配
- 需要在查询标签中指定

    - resultMap="标签名"

- 作用

    - 提高代码的复用性
    - 自定义结果集映射

### 运用在查询语句中

## mybatis入参(crud传参)

### 底层原理

- 当我们向xml文档传入#{user_name}---->getUserName--->利用反射根据方法名称获取方法对象----->报反射异常

### 多个参数

- 1.通过@Param指定参数名称

    - @Param("name") String name

- 2.在接收参数时,通过指定名称获取参数值
- 解决:参数绑定异常

### 单个参数

- 接口中传入一个参数

    - User queryById(Integer id);

- 接收参数

    - 通过#/${任意参数}接收

### 参数取值

- #{}

    - sql进行预编译
    - 防止SQL注入

- ${}

    - 字符串拼接
    - 有SQL注入风险

### 注意

- 1.传入pojo的话,传入的xml的变量名要与实体类中的属性名一致
- 2.实体类属性名称定义要尽量遵驼峰命名,或者在自动生成get/set方法时,自己手动纠正

### 类型

- 1.基本数据类型

    - int,string,long,Date等

- 2.复杂数据类型

    - 类(pojo)和Map

        - 传递参数是数组或者集合时,底层都会封装到Map集合中

## 动态SQL

### select

- <select></select>

    - 属性

### insert

- <insert></insert>

    - 属性

### update

- <update></update>

    - 属性

### delete

- <delete></delete>

    - 属性

### 主键回填

- useDeneratedKeys

    - true获取自动生成的主键

- keyColumn

    - 表中主键的列名

- keyProperty

    - 实体类中主键的属性名

### 常见子标签

- if:判断 (二选一)

    - 属性:test

        - 编写表达式

- choose:分支判断(多选一)

    - 子标签

        - when(选择)

            - 当其中一个when条件成立,后面的when都不会执行

        - otherwise(不满足when)
        - 属性:test

            - 编写表达式

- where

    - 1.能够添加where关键字
    - 2.被where标签包裹的SQL去除多余的and和or

- set

    - 1.添加set关键字
    - 2.被set标签包裹的SQL去除多余的','

- foreach:遍历数组和集合

    - 属性

        - collection

            - 接收的集合或数组,集合名或者数组名

        - item

            - 容器中的每一个元素(尽量与表中字段名相同)

        - separator

            - 标签分隔符

        - open

            - 以什么开始

        - close

            - 以什么结束

    - 语法

        - <foreach collection="接口中集合名称" item="集合中每一个元素" open="拼接以指定字符开头" close="拼接以指定字符结尾" separator="指定间隔符">    #{集合中每一个元素}  </foreach>

## 高级查询

### 一对一

- 在其中一个类中定义另一个类的类型属性
- <association/>

    - 属性

        - property

            - 表示指定映射的属性名

        - JavaType

            - 指定映射属性的类型

        - autoMapping

            - 开启自动映射

    - 表示一对一的映射关系

### 一对多

- 在(1)类(主表)中定义的集合属性来包含(n)类(从表)数据
- 关联标签

    -  <collection/>

        - ofType

            - 集合的泛型类型

### 多对多

- 转化为1对n的关系,在(1)类(主表)中定义的多个集合属性来包含(n)类(从表)数据
- <collection>嵌套<association>

### 通过resultMap来映射关系

### 注意

- 查询的字段必须唯一!

*XMind: ZEN - Trial Version*
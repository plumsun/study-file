# MYSQL

sql、DB、DBMS分别是什么，他们之间的关系？

```markdown
DB:
	DataBase(数据库，数据库实际上在硬盘上以文件的形式存在)
DBMS：
	DataBase Management System(数据库管理系统，常见的有：Mysql、Oracle、DB2、Sybase、SqlServer...)
SQL:
	1.结构化查询语言，是一门标准通用的语言。标准的sql适合于所有的数据库产品。
	2.sql属于高级语言。只要能看懂英语单词的，写出的sql语句，可以读懂什么意思。
	3.sql语句在执行的时候，实际上内部也会进行编译，然后再执行sql。（sql语句的编译由DBMS完成）
```



## 常用的命令

```sql
#查询表结构
desc emp;

#查询当前使用的数据库
SELECT database();

#查询当前数据库的版本号
select version();

# 查询当前MySQL默认存储引擎
show variables like '%storage_engine%';

#查询其他数据库中的数据表
show tables from nacos_config;

#查询表的创建语句
show create table emp;
```





## sql语句分类

### 1.DQL（数据查询语言）

查询语句，凡是select语句都是DQL。



#### 1.1.无条件查询

```mysql
#查询指定数据表中指定列数据
select 字段1,字段2,.... from 表名;

#查询所有字段时,字段名可以用 * 代替,查询具体字段时,需要声明字段名
select * from 表名;
```

>   select(选定):查询关键字,用来指定查询的字段，from(来自):表示从指定表中获取数据



**别名查询**

```mysql
#查询时给指定列或者表取别名,使用as关键字
select 字段1 as 别名,字段2 as 别名 from 表名;
select 字段1 as 别名,字段2 as 别名 from 表名 as 表别名;
```

> AS关键字是给字段,数据表,以及查询结果取别名,也可以省略不写

```sql
select name as '姓名',age as '年龄' from student;
#省略as关键字(中文引号也可以省略)
select name as '姓名',age '年龄' from student;
```



**字段去重**

```sql
#查询指定列并且返回结果是不重复数据
select distinct 字段1,字段2,... from 表名;
```

>   当distinct后跟多个字段时,必须这些字段值都相同,才会去重



**查询结果简单运算**

```sql
select 字段1[+ - * / %]字段2/固定值 from 表名;

#查询test表中id,name列与math+englis的和并取别名'总成绩'
select id,name,math+english as 总成绩 from test;
```



#### 1.2.条件查询

**比较运算符和逻辑运算符**

| 比较运算符    |                                         |
| ------------- | --------------------------------------- |
| 大于          | >                                       |
| 小于          | <                                       |
| 小于等于      | <=                                      |
| 大于等于      | >=                                      |
| 等于          | =                                       |
| 不等于        | <> , !=                                 |
| 并且          | and                                     |
| 或者          | or                                      |
| 包含          | in，相当于多个or （not in不在这个范围） |
| 为null        | is null（is not null）                  |
| 在...和..之间 | between...and...（闭区间）              |

**示例**

```MySQL
#查询工资不等于3000的员工
select * from emp where sal <> 3000;

#查询工资在3000和1000之间的员工,between ... and ...在...之间（闭区间）
select * from emp where sal between 1000 and 3000;

#查询津贴为null的员工
select * from emp where comm is null;

#查询津贴不为null的员工
select * from emp where comm is not null;

#查询没有津贴的员工
select * from emp where comm is null or comm = 0;

#查询部门编号为20和30，并且薪资大于2000的员工
select * from emp where sal > 2000 and (deptno = 20 or deptno=30);

#查询薪资是1100和3000的员工
select * from emp where sal in (1100,3000);

#查询薪资不是1100和3000的员工
select * from emp where sal not in (1100,3000);
```



#### 1.3.模糊查询

```sql
like(就像)关键字
select * from 表名 where 字段 like '通配符字符串';

通配符
%:表示任意个字符
_:表示一个字符

#查询员工名字姓李的，%代表多个字符，_代表一个字符
select * from emp where ename like '李%';
```



#### 1.4.查询排序

```sql
asc:升序排序(语法默认,可以省略)
desc:降序排序

order by:将查询结果进行排序
select 字段1,字段2,字段3,... from 表名 where 条件语句 order by 字段 [asc/desc];

#将员工进行降序排序
select * from emp order by sal desc;

#单列排序
select * from test order by id desc;
#多列排序	
1.排列规则:	
	先按第一个字段排序,若第一个字段相同就依次按其他字段排序,若第一个字段不同,其他字段就不参与排序
```



#### 1.5.聚合函数

```sql
在根据指定的列统计的时候，如果这一列中有null的行，该行不会被统计在其中。
count()：按照列去统计有多少行数据。
sum()： 计算指定列的数值和，如果不是数值类型，那么计算结果为0
max()： 计算指定列的最大值
min()： 计算指定列的最小值
avg()： 计算指定列的平均值

select 聚合函数(字段) FROM 表名 where 条件;

#空值处理函数
ifnull(可能为null的数据,被当做什么处理)
```



#### 1.6.分组查询

```sql
#按照某一列或者某几列,把相同的数据,进行合并输出(默认输出每组第一个记录数据)
select * from 表名 group by 字段1,字段2,....;

#分组后数据使用having过滤
select * from 表名 group by 字段 having 条件;

注意：
分组函数（聚合函数）一般都会和group by联用，并且任何一个分组函数都在group by语句执行结束之后才会执行的。
```

> where与having区别:
>
> 1.where用于group by之前的数据过滤,having用于之后;
>
> 2.where后不能使用聚合函数,having可以
>
> 3.where可以单独使用,having建议和group by联用







### 2.DML（数据操作语言）

insert，update，delete，对表中的数据进行增删改。



```mysql

```





### 3.DDL（数据定义语言）

create、drop、alter对表结构进行增删改



```mysql

```





### 4.TCL（事务控制语言）

commit提交事务，rollback回滚事务，transaction事务



```mysql

```





### 5.DCL（数据控制语言）

grant授权，revoke撤销权限



```mysql

```













## 1.引擎

```markdown
myisam和innodb的区别
1.myisam不支持事务，支持表锁
2.innodb支持事务，支持行锁，支持外键
```



## 2.索引

```markdown
1. 聚簇索引的文件存放在主键索引的叶子节点上，因此 InnoDB 必须要有主键，通过主键索引效率很高。但是辅助索引需要两次查询，先查询到主键，然后再通过主键查询到数据。因此，主键不应该过大，因为主键太大，其他索引也都会很大。
2. 而 MyISAM 是非聚集索引，数据文件是分离的，索引保存的是数据文件的指针。主键索引和辅助索引是独立的。
```

### 索引创建

```markdown
1. 字段内容可识别度不能低于70%，字段内数据唯一值的个数不能低于70%

2. 经常使用where条件搜索的字段，例如user表的id name等字段。

3. 经常使用表连接的字段（内连接、外连接），可以加快连接的速度。

4. 经常排序的字段 order by，因为索引已经是排过序的，这样一来可以利用索引的排序，加快排序查 询速度。

5. 空间原则（字段占用空间越小也好）
```

### 索引失效

```markdown
- 最左匹配原则  
- 范围条件右边的索引失效
- 不再索引列上做任何操作 
- 在使用(!=或者<>)索引失效
- is not null无法使用索引
- like以通配符开头(%qw)索引失效 
- 字符串不加引号索引失效
- 使用or连接索引失效
- 尽量使用覆盖索引  覆盖索引: 要查询的字段全部是索引字段
```



## 3.explian关键字

```markdown
explain这个命令来查看一个这些SQL语句的执行计划，查看该SQL语句有没有使用上了索引，有没有做全表扫描，这都可以通过explain命令来查看
```





**truncate和delete的区别:**

1.使用delete时,如果再添加数据,自动增加字段的值为删除时该字段的最大值加一;
  使用truncate时,如果再添加数据,自动增加字段重新为1开始;

2.delete删除语句,可以在后跟where过滤条件,来实现删除部分或者指定数据.
  truncate只能删除全部数据.





## 4.慢日志处理

```bash
# 查询慢查询日志功能是否开启
show variables like 'slow_query_log';
# 查询慢查询阈值
show variables like 'long_query_time';
# 开启慢查询日志功能
SET GLOBAL slow_query_log = 'ON';
# 慢查询日志存放位置
SET GLOBAL slow_query_log_file = '/var/lib/mysql/ranking-list-slow.log';
# 无论是否超时，未被索引的记录也会记录下来。
SET GLOBAL log_queries_not_using_indexes = 'ON';
# 慢查询阈值（秒），SQL 执行超过这个阈值将被记录在日志中。
SET SESSION long_query_time = 1;
# 慢查询仅记录扫描行数大于此参数的 SQL
SET SESSION min_examined_row_limit = 100;
```


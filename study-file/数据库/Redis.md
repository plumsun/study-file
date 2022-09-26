# Redis

## 简介

Redis 是完全开源的，遵守 BSD 协议，是一个高性能的 key-value 数据库。



Redis 与其他 key - value 缓存产品有以下三个特点：

- Redis支持数据的持久化，可以将内存中的数据保存在磁盘中，重启的时候可以再次加载进行使用。
- Redis不仅仅支持简单的key-value类型的数据，同时还提供list，set，zset，hash等数据结构的存储。
- Redis支持数据的备份，即master-slave模式的数据备份。

------

## 优势

- 性能极高 – Redis能读的速度是110000次/s,写的速度是81000次/s 。

- 丰富的数据类型 – Redis支持二进制案例的 Strings, Lists, Hashes, Sets 及 Ordered Sets 数据类型操作。

- 原子 – Redis的所有操作都是原子性的，意思就是要么成功执行要么失败完全不执行。单个操作是原子性的。多个操作也支持事务，即原子性，通过MULTI和EXEC指令包起来。

- 丰富的特性 – Redis还支持 publish/subscribe, 通知, key 过期等等特性。

    













## 1.容器命令

```lua
--String类型
    1.创建 set key value
    #(可以删除多个)
    2.删除 del key key1 
    3.获取 get key

--hash散列类型
	1.创建 hash key value 值 向指定的键中添加一对hash类型的字段名和值
	2.获取 hget key value 获取指定字段的值
	3.添加多个 hmset key value1 值 value2 值
	4.删除 hdel key value value 删除指定字段
--list列表
	1.在左边添加数据 lpush key value
	2.在右边添加数据 rpush key value
	3.查询指定位置的数据 lrange key start end
	4.查询列表长度 llen key
	5.删除左边的第一个数据 lpop key
	6.删除右边的第一个数据 rpop key
--set集合类型
	1.向集合添加数据 sadd key value value1
	2.查询集合中的全部元素 smembers key
	3.删除集合中的指定元素 srem key value
--zset有序集合
	1.添加数据 zadd key 1 value 2 value1
	2.获取指定位置的数据 zrange key start end 
	3.移除元素 zrem key value value1
	4.获取指定元素的索引 zrank key value
	5.获取集合中的长度 zcard key
	6.获取指定元素的值 zscore key value
```

## 2.通用命令

```lua
--设置超时时间
expire key time

--匹配数据库中的键(*匹配多个字符，?匹配1个字符)
keys *
--判断是否指定的键
exists key

--事务开始
multi
--取消事务
discard
--执行事务块中命令
exec
```



> 单个 Redis 命令的执行是原子性的，但 Redis 没有在事务上增加任何维持原子性的机制，所以 Redis 事务的执行并不是原子性的。
>
> 事务可以理解为一个打包的批量执行脚本，但批量指令并非原子化的操作，中间某条指令的失败不会导致前面已做指令的回滚，也不会造成后续的指令不做。





## 3.持久化机制

```markdown
1. RDB,Redis默认的持久化方式
		1.机制：快照机制，达到指定的时间节点，会立即将Redis中的数据持久化到硬盘上,如果服务器正常关闭的话也会持久化，持久化到dump.rdb文件中
		2.配置 save 900 1
		3.优点：效率高
		4.缺点：可能会导致数据丢失
2. AOF
		1.机制：以日志记录每一条执行的命令
		2.开启aof持久化appendonly yes
		3.触发机制 
			always 同步数据发生变更就会持久化
			everysec 异步每秒记录持久化，可能丢失数据
			no 从不同步
		4.优点：不会丢失数据
		5.缺点：效率低
	日志文件数据量大解决方案
		AOF重写：redis-cls BGREWRITEAOF(bgrewriteaof)
		(1) 随着AOF文件越来越大，里面会有大部分是重复命令或者可以合并的命令（100次incr = set key 100）
        (2) 重写的好处：减少AOF日志尺寸，减少内存占用，加快数据库恢复时间。

        执行一个 AOF文件重写操作，重写会创建一个当前 AOF 文件的体积优化版本。
        即使 BGREWRITEAOF 执行失败，也不会有任何数据丢失，因为旧的 AOF 文件在 BGREWRITEAOF 成功之前不会被修改。
        从 Redis 2.4 开始，AOF 重写由 Redis 自行触发， BGREWRITEAOF 仅仅用于手动触发重写操作。但网上有网友说已经3.2.5版本了，貌似redis还是没有自动触发BGREWRITEAOF
```

## 4.淘汰策略

```properties
volatile-lru:从已设置过期时间的数据集中挑选最近最少使用的数据淘汰
volatile-ttl:从已设置过期时间的数据集中挑选将要过期的数据淘汰
volatile-random:从已设置过期时间的数据集中任意选择数据淘汰
allkeys-lru:从所有数据集中挑选最近最少使用的数据淘汰
allkeys-random:从所有数据集中任意选择数据进行淘汰
noeviction:不删除策略，达到最大内存限制时，如果需要更多内存，直接返回错误信息。大多数写命令都会导致占用更多的内存
```



## 5.过期键删除策略

```markdown
1. 定时删除
		在设置键的过期时间的同时，创建一个定时器，让定时器在键的过期时间来临时，立即执行对键的删除操作。

2. 惰性删除
		放任过期键不管，每次从键空间中获取键时，检查该键是否过期，如果过期，就删除该键，如果没有过期，就返回该键。

3. 定期删除
		每隔一段时间，程序对数据库进行一次检查，删除里面的过期键，至于要删除哪些数据库的哪些过期键，则由算法决定。
		
定时删除和定期删除为主动删除策略，惰性删除为被动删除策略。
```

> 默认使用惰性加定期删除



## 6.缓存处理流程

![image-20210805170841054](C:%5CUsers%5CAdmin%5CAppData%5CRoaming%5CTypora%5Ctypora-user-images%5Cimage-20210805170841054.png)

### 1.缓存穿透

#### 问题描述:

```markdown
	查询一个一定不存在的数据,由于缓存必定不命中,而去数据库中查询数据,却什么也查询不到而且也没有将空结果写入缓存,导致每次查询这个数据都会访问一遍数据库,使缓存失去效果,容易导致数据库压力大,最终导致系统崩溃
```

#### 解决方案:

```markdown
1.	将空结果写入缓存中,加上短暂的过期时间,防止数据恢复
2.	接口层增加校验,做一些基础的校验,如id>=0;
```



### 2.缓存穿透

#### 问题描述:

```markdown
	对于一些设置了过期时间的key,这些key可能在某一时间内被大量请求访问,如果在大量请求进来之前,缓存失效就会导致大量请求直接请求数据库,导致系统崩溃
```

#### 解决方案:

```markdown
1. 加锁,当大量请求访问时,只允许一个请求查询数据,等查完后将数据写入缓存并释放锁
2. 设置热门数据永不过期
```



### 3.缓存雪崩

#### 问题描述:

```markdown
	很多缓存设置了相同的过期时间，在某一时刻，所有缓存同时失效，导致大量请求直接进入数据库导致系统崩溃
```

#### 解决方案:

```markdown
1. 设置过期时间时在原有的失效时间上加一个随机值
```



>  缓存击穿指并发查同一条数据，缓存雪崩是不同数据都过期了，很多数据都查不到从而查数据库。







### 4.分布式锁

```markdown
原理:
	所有线程去一个地方抢占锁,抢到了就执行操作
	使用redis,所有人进来时set一个key-value,每个线程进入前先查询是否含有这个k-v,没有的话就set,也就代表当前线程抢到了锁,执行之后的业务操作,执行完毕删除这个k-v;别人进来如果看到这个k-v说明锁已被占用
```

>  `set k v NX` 就表示当这个k不存在时才能set成功



**问题**:

​			等程序拿到锁之后执行其他操作时发生异常直接退出，没有释放锁造成死锁，怎么办？

**解决**:

​			把释放锁放到final里？

**问题**:

​			*如果还没执行到final机器直接断电，怎么办*

**解决**:

​			给锁设置一个自动过期时间

**问题**:

​			要是还没来得及设置过期时间机器就崩溃怎么办

**归根结底就是加锁和设置过期时间不是一个原子操作**

**解决**:

​		set k v EX 300 NX加锁设置过期时间放到一句里

**问题**:

​		当业务时间超过锁的过期时间，锁已经过期，等待业务结束再去删锁删的就是别人的锁

**解决**:

​		我们设置锁时，不再随便设置value，而是设置一个UUID，只删除value和自己设置的value相同的锁，防止删除别人的锁

**问题**:

​		我们查询这个value和自己设置的value是否相同的这个过程是需要耗费时间的，万一恰好你拿到了你设置的锁的value正在返回时，锁过期了，别的进程又抢占了锁，设置了自己的value，而等到你刚查的value到达时确实和你自己设置的锁的value相同，然后删除锁，结果就把别人的锁删了

**归根结底又是查值进行对比和对比成功删除锁这两步不是一个原子操作**

**解决**:删锁使用Lua脚本辅助

```lua
String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end"; 
```



> **Redisson将我们上述的问题统统解决，让我们优雅的加锁释放锁**









### 5.缓存数据一致性

#### 双写模式

**数据更新->更新数据库->更新缓存**

**问题**：

```
两个线程：先后修改数据

线程1->写数据库----------------------->写缓存

线程2------------>写数据库->写缓存

此时 就会产生暂时的脏数据
```

**解决**：

```
加锁
```

#### 失效模式

**数据更新->更新数据库->删除缓存**

**问题**：

![图片](https://mmbiz.qpic.cn/mmbiz_png/Zxmz2vibxicFIsricEM1P9lk7DAYCdERiaoSwrOT77lrC8OYY5D9BfQajiaoj1gJyTnjic9eHY9O38n63rqjTq3ESuHw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

**解决**：

```
加锁
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/Zxmz2vibxicFIsricEM1P9lk7DAYCdERiaoSjmvkREkibnPsBQ5e0Pia0NGD5WguUSAqStgp7MtLE7v3IG2icnvicbgbDQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)





> Spring Cache将读区数据，写入缓存等等重复的操作整合起来，只需引入一些注解就可实现这些功能







## 7.性能优化手段

```java
1.缩短键值对的存储长度。
2.使用lazy free(延迟删除)特性。
3.设置键值的过期时间
4.禁用长时间的查询命令
5.使用slowlog优化耗时命令
6.使用pipeline批量操作数据
7.避免大量数据同时失效
8.客户端使用优化
9.限制redis内存大小
10.使用物理机而非虚拟机安装redis服务
11.检查数据持久化策略
12.禁用THP特性
13.使用分布式架构来增加读写速度
    
    
同等情况下单条数据的set要比多条数据的set效率低。
```










## 集合

### 1.hashSet怎么保证元素唯一性？

```markdown
通过元素类中重写的两个方法，hashCode和equals来完成，如果元素的hashcode相同，会判断equals是否为true，如果hashcode值不同，不会调用equals
```

> TreeSet通过compareTo或者compare方法来保证元素的唯一性



### 2.hashMap中什么时候需要进行扩容，扩容resize（）又是如何实现的？

```markdown
调用场景:
	1.初始化数组table
	2.当数组table的size达到阈值时进行扩容
扩容需要重新分配一个新数组，新数组容量是老数组容量的2倍，然后遍历整个老数组将所有的元素挨个重新hash分配到新结构中，
```

### 3.ConcurrentHashMap特点

```markdown
1.数组：
    整个ConcurrentHashMap由一个个Segment组成的数组，
2.线程安全
	而segment继承reentrantLock进行加锁，这样保证每个segment是线程安全的，也就实现了全局的线程安全；
3.支持并发
	concurrenthashmap中默认有16个segments，最多可以同时支持16个线程并发写，这个值可以在初始化的时候设置，一旦初始化之后，是不可以进行扩容的
	每个segment跟hashMap类似
```

### 4.hashMap和HashTable的区别？

```
1.hashMap是线程不安全的，不允许键值重复，允许key和value为空
2.由于hashMap是非线程安全的，所以它的效率要比hashtable高
3.hashtable是一个线程安全的集合，不允许key和value为null，hashtable的方法上加入了sychronize关键字，任意时间内只有一个线程能写hashtable
```

### 5.HashMap,HashTable,ConcurrentHashMap之间的区别，性能对比

```
1.ConcurrenthashMap>hashMap>hashTable
2.ConcurrentHashMap使用了锁分段技术来保证线程安全，一次锁住一个桶，而ConcurrentHashMap默认将hash表分为16个桶，诸如get，put，remove等常用操作只锁住当前需要用到的桶，这样能同时有16个写线程执行，并发性能提高
```





## 线程

### 1.什么是线程？线程和进程的区别？

```
线程：进程的一个实体，是CPU调度和分派的基本单位，是比进程更小额可以独立运行的基本单位
进程：具有一定独立功能的程序关于某个数据集合上的一次运行活动，是操作系统进行资源分配和调度的一个独立单位
特点：线程的划分尺度小于进程，这使多线程程序拥有高并发性，进程在运行时各自内存单元相互独立，线程之间内存共享，这使多线程编程可以拥有更好的性能和用户体验
```

### 2.sleep和wait的区别

```
sleep方法是属于thread类中的，而wait方法是属于Object类中的
1.sleep方法导致当前线程休眠，并不会释放当前占有的对象锁，sleep会导致线程进入timed-wating期限等待状态
2.wait方法会导致线程进入waiting阻塞状态，只有等待其他线程调用notify或者notifyAll方法后当前线程才会进入运行状态，当调用wait方法后，当前线程会释放对象锁
```

### 3.start与run方法的区别？

```
start方法来启动线程，真正实现了多线程运行，这时无需等待run方法体代码执行完毕可以直接继续执行下面的代码
通过调用Thread类的start()方法来启动一个线程，这时线程处于就绪状态，并没有运行，方法run()称为线程体，它包含了要执行的这个线程的内容，线程就进入了运行状态，开始运行run中代码
```

### 4.线程池原理

```markdown
线程池的主要工作是控制运行的线程的数量，处理过程中的将任务放入对列，然后在线程创建后启动这些任务，如果线程数量超过了最大数量超出数量的线程会排队进行等候，等其他线程执行完毕，再从对列中取出任务来执行，他的主要特点为：线程复用，控制最大并发数，管理线程
	线程复用：可以继承重写Thread类，在其start方法中添加不断循环调用传递过来的Runnable对象，循环方法中不断获取Runnable是用Queue实现的，在获取下一个Runnable之前可是可以阻塞的。
	控制最大并发数：
	管理线程：
```

### 5.线程池工作流程

```markdown
1.线程池刚创建时，里面没有一个线程。任务队列是作为参数进来的。不过，就算队列里面有任务，线程池也不会马上执行它们
2.当调用execute()方法添加一个任务时，线程池会做出判断：
	a.如果正在运行的线程数量小于核心线程数量(corePoolSize),那么马上创建线程运行这个任务
	b.如果正在运行的线程数量大于或的等于核心线程数量,那么将这个任务放入队列(workQueue)，等待执行
	c.如果这时候队列满了，而且正在运行的线程数量小于最大可容纳的线程数(maximumPoolSize),那么创建非核心线程立刻运行这个任务
	b.如果超出这个数量，就调用handler实现拒绝策略
3.当一个线程完成任务时，会从队列中取下一个任务来执行
4.当一个线程无事可做，超过一定时间(keepAliveTime)时，线程池会判断，如果当前运行线程大于核心线程数量，那么这个线程就被停掉。所以线程池的所有任务完成后，它会收缩到核心线程的大小
```



### 6.线程的执行顺序

```markdown
1.当线程数小于核心线程数，会一直创建线程直到线程数等于核心线程数
2.当线程数等于核心线程数时，新加入的任务会被放到任务队列等待执行
3.当任务队列已满，又有新的任务时，会创建线程直到线程数量等于最大线程数
4.当线程数等于最大线程数，且任务队列已满，新加入任务会被拒绝
```



### 7.线程池参数

```properties
corePoolSize:线程池中的核心线程数量

maximumPoolSize:线程池中可以容纳的最大线程的数量

maxPoolSize:最大线程数

keepAliveTime:除核心线程外其他线程最长可保留的时间

workQueue:等待队列

queueCapacity:任务队列容量，也叫阻塞队列，当核心线程都在运行，此时再有任务进来，会进入任务队列，排队等待线程执行
ThreadFactory:创建线程的线程工厂
```

### 8.死锁产生

```java
死锁是指两个或两个以上的进程在执行过程中，因争夺资源而造成的一种互相等待的现象，若无外力作用，他们都将无法进行下去
在多线程程序中，使用了多把锁，造成线程之间相互等待，导致程序不往下执行

死锁产生需要满足四个条件：
1.互斥条件：一次资源每次只能被一个进程使用
2.请求与保持条件：一个进程因请求资源而阻塞时，对已获得的资源保持不放
3.不剥夺条件：进程已获得的资源，在未使用完之前，不能强行剥夺
4.循环等待条件：若干进程之间形成一种头尾相接的循环等待资源关系

1.有多把锁
2.有多个线程
3.有同步代码块嵌套

```



### 9.如何避免死锁

```
1.死锁预防：确保系统永远不会进入死锁状态
	a.破坏请求与保持条件
	b.破坏不剥夺条件
	c.破坏循环等待条件
2.避免死锁：在使用前进行判断，只允许不会产生死锁的进程申请资源

3.死锁检测与解除：在检测到运行系统进入死锁，进程
```



## 锁

### 1.Condition类和Object类锁方法区别

```java
1.Condition类的awiat方法和Object类的wait方法等效
2.Condition类的signal方法和Object类的notify方法等效
3.Condition类的signalAll方法和Object类的notifyAll方法等效
4.ReentrantLock类可以唤醒指定条件的线程，而object的唤醒是随机的
```

### 2.tryLock和lock，lockInterruptibly的区别

```java
1.tryLock能获得锁就返回true，不能就立即返回false，tryLock(long timeout,TimeUnit unit),可以增加时间限制，如果超过该时间段还没获得锁，返回false
2.lock能获得锁就返回true，不能的话一直等待获得锁
3.lock和lockInterruptibly，如果两个线程分别执行这两个方法，但此时中断这两个线程，lock不会抛出异常，而lockInterruptibly会抛出异常
```

### 3.synchronized和ReentrantLock的区别

```java
1.ReentrantLock 显示的获得、释放锁，synchronized 隐式获得释放锁
2. ReentrantLock 可响应中断、可轮回，synchronized 是不可以响应中断的，为处理锁的不可用性提供了更高的灵活性
3. ReentrantLock 是 API 级别的，synchronized 是 JVM 级别的
4. ReentrantLock 可以实现公平锁
5. ReentrantLock 通过 Condition 可以绑定多个条件
6. 底层实现不一样， synchronized 是同步阻塞，使用的是悲观并发策略，lock 是同步非阻塞，采用的是乐观并发策略
7. Lock 是一个接口，而 synchronized 是 Java 中的关键字，synchronized 是内置的语言实现。
8. synchronized 在发生异常时，会自动释放线程占有的锁，因此不会导致死锁现象发生；
而 Lock 在发生异常时，如果没有主动通过 unLock()去释放锁，则很可能造成死锁现象，因此使用 Lock 时需要在 finally 块中释放锁。
9. Lock 可以让等待锁的线程响应中断，而 synchronized 却不行，使用 synchronized 时，等待的线程会一直等待下去，不能够响应中断。
10. 通过 Lock 可以知道有没有成功获取锁，而 synchronized 却无法办到。
11. Lock 可以提高多个线程进行读操作的效率，既就是实现读写锁等。
```

 
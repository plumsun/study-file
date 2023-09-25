# Kafka





## consumer使用规范

- consumer的owner线程需确保不会异常退出，避免客户端无法发起消费请求，阻塞消费。
- consumer的线程数量默认为5个。
- 确保处理完消息后再做消息commit，避免业务消息处理失败，无法重新拉取处理失败的消息。
- 应用程序需要能够记录consumer的offset，保证在消费失败时可以重新消费。
- consumer不能频繁加入和退出group，频繁加入和退出，会导致consumer频繁做rebalance，阻塞消费。
- consumer数量不能超过topic分区数，否则会有consumer拉取不到消息。
- consumer需周期poll，维持和server的心跳，避免心跳超时，导致consumer频繁加入和退出，阻塞消费。
- consumer拉取的消息本地缓存应有大小限制，避免OOM（Out of Memory）。
- consumer session设置为30秒，session.timeout.ms=30000。
- Kafka不能保证消费重复的消息，业务侧需保证消息处理的幂等性。
- 消费线程退出要调用consumer的close方法，避免同一个组的其他消费者阻塞sesstion.timeout.ms的时间。
- 一个消费组只能订阅一个topic
- 消费端group命名规范：group-项目名称-应用标识-自定义，group名字为全小写英文字母，中间以'-'分隔。例如：group-flink-db-fulllink-letpas。
- 一个消费组只能订阅一个topic，不允许同一个消费组消费多个topic。  

## producer使用规范

- 同步复制客户端需要配合使用：acks=all
- 配置发送失败重试：retries=3
- 发送优化：linger.ms=0
- 生产端的JVM内存要足够，避免内存不足导致发送阻塞，一般默认开设为8gb大小。

## topic使用规范

- topic副本数推荐为5个，同步复制，最小同步副本数为2，且同步副本数不能等于topic副本数，否则宕机1个副本会导致无法生产消息。
- 默认关闭kafka自动创建Topic的开关。
- 单topic最大分区数建议为5。
- topic日志保留时间有2h/4h/8h/24h/3d 这几个可选项，日志类topic最多只能保留24h，支持视消息数据量动态调整。

## 其他

- 连接数限制：3000
- 消息大小： 不能超过1MB，超过该大小限制的需在申请kafka时及时提出，平台会单独定制针对大容量消息的配置参数。
- 使用sasl_ssl协议访问Kafka：确保DNS具有反向解析能力，或者在hosts文件配置kafka所有节点ip和主机名映射，避免Kafka client做反向解析，阻塞连接建立。
- 磁盘容量申请超过业务量 * 副本数的2倍，即保留磁盘空闲50%左右。
- 业务进程JVM内存使用确保无频繁FGC，否则会阻塞消息的生产和消费。





### 消息不丢失解决方案

#### 生产者

```
生产者端，使用producer.send(msg, callback)方法，获取消费发送是否成功的状态
```

#### 消费者

维持先消费消息（阅读），再更新位移（书签）的顺序。如果是多线程异步处理消费消息，Consumer 程序不要开启自动提交位移，而是要应用程序手动提交位移

1. 不要使用producer.send(msg)，而要使用 producer.send(msg, callback)。记住，一定要使用带有回调通知的send方法。
2. 设置 acks = all。acks 是 Producer 的一个参数，代表了你对已提交消息的定义。如果设置成 all，则表明所有副本 Broker 都要接收到消息，该消息才算是已提交。这是最高等级的已提交定义。
3. 设置 retries 为一个较大的值。这里的retries同样是 Producer 的参数，对应前面提到的 Producer自动重试。当出现网络的瞬时抖动时，消息发送可能会失败，此时配置了retries > 0 的 Producer 能够自动重试消息发送，避免消息丢失。
4. 设置 unclean.leader.election.enable = false。这是 Broker 端的参数，它控制的是哪些Broker 有资格竞选分区的 Leader。如果一个 Broker 落后原先的 Leader 太多，那么它一旦成为新的 Leader，必然会造成消息的丢失。故一般都要将该参数设置成 false，即不允许这种情况的发生。
5. 设置 replication.factor >= 3。这也是 Broker 端的参数。其实这里想表述的是，最好将消息多保存几份，毕竟目前防止消息丢失的主要机制就是冗余。
6. 设置 min.insync.replicas > 1 。这依然是 Broker 端参数，控制的是消息至少要被写入到多少个副本才算是“已提交”。设置成大于 1 可以提升消息持久性。在实际环境中千万不要使用默认值 1。
7. 确保 replication.factor > min.insync.replicas。如果两者相等，那么只要有一个副本挂机，整个分区就无法正常工作了。我们不仅要改善消息的持久性，防止数据丢失，还要在不降低可用性的基础上完成。推荐设置成 replication.factor = min.insync.replicas +1
8. 确保消息消费完成再提交。Consumer 端有个参数 enable.auto.commit，最好把它设置成 false，并采用手动提交位移的方式。就像前面说的，这对于单 Consumer 多线程处理的场景而言是至关重要的。

topic
# MongoDB

支持js代码

### 1.相关命令

```lua
--查询
db.lsp_pool_base.find({"_id":"YW_a9d63cfd1e7944d28d49c304a040cc37"})
--查询指定时间段内的数据
db.video_stream_info.find({"zegoBoxInfo.mgdbId":"900002594","dType":2,"updateTime":{"$gt":"2021-10-09 00:00:00"}})
--查询指定数量
db.lsp_live_content.find({"mgdbId":"120000164063","status":1}).count()


--插入

--更新
db.lsp_live_channel_history.update({"vcloudId":"vcloud1-20210511195842_afcfc9f4"},{$set:{"status":"0"}})
--删除

--导出数据
sudo ./mongoexport -h 10.186.203.140:27017 -u zbzt -p zbzt --authenticationDatabase zbzt -d zbzt -c lsp_live_channel --type=json -o /usr/local/mongodb/bin/lsp_pool_base.json

--导入数据
./mongoimport -h 10.183.54.192:27017 -u m_streamhub -p bR9xBVv0IJwtE3WJ2nvf --authenticationDatabase streamhubdb -d streamhubdb -c lsp_pool_base --type=json /home/mongo-3.4.18/bin/lsp_pool_base.json --insert

--更新多行文档(改变指定字段的值)
db.getCollection("lsp_live_channel").find({
    "type": 1
}).forEach(function(e) {
    e.sid = e.sid.replace('V', 'v');
    e.title = e.sid.replace('V', 'v');
    db.getCollection("lsp_live_channel").save(e);
});

```


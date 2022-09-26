# live-management-sys

#### 1.废弃配置(颛桥)

```yaml
restFul:
  api:
    preFix: http://live.miguvideo.com/
  msgPush:
    preFix: http://10.186.81.10:9100/ #警告
  chatSrv:
    preFix: http://10.186.81.10:9100
  remote:
      user:
        getUserInfo: user/v1/user-infos #原始用户id验证后缀方法
 
#获取WorldCup.getTemplateList 20200727新增
WORLDCUP:
  GETTEMPLATE:
    URL: /noms-worldcup/v1/cloudAudience/getTemplate
BOX:
  #预览环境不存在-------
  Capacity: 8
  MaxPlayerNum: 8
  MinPlayerNum: 4
  #-----------
  PageId: 2bd187abe0ea41c6b8f2be114c80e47f
remote:
  appManagement:
    addOrUpdateCommitRelease: /app-management-server/commit/H5/addOrUpdateCommitRelease



#预览环境不存在---------  
robot:
  shell:
    startpushurl: /nas/shell/start.sh
    stoppushurl: /nas/shell/stop.sh
#运编能力
OESLIVEMANAGE:
  RUI: http://10.150.51.128:18080
  BUSINESSTYPE: cloudlive2msdn
  MERGESTREAMCHANNEL: rtmp://cloudlive-msdn-push.miguvideo.com/live2msdn/cloudlive_%s
  TPL: live57
  ADDTIME: 5
  CREATE:
    URL: /oes-live-manage/live/outer-url/channel/create
  DELETE:
    URL: /oes-live-manage/live/outer-url/channel/delete
  QUERYLIST:
    URL: /oes-live-manage/live/outer-url/channel/queryList
  STOP:
    URL: /oes-live-manage/live/outer-url/channel/stop
#---------------------
```

#### 2.废弃配置(无锡)

```yaml
restFul:
  api:
    preFix: http://live.miguvideo.com/
  msgPush:
    preFix: http://10.186.81.10:9100/ #警告
  chatSrv:
    preFix: http://10.186.81.10:9100
  liveIntegration:
    preFix: http://10.200.86.198:8083/ #live-integration 服务前缀 
  remote:
      user:
        getUserInfo: user/v1/user-infos #原始用户id验证后缀方法
  liveAnchor:
    preFix: http://183.192.162.101:8083/ #live-anchor 服务前缀
#踢流
STREAMHUP:
    URI: http://10.183.60.167:9990/
    OUTPUT:
        URL: streamhub/output/kickoff
    QUERYLIST: 
        URL: streamhub/output/queryList
    NOTICE:
        URL: streamhub/source/notice
    outputvip:
        switch: streamhub/outputvip/switch
lspLiveContent:
  defaultTitle: 默认标题
  defaultCoverImg: http://117.131.17.174:9001/migutv/res/2020/03/24/5HTHLSO8E21O.png

#获取WorldCup.getTemplateList 20200727新增
WORLDCUP:
  GETTEMPLATE:
    URL: /noms-worldcup/v1/cloudAudience/getTemplate
BOX:
  Capacity: 8
  MaxPlayerNum: 8
  MinPlayerNum: 4
  PageId: 2bd187abe0ea41c6b8f2be114c80e47f

remote:
  appManagement:
    addOrUpdateCommitRelease: /app-management-server/commit/H5/addOrUpdateCommitRelease
  sendMsg:
    ssoMessageUrlPrefix: http://10.150.31.220:9888
    ssoMessageUrlSuffix: /interaction-service/ssoMessageCode
    
    

    
#预览环境不存在---------  
robot:
  shell:
    startpushurl: /nas/shell/start.sh
    stoppushurl: /nas/shell/stop.sh
#运编能力
OESLIVEMANAGE:
  RUI: http://10.150.51.128:18080
  BUSINESSTYPE: cloudlive2msdn
  MERGESTREAMCHANNEL: rtmp://cloudlive-msdn-push.miguvideo.com/live2msdn/cloudlive_%s
  TPL: live57
  ADDTIME: 5
  CREATE:
    URL: /oes-live-manage/live/outer-url/channel/create
  DELETE:
    URL: /oes-live-manage/live/outer-url/channel/delete
  QUERYLIST:
    URL: /oes-live-manage/live/outer-url/channel/queryList
  STOP:
    URL: /oes-live-manage/live/outer-url/channel/stop
#---------------------
```



#### 3.无用配置

```yaml
streamhub:
  stream:
    switch: 1
```



#### 4.公用配置

```yaml
apollo:
  portalUrl: http://10.150.21.107:8080
GOODSSYNCHRO:
  URI: http://10.186.54.42:80 #无锡配置
CBC:
  URL: http://10.186.72.167:80 #无锡配置
#430新增超高清  
gk:
  uri: http://10.150.59.114:80  
#20210909新增超高清 
OES:
    URL: http://10.150.51.128:18080/oes-live-manage
```





# live-anchor

#### 1.废弃配置

```yaml
box:
  MaxPlayerNum: 8
  MinPlayerNum: 4
  
#直播转码调度平台
streamhub:
  url: http://10.183.60.167:9990
  notice: /streamhub/source/notice
  query: /streamhub/output/query 

#聊天室访问相关接口  
#chat:
  #url: http://10.186.81.10:9100

#live: 
 # queryNum: 500

#normal:
  #switch: 1
#-------------------不存在--------------------- 
gk:
  uri: http://10.150.59.114:80
transcodeOut:
  appId: xx
  createLiveChannel: /v1/createLiveChannel
  createTranscodeOut: /v1/createTranscodeOut
  deleteTranscodeOut: /v1/deleteTranscodeOut
  getSceneId: /v1/getSceneId
  registNotifyUrl: /v1/registNotifyUrl
  updateTranscodeOut: /v1/updateTranscodeOut
  closeLiveChannel: /v1/closeLiveChannel
  resumeLiveChannel: /v1/resumeLiveChannel
  getLiveChannel: /v1/getLiveChannel
  switchSceneStream: /v1/switchSceneStream
  deleteLiveChannel: /v1/deleteLiveChannel
  url: xx
cloudvideoeditor:
  url: xxxx

liveStatus: http:// 10.150.25.44:8083/live-process/core/create

review: http:// 10.150.25.44:8083/live-process/core/create
#---------------------------------------  

  

  
resolution:
  list:
    - clarity: 480P
      width: 800
      height: 400
      bit: 750000
      fps: 20
    - clarity: 720P
      width: 1280
      height: 720
      bit: 400000
      fps: 15
    - clarity: 1080P
      width: 1920
      height: 1080
      bit: 2750000
      fps: 20
```



#### 2.无用配置

```yaml
busi:
  switchVideoType : 1
  
timeout: 
  redis: 
    UpC: 15
    
switch:
  atPoolInfo: 0
```



#### 3.公用配置

```yaml
ultrahd:
  #无锡10.186.90.59:180
  domain: 10.186.51.101:80 #无锡配置
  url: http://10.186.51.101:80 #无锡配置
remote:
  jobadmin:
    #更新模板时更新定时任务参数
    executorParamPrefix:
    http://10.150.53.123/live-support/overScreen/autoOverScreenByPoolId?poolId=

social:
  #http://10.186.62.135:80
  url: http://10.186.62.135:80 #无锡配置

sale:
  goodsSynchr:
    url: http://10.186.54.42:80/ #无锡配置

#全民播机器人设置接口（chatroom-suport）  
chatroom-suport:
  URL: http://10.172.65.56:8126 #颛桥配置http://10.172.80.31:8080
  
#运编能力  
OESLIVEMANAGE:
  RUI: http://10.150.51.128:18080
  
elasticsearch:
  legao:
    uris: http://10.150.29.116:9200,http://10.150.29.121:9200
    # 颛桥10.172.69.239:9200 10.172.69.238:9200 10.172.69.234:9200 10.172.69.233:9200 10.172.69.232:9200
  contentstatus:
    uris: http://10.150.25.2:9200 #,http://10.125.148.151:9200
    # 颛桥 10.172.65.158:9200 10.172.65.159:9200 10.172.65.160:9200 10.172.65.161:9200
  

  
#云剪配置
outerData:
  cloudVideoEditor:
    url: http://10.150.51.247:8903/fdapi #10.186.100.85:247无锡配置 10.186.100.85:8903 
  uri: http://10.150.51.247/ #10.186.100.87无锡配置

user:
  center:
    #url: http://10.150.59.160:80
    url: http://10.186.96.81:80 #无锡配置

OES:
  URL: http://10.150.51.128:18080/oes-live-manage
```





# video_stream

#### 1.废弃配置

```yaml
topic: BIG_DATA_CLEAR_CASHE

#dTypes:
  #list: 1,2,3,4
  
#notifySwitch:
#  onSwitch: 1
```



#### 2.无用配置

```yaml
#alarm: anchor is suspected of violating the rules once
```



#### 3.公用配置

```yaml
cloudvideoeditor:
  url: http://10.150.51.247:8903/fdapi  #10.186.100.85:247无锡配置  10.186.100.85:8903
ultrahd:
  domain: 10.186.90.59:180 #无锡
  url: http://10.186.90.59:180
bk: http://117.184.229.60:8081/
notify:
  callback: http://10.186.81.129/video-stream-srv/bknotify/notify #颛桥10.172.80.29
  warningurl: http://10.186.81.129/video-stream-srv/bknotify/alarm
  disconurl: http://10.186.81.129/video-stream-srv/bknotify/forbidStream
  offlineurl: http://10.186.81.129/video-stream-srv/bknotify/offLine
  livestatus: http://10.186.81.129/video-stream-srv/migucloud/liveStatusNotify
  recAddress: http://10.186.81.129/video-stream-srv/migucloud/recAddressNotify
  replay: http://10.186.81.129/video-stream-srv/migucloud/videoAccomplishNotify
  cbdownload: http://10.186.81.129/video-stream-srv/migucloud/recDownloadNotify
  combine: http://10.186.81.129/video-stream-srv/migucloud/combineNotify
migucloud:
  create:
    channel: http://10.186.50.211/l2/live/createChannel #无锡
  flush:
    atoken: http://10.186.50.211:8999/a0/user/atoken/flush
  forbid:
    channel: http://10.186.50.211/l2/ctrl/forbidChannel
  get:
    atoken: http://10.186.50.211:8999/a0/user/auth
    channel: http://10.186.50.211/l2/live/getChannel
    play: http://10.186.50.211/vod2/v1/getUrl
    pull: http://10.186.50.211/l2/addr/getPullUrl
    push: http://10.186.50.211/l2/addr/getPushUrl
  remove:
    channel: http://10.186.50.211/l2/live/removeChannel
  resume: 
    channel: http://10.186.50.211/l2/ctrl/resumeChannel
  update:
    channel: http://10.186.50.211/l2/live/updateChannel
  vod:
    pull: http://10.186.50.211/vod2/ps/download/create
  save:
    notify: http://10.186.50.211/l2/notify/saveNotify
  list:
    channel: http://10.186.50.211/l2/live/listChannel
  combine:
    vids: http://10.186.50.211/vod2/t0/combineByVids
streamhub:
  url: http://10.183.60.167:9990 #云桥机房
bkflow:
  url: http://117.184.229.60:8081
  
elasticsearch:
  legao:
    uris: http://10.150.29.116:9200,http://10.150.29.121:9200
    # 颛桥10.172.69.239:9200 10.172.69.238:9200 10.172.69.234:9200 10.172.69.233:9200 10.172.69.232:9200
  contentstatus:
    uris: http://10.150.25.2:9200 #,http://10.125.148.151:9200
    # 颛桥10.172.65.158:9200 10.172.65.159:9200 10.172.65.160:9200 10.172.65.161:9200
```





# live-support

#### 1.废弃配置

```yaml
STREAMHUP:
  URI: http://10.183.60.167:9990/
  OUTPUT:
    URL: streamhub/output/kickoff
  QUERYLIST: 
    URL: streamhub/output/queryList



bigData:
  schoolSpacePath:  /tools/app/live-support/output/schoolSpace/

screen:
  switchOn: 1
  
#live:
  #queryNum: 500
  
#normal:
  #switch: 1
#--------------------不存在------------------------------
pool:
  pre: http://wshls.live.migucloud.com/live/
  url: 10-22E3DITU_C0/playlist.m3u8,20-BEG4KKVY_C0/playlist.m3u8,30-J1H30ZF7_C0/playlist.m3u8,40-FLHF85HJ_C0/playlist.m3u8,50-RX1H1839_C0/playlist.m3u8,60-TNIQLLKQ_C0/playlist.m3u8
```



#### 2.无用配置

```yaml
STREAMHUP:
  STREAM:
    MINSIZE: 1
    MAXSIZE: 150
    
outerData:
  mediaCode: 51
  type: 301
```



#### 3.公用配置

```yaml
chatroom-suport:
  URL: http://10.172.65.56:8126 #http://10.172.80.31:8080
PROGRAM:
  URL: http://vms-worldcup/v2/program/pandent-list/%s/all/%s
  
outerData:
  uri: http://10.150.51.247/ #10.186.100.87无锡
```


二维码登录demo
===
仿微信的二维码登录功能：客户端登录后，通过扫描web端页面上的二维码，实现同一用户在web端的登录

演示地址：dev.jiangkunlun.com

## 实现思路
访问web页面时，如果未登陆，会根据随机字符串生成二维码，显示到页面上，同时将该字符串保存到mongodb内，
然后页面会通过ajax轮询方式访问web端，查看这个二维码是否可以登录，如果可以登录，则将用户名/id写入session，然后将页面跳转到登录状态

客户端扫描页面的二维码后，通过http方式访问web端，将二维码源字符串，以及客户端登录用户的用户名/id发送过去，告诉web端这个用户可以登录

## 运行须知
web端使用php，数据存储使用mongodb，二维码生成使用qrcode
发布目录需要指到webroot下
web端的配置详见app/conf.php，必须配置mongodb，图片存储路径需要写权限

客户端目前只支持ios，二维码识别使用zBar，需要配置真机测试才能使用摄像头扫描功能
(如果使用其他客户端，可以通过访问这个url实现登录：http://yourhost/client_login.php?source=xxxxx&&user=张三)


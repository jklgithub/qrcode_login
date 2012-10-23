<?php 
session_start();
//mongo
$conf['mongo']['host'] = '127.0.0.1';
$conf['mongo']['port'] = '27017';
$conf['mongo']['db'] = 'qrcode_login'; 
$conf['mongo']['collection'] = 'qrcode'; 

//图片存储路径
$conf['qrcode']['temp'] = 'temp';
//纠错等级  array('L','M','Q','H')
$conf['qrcode']['level'] = 'M';
//大小 1～10
$conf['qrcode']['size'] = 8;

//页面ajax轮训的事件间隔  秒
$conf['ajax']['time'] = 5;


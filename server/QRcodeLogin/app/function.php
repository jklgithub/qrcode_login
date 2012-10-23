<?php 
require_once 'conf.php';
require_once 'qrcode.php';

$mongo = false;

//根据session验证是否已登录
function isLogin(){
	return isset($_SESSION['user']) && $_SESSION['user'];
}
//取得二维码源数据，这里使用md5的uniqid
function getQRcodeSource(){
//	return 'test123456';
	return md5(uniqid('', true));
}
//生成二维码，并返回二维码图标，同时将二维码源数据保存入mongo
function buildQRcode($source){
	$img = getQRCodeImg($source, conf('qrcode.temp'), conf('qrcode.level'), conf('qrcode.size'));
	saveSource($source);
	return $img;
}

//mongo	保存
function saveSource($source){
	$collection = getDBCollection(conf('mongo.collection'));
	$collection->insert(array('_id' => $source, 'login' => 0));
}
//ajax轮询检查是否登录		登录成功返回user，否则为false 
function checkSource($source){
	$collection = getDBCollection(conf('mongo.collection'));
	$sou = $collection->findone(array('_id' => $source));
	if($sou && $sou['login'] === 1){
		return $sou['user'];
	}
	return false;
}
//取记录  返回  1 登录成功  10 source有误  11 此source已使用过  21 无此user(暂无此项)
function checkSource4Login($source, $user){
	$collection = getDBCollection(conf('mongo.collection'));
	$sou = $collection->findone(array('_id' => $source));
	$r = 10;
	if($sou && isset($sou['login'])){
		if($sou['login'] === 0){
			$r = 1;//校验正确
		}else{
			$r = 11;
		}
	}
	//保存登录状态
	if($r == 1){
		$collection->update(
				array('_id' => $source), 
				array('$set' => array('login' => 1, 'user' => $user)), 
				array('safe'=>true)
		);
	}
	return $r;
}
//mongo
function getDBCollection($collection){
	global $mongo;
	if(!$mongo){
		$mongo = new Mongo(conf('mongo.host').':'.conf('mongo.port'));
	}
	$db = conf('mongo.db');
	return $mongo->$db->$collection;
}
//取配置
function conf($s){
	global $conf;
	$s_ = explode('.', $s);
	$r = $conf;
	if(count($s_) > 0)
		foreach($s_ as $k)
			if(isset($r[$k]))
				$r = $r[$k];
	return $r;
}









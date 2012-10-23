<?php 
require_once '../app/function.php';

$source = isset($_GET['source']) ? trim($_GET['source']) : '';
$user = isset($_GET['user']) ? trim($_GET['user']) : '';

//给客户端的返回值  0 传入的source或user为空
$r = 0;

if($source && $user){
	$r = checkSource4Login($source, $user);
}

echo json_encode(array('login' => $r.''));
<?php 
require_once '../app/function.php';

$source = $_GET['source'];//$_SESSION['code_source'];

$user = checkSource($source);

if($user !== false){
	$arr = array('login' => 1);
	$_SESSION['user'] = $user;
}else{
	$arr = array('login' => 0);//, 'source' => $source);
}

echo json_encode($arr);
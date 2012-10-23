<?php
require_once '../app/function.php';
if(isset($_SESSION['user'])){
	$_SESSION['user'] = false;
}
header('Location: index.php');
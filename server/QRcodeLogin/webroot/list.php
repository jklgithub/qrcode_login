<?php 
require_once '../app/function.php';
if(!isLogin()){
	header('Location: index.php');
}
?>
<html>
<head>
	<meta charset="UTF-8">
	<title>二维码登录测试</title>
</head>
<body>
    <h1 style="color: #333;padding:10px;">
    	<?php echo $_SESSION['user'];?>，您好！
    	<a style="margin-left: 10px;font-size: 50%;" href="logout.php">(注销)</a>
    </h1>
    <hr>
        登录成功。。。。。。
    <hr>
</body>
</html>
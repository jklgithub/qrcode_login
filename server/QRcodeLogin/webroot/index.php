<?php 
require_once '../app/function.php';
if(!isLogin()){
	$source = getQRcodeSource();
//	$_SESSION['code_source'] = $source;
	$img = buildQRcode($source);
}
?>
<?php if(isset($img)){//登录前?>
<html>
<head>
	<meta charset="UTF-8">
	<title>二维码登录测试</title>
	<script src="js/jquery-1.7.2.min.js"></script>
</head>
<body>
	<h3>请用(QRcodeLogin)手机客户端扫描下面的二维码：</h3>
	<br>
	<img src="<?php echo $img?>"></img>
	<hr>
		test :<br>
		<?php echo $source;?>
		<div class='test'></div>
	<hr>
	<script>
		//ajax轮询时间间隔
		var ASK_TIME = <?php echo conf('ajax.time');?>;
		var i = 0;
		$(function(){
			setInterval(function(){
				$.get('page_ask.php?source=<?php echo $source;?>', function(d){
					if(d && d.login){
						window.location = '';
					}
					$('div.test').html(i++ + '---' + JSON.stringify(d));
				}, 'json');
			}, ASK_TIME * 1000);
		});
	</script>
</body>
</html>
<?php }else{//登录后?>
	<?php require_once 'list.php';?>
<?php }?>
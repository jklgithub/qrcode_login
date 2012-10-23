<?php 
function getQRCodeImg($source, $temp, $errorCorrectionLevel, $matrixPointSize){
	$date = date('Ymd');
	$PNG_WEB_DIR = DIRECTORY_SEPARATOR.$temp.DIRECTORY_SEPARATOR.$date.DIRECTORY_SEPARATOR;
	$PNG_TEMP_DIR = dirname(dirname(__FILE__)).DIRECTORY_SEPARATOR.'webroot'.DIRECTORY_SEPARATOR.$temp.DIRECTORY_SEPARATOR.$date.DIRECTORY_SEPARATOR;
	include_once '../lib/qrcode/qrlib.php';
//echo $PNG_TEMP_DIR;
	if (!file_exists($PNG_TEMP_DIR))
		mkdir($PNG_TEMP_DIR);

	if (!in_array($errorCorrectionLevel, array('L','M','Q','H')))
		$errorCorrectionLevel = 'M';    

	$matrixPointSize = min(max((int)$matrixPointSize, 1), 10);

	$filename = md5($source.'|'.$errorCorrectionLevel.'|'.$matrixPointSize).'.png';

	QRcode::png($source, $PNG_TEMP_DIR.$filename, $errorCorrectionLevel, $matrixPointSize, 2); 

	return $PNG_WEB_DIR.$filename;
}
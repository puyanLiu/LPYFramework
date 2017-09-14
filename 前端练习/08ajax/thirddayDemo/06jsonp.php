<?php
	$callback = $_GET['_jsonp'];
	$arr = array("zhangsan", "lisi", "wangwu");

	echo $callback."(".json_encode($arr).")";
?>
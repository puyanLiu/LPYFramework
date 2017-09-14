<?php
	header("Content-Type:text/html;charset=utf-8");
	$username = $_GET['username'];
	$password = $_GET['password'];

	echo '用户名'.$username.'密码'.$password;

	header("location:01form.html?flag=1");

?>
<?php
	$username = $_POST['username'];
	$password = $_POST['password'];

	if ($username == 'admin' && $password == 'admin') {
		echo 1;
	} else {
		echo 2;
	}
?>
<?php
	$username = $_GET['username'];
	$password = $_GET['password'];

	$flag = 1;
	if ($flag == 1) {
		echo '用户名'.$username.' 密码'.$password;
	} else {
		echo 0;
	}
?>

<script>
	parent.document.getElementById('showInfo').innerHTML = '注册成功';
</script>
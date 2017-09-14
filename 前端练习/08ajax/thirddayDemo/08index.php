<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style type="text/css">
		* {
			margin: 0;
			padding: 0;
		}
		ul {
			list-style: none;
		}

	</style>
	<script src="jquery-1.11.2.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		function ajax(param, callback) {
			// 创建xhr对象
    		var xhr = null;
    		if (window.XMLHttpRequest) {
    			// 标准浏览器
    			xhr = new XMLHttpRequest();
    		} else {
    			// 早起的IE浏览器
    			xhr = new ActiveXObject('Microsoft.XMLHTTP');
    		}
    		// 准备发送请求-配置发送请求的一些行为
    		xhr.open('post', '08tologin.php');
    		xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    		// 指定一些回调函数
    		xhr.onreadystatechange = function() {
    			if (xhr.readyState == 4) {
    				if (xhr.status == 200) {
    					var data = xhr.responseText;
    					callback(xhr.responseText);
    				} else {
    					alert('请求失败');
    				}
    			}
    		}
    		param = (function(obj) {
    			var str = "";
    			for(var prop in obj) {
    				str += prop + "=" + obj[prop] + "&";
    			}
    			return str;
    		})(param);
    		console.log(param);
    		xhr.send(param);
		}

		window.onload = function() {
			var tologin = document.getElementById('loginid');
			tologin.onclick = function(){
				var postData = {};
				postData.username = document.getElementById('username').value;
				postData.password = document.getElementById('password').value;
				var callback = function(flag){
					if(flag==1){
						//登录成功
						document.getElementById('login').innerHTML = document.getElementById('username').value;
					}else{
						alert("用户名或密码错误！");
					}
				}
				ajax(postData,callback);
				// jQuery的ajax请求
				// $.ajax({
				// 	url: './tologin.php',
				// 	type: 'POST',
				// 	dataType: 'html',
				// 	data: {username: 'qqq',password:"123"},
				// 	success:function(data){
				// 		alert(data);
				// 	},error:function() {
				// 		alert(0);
				// 	}
				// })
				
			}
		}
	</script>
</head>
<body>
	<?php
		$logoPath = "images/baidu.png";
	?>
	<img src="<?php echo $logoPath?>" alt="">
	<div id="login"></div>
	<div id="loginform">
		用户名：<input type="text" name="username" id="username"><br>
		密码：<input type="password" name="password" id="password"><br>
		<input type="button" value="登录" id="loginid">
		<input type="button" value="取消" id="cancelid">
	</div>
</body>
</html>
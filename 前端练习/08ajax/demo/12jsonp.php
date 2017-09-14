<?php
$fn = $_GET['cb'];
$arr = array('zhangsan','lisi','wangwu');
echo $fn.'('.json_encode($arr).');';


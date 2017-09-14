var React = require('react');
var ReactDOM = require('react-dom');
var style = require('./app.css');

ReactDOM.render(
	<div>
		<h1 className={style.h1}>哈哈</h1>
		<h2 className="h2">嘻嘻</h2>
		<h1 className={style.h1}>哈哈</h1>
	</div>,
	document.getElementById('example')
	);
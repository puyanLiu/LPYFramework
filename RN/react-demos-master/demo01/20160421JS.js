// React.createElement 创建树，第一个参数是标签，第二个参数是一个属性对象，第三个参数是子节点
var aHello = React.createElement('a', {
	href: 'http://facebook.github.io/react/'
}, 'Hello React');

var child = React.createElement('li', null, 'Text Content');
var root = React.createElement('ul', {
	className: 'my-list'
}, child);

var root1 = React.DOM.ul({
	className: 'my-list1'
}, React.DOM.li(null, 'Text Content'));

// React.render(root, document.body);


// JSX转换
// var Nav;
// 输入（JSX）
// var app = <Nav color='blue' />;
// 输出 JS
// var app = React.createElement(Nav, {color: 'blue'})

// 属性表达式
// 输入（JSX）
// var person = <Person name={window.isLoggedIn ? window.name : ''} />;
// 输出 JS
// var person = React.createElement(Person, {name: window.isLoggedIn ? window.name : ''});

// 子节点表达式
// 输入（JSX）
// var content = <Container>{window.isLoggedIn ? <Nav /> : <Login />}</Container>;
// 输出 JS
// var content = React.createElement(Container, null, window.isLoggedIn ? React.createElement(Nav) : React.createElement(Login));


// 延展属性
// 传入对象的属性会呗复制到组件内，它能被多次使用，也可以和其它属性一起用，注意顺序，后面的会覆盖掉前面的
// ...操作符（延展操作符）
// var props = {'foo': 'default'};
// var component = <Component {...props} foo={'override'}>


var HelloWorld = React.createClass({
	render: function() {
		{ /* 一般注释，用{}包围 */ }
		/*
			多行注释
			
			HTML实体可以插入到JSX的文本中

			如果想在JSX表达式中显示HTML实体，可能会遇到二次转义的问题，因为React默认会转义所有字符串，为了防止各种XSS攻击
			
			最简单的是直接使用Unicode字符（确保文件是uft-8编码且网页也指定为utf-8编码）

			可以在数组里混合使用字符串和JSX元素

			可以直接使用原生HTML

			自定义HTML属性
			如果往原生HTML元素里传入HTML规范里不存在的属性，React不会显示它们，如果需要使用自定义属性，要加data-前缀
			以aria-开头的[网络无障碍]属性可以正常使用
		*/
		return (<p>Hello, <input type="text" placeholder="Your name here"/>!
		It is {this.props.date.toTimeString()}
		<div>First &middot; Second</div>
		<div>{'First &middot; Second'}</div>
		<div>First · Second</div>
		<div>{'First · Second'}</div>

		<div>{'First \u00b7 Second Unicode编码'}</div>
		<div>{'First ' + String.fromCharCode(183) + ' Second'}</div>

		<div>{['First ', <span>&middot;</span>, ' Second', ' 数组中混合使用']}</div>

		<div dangerouslySetInnerHTML={{__html: 'First &middot; Second'}} />

		<div data-custom-attribute="foo">自定义HTML属性</div>

		<div aria-hidden={true}>哈哈</div>
		</p>); // 行尾注释
	}
});

setInterval(function() {
	React.render(<HelloWorld date={new Date()} />, document.getElementById('example'));
}, 500);
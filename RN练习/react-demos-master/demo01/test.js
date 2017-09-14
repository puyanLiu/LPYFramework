$(document).ready(
	function() {
		var count = 0;
		var style = {
			color: "red",
			border: "1px #000 solid"
		};
		var HelloWorld = React.createClass({
			getDefaultProps: function() {
				console.log("getDefaultProps", "1");
				return {
					"name": "Tom"
				};
			},
			getInitialState: function() {
				console.log("getInitialState", "2");
				return {
					myCount: count++,
					ready: false
				};
			},
			componentWillMount: function() {
				console.log("componentWillMount", "3");
				this.setState({
					ready: true
				});
			},
			render: function() {
				console.log("render", "4");
				return <p ref="childp">
				Hello,{this.props.name ? this.props.name : "World"}
				<br />
				{"" + this.state.ready} {this.state.myCount}
				</p>;
			},
			componentDidMount: function() {
				console.log("componentDidMount", "5");
				$(React.findDOMNode(this)).append('surprise!');
			},
		});

		ReactDOM.render(
			<div>
				<HelloWorld /> < HelloWorld / > 
			</div>,
			document.getElementById('example')
		);
	})
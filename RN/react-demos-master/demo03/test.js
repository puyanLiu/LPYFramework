$(document).ready(
	function() {
		var HelloWorld = React.createClass({
			getDefaultProps: function() {
				console.log("getDefaultProps", "1");
			},
			getInitialState: function() {
				console.log("getInitialState", "2");
				return null;
			},
			componentWillMount: function() {
				console.log("componentWillMount", "3");
			},
			componentDidMount: function() {
				console.log("componentDidMount", "5");
			},

			componentWillReceiveProps: function(newProps) {
				console.log("componentWillReceiveProps", "11");
				console.log(newProps);
			},
			shouldComponentUpdate: function() {
				console.log("shouldComponentUpdate", "21");
				return true;
			},
			componentWillUpdate: function() {
				console.log("componentWillUpdate", "31");
			},
			render: function() {
				console.log("render", "41");
				return <p>Hello, {this.props.name ? this.props.name : "world"}</p>
			},
			componentDidUpdate: function() {
				console.log("componemtDidUpdate", "51");
				$(ReactDOM.findDOMNode(this)).append("surprise!");
			},
			componentWillUnmount: function() {
				console.log("componentWillUnmount");
			}
		});

		var HelloUniverse = React.createClass({
			getInitialState: function() {
				return {
					name: ''
				};
			},
			handleChange: function(event) {
				// 移除组件方式2
				if (event.target.value == '123') {
					ReactDOM.unmountComponentAtNode(document.getElementById("example"));
					return;
				}
				this.setState({
					name: event.target.value
				});
			},
			render: function() {
				// 移除组件方式1
				// if (this.state.name == '123') {
				// 	return <div>123</div>;
				// }
				return (<div><HelloWorld {...this.state} /> < br />
				<input type="text" onChange={this.handleChange} /> </div>);
			}
		});
		ReactDOM.render(
			<div>
				<HelloUniverse />
			</div>,
			document.getElementById('example')
		);
	})
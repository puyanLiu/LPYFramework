var HelloWorld = React.createClass({
	getInitialState: function() {
		return {
			backgroundColor: '#FFFFFF'
		};
	},
	handleWheel: function(event) {
		var newColor = (parseInt(this.state.backgroundColor.substr(1), 16) + event.deltaY * 997).toString(15);
		newColor = '#' + newColor.substr(newColor.length - 6).toUpperCase();
		this.setState({
			backgroundColor: newColor
		});
	},
	render: function() {
		console.log(this.state);
		return (<div onWheel={this.handleWheel} style={this.state}>
				<p>Hello, World</p>
			</div>);
	},
});

var KeyWorld = React.createClass({
	getInitialState() {
			return {
				password: ''
			};
		},
		handleKeyPress(event) {
			this.setState({
				password: this.state.password + event.which
			});
			console.log(this.state);
		},
		handelChange(event) {
			event.target.value = '';
		},
		render() {
			return (
				<div>
				<input onKeyPress={this.handleKeyPress} onChange={this.handelChange} />
				<p style={{'display': this.state.password.indexOf('979899') >= 0 ? 'inline' : 'none'}} >
					You got it!
				</p>
				</div>
			);
		}
});

var ClientXY = React.createClass({
	getInitialState() {
			return {
				x: 0,
				y: 0
			};
		},
		handleMouseMove(event) {
			this.setState({
				x: event.clientX,
				y: event.clientY
			});
		},
		render() {
			return <div onMouseMove={this.handleMouseMove} style={{height: '1000px', width: '700px', backgroundColor: 'gray'}}>
				{this.state.x + ',' + this.state.y}
			</div>;
		}
});
ReactDOM.render(<div><ClientXY /><HelloWorld /><KeyWorld /></div>, document.getElementById('example'));
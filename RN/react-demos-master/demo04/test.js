var Content = React.createClass({
	getInitialState: function() {
		return {
			inputText: ""
		};
	},
	handleChange: function(event) {
		this.setState({
			inputText: event.target.value
		});
	},
	handleSUbmit: function() {
		console.log("reply To：" + this.props.selectName + '\n' + this.state.inputText);
	},
	render: function() {
		return <div>
			<textarea placeholder="please enter something..." onChange={this.handleChange} /><br />
			<button onClick={this.handleSUbmit}>submit</button>
		</div>;
	}
});

var Comment = React.createClass({
	getInitialState: function() {
		return {
			names: ['Tim', 'John', 'Hank'],
			selectName: ''
		};
	},
	handleSelect: function(event) {
		this.setState({
			selectName: this.state.names[event.target.value]
		});
	},
	render: function() {
		var options = [];
		for (var option in this.state.names) {
			options.push(<option value={option} key={option}>{this.state.names[option]}</option>);
		}
		return <div>
		<select onChange={this.handleSelect}>
			{options}
		</select>
		<Content selectName={this.state.selectName}></Content>
		</div>;
	}
});

ReactDOM.render(<Comment></Comment>, document.getElementById('example'));
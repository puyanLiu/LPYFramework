var names = ['Alice', 'Emily', 'Kate'];
var arr = [
    <h1>aaa</h1>,
    <h2>bbb</h2>
];
var HelloMessage = React.createClass({
    render: function() {
        return <h1>hh,{this.props.name},{this.props.title}</h1>;
    }
});
var NodesList = React.createClass({
    render: function() {
        return (
            <ol>
        		{
        			React.Children.map(this.props.children, function(child) {
        				return <li>{child}</li>;
        			})
        		}, 
        		{
        			React.Children.count(this.props.children)
        		}
        	</ol>
        );
    }
});
var MyTitle = React.createClass({
    getDefaultProps: function() {
        return {
            title: 'Hello World',
            name: '789'
        };
    },
    propTypes: {
        title: React.PropTypes.string.isRequired,
        name: React.PropTypes.string,
    },
    render: function() {
        return <h1>{this.props.title} {this.props.name}</h1>;
    }
});
var MyComponent = React.createClass({
    handleClick: function() {
        this.refs.myTextInput.focus();
    },
    render: function() {
        return (
            <div>
            	<input type="text" ref="myTextInput" />
            	<input type="button" value="获取文本焦点" onClick={this.handleClick} />
            </div>
        );
    }
});
var LikeButton = React.createClass({
    getInitialState: function() {
        return {
            liked: false,
            seleted: false,
        };
    },
    handleClick: function() {
        this.setState({
            liked: !this.state.liked,
            selected: !this.state.selected
        });
    },
    render: function() {
        var text = (this.state.liked ? 'like' : 'havent\'t liked') + '<br />' + (this.state.selected ? 'selected' : 'havent\'t selected');

        return (
            <p onClick={this.handleClick}>
				You <span dangerouslySetInnerHTML={{__html: text}} /> this. Click to toggle.
			</p>
        );
    }
});
var Input = React.createClass({
    getInitialState: function() {
        return {
            value: 'Hello!'
        };
    },
    handleChange: function(event) {
        this.setState({
            value: event.target.value
        });
    },
    render: function() {
        var value = this.state.value;
        return (
            <div>
            	<input type="text" value={value} onChange={this.handleChange} />
            	<p>{value}</p>
        	</div>
        );
    }
});
var Hello = React.createClass({
    getInitialState: function() {
        return {
            opacity: 1.0
        };
    },

    componentDidMount: function() {
        this.timer = setInterval(function() {
            var opacity = this.state.opacity;
            opacity -= .05;
            if (opacity < 0.1) {
                opacity = 1.0;
            }
            this.setState({
                opacity: opacity
            });
        }.bind(this), 100);
    },
    render: function() {
        return (
            <div style={{opacity: this.state.opacity}}>
				Hello {this.props.name}
			</div>
        );
    }
});
var UserGist = React.createClass({
    getInitialState: function() {
        return {
            username: '',
            lastGistUrl: ''
        };
    },
    componentDidMount: function() {
        $.get(this.props.source, function(result) {
            var lastGist = result[0];
            if (this.isMounted()) {
                this.setState({
                    username: lastGist.owner.login,
                    lastGistUrl: lastGist.html_url
                });
            }
        }.bind(this));
    },
    render: function() {
        return (
            <div>
				{this.state.username}‘s last gist is  
				<a href={this.state.lastGistUrl}>here</a>	
			</div>
        );
    }
});
var RepoList = React.createClass({
    getInitialState: function() {
        return {
            loading: true,
            error: null,
            data: null
        };
    },
    componentDidMount: function() {
        this.props.promise.then(
            value => this.setState({
                loading: false,
                data: value
            }),
            error => this.setState({
                loading: false,
                error: error
            })
        );
    },
    render: function() {
        if (this.state.loading) {
            return <span>loading....</span>;
        } else if (this.state.error) {
            return <span>Error:{this.state.error.message}</span>;
        } else {
            var repos = this.state.data.items;
            var repoList = repos.map(function(repo) {
                return (
                    <li>
                        <a href={repo.html_url}>{repo.name}</a>
                        ({repo.stargazers_count} stars) <br />
                        {repo.description}
                    </li>
                );
            })
            return (
                <main>
                <h1>github demo</h1>
                <ol>{repoList}</ol>
            </main>
            );
        }
    }
});
ReactDOM.render(
    <div>
        <RepoList promise={$.getJSON('https://api.github.com/search/repositories?q=javascript&sort=stars')} />
    	<UserGist source="https://api.github.com/users/octocat/gists"/>
    	<Hello name="world" />
    	<Input />
    	<LikeButton />
    	<MyComponent />
		{
			names.map(function(name){
				return <div>Hello, {name}</div>;
			})
		}
		{arr}
		<HelloMessage name="liu" title="title"/>
		<NodesList>
			<span>hello</span>
			<p>world</p>
			<span>hello</span>
			<span>hello</span>
		</NodesList>
		<MyTitle title='123' />
	</div>,
    document.getElementById('example')
);
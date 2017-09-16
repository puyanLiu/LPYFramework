import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Card extends Component {
  render() {
    console.log(this.props.children);
    return (
      <div>
        {this.props.children[0]}
        <div>
          {this.props.children}
        </div>
      </div>
    );
  }
}

class Index extends Component {
  render() {
    return (
      <div>
        <Card>
          <h2>React.js</h2>
          <div>开源、免费、专业、简单</div>
          订阅：<input />
        </Card>
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

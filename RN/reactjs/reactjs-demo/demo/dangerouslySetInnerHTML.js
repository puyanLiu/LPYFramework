import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Editor extends Component {

  constructor() {
    super();
    this.state = {
      content: '<h1>react.js</h1>'
    };
  }

  /**
   * dangerouslySetInnerHTML 传入对象，这个对象的__html属性值就相当于元素的innerHTML，这样就可动态渲染元素的innerHTML结构了
   */
  render() {
    return (
      <div>
        {this.state.content}
        <div dangerouslySetInnerHTML={{__html: this.state.content}}></div>
        <h1 style={{fontSize: '12px', color: 'red'}}>React</h1>
      </div>
    );
  }
}

ReactDOM.render(
  <Editor />,
  document.getElementById('root')
);

import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Title extends Component {
  _handleClickOnTitle(e) {
    /**
     * react.js调用传递给它的方法的时候，并不是通过对象方法的方式调用(this._handleClickOnTitle)，
     * 而是直接通过函数调用(_handleClickOnTitle)，所以事件监听函数内并不能通过this获取到实例
     * 
     * react.js的事件监听方法需要手动bind到当前实例，这种模式在react.js中非常常用
     * 
     * 如果想在事件函数中使用当前的实例，需要手动地将实例方法bind到当前实例上再传入给react.js，
     * bind会把实例方法绑定到当前实例上，然后我们再把绑定后的函数传给react.js的onClick事件监听
     */
    console.log(this); // null or undefined
    console.log('click on title', e.target.innerHTML, e);
  }

  _handleClickOnTitle1(word, e) {
    console.log(word);
  }

  render() {
    return (
      <div>
        <h1 onClick={this._handleClickOnTitle}>React 小书 this不同</h1> 
        <h1 onClick={this._handleClickOnTitle.bind(this)}>React 小书 this不同</h1> 
        <h1 onClick={this._handleClickOnTitle1.bind(this, 'Hello')}>React 小书</h1> 
      </div>
    );
  }
}

class Header extends Component {
  render () {
    return (
      <div>
          <Title />
          <h2>This is header</h2>
      </div>
    );
  }
}

class Main extends Component {
  render() {
    return (
      <div>
        <h2>This is main content</h2>
      </div>
    );
  }
}

class Footer extends Component {
  render() {
    return (
      <div>
        <h2>This is footer</h2>
      </div>
    );
  }
}

class Index extends Component {
  render() {
    return (
      <div>
        <Header />
        <Main />
        <Footer />
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

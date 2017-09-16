import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';


class LikeButton extends Component {
  constructor() {
    super();
    this.state = {
      isLiked: false,
      name: 'Tomy'
    };
  }

  _handleClickOnLikeButton() {
    /**
     * setState 方法由父类 Component 所提供。当我们调用这个函数的时候，React.js 会更新组件的状态 state ，
     * 并且重新调用 render 方法，然后再把 render 方法所渲染的最新的内容显示到页面上
     * 
     * 注意，当我们要改变组件的状态的时候，不能直接用 this.state = xxx 这种方式来修改，
     * 如果这样做 React.js 就没办法知道你修改了组件的状态，它也就没有办法更新页面。
     * 所以，一定要使用 React.js 提供的 setState 方法，它接受一个对象或者函数作为参数
     * 
     * 传入一个对象的时候，这个对象表示该组件的新状态
     * 
     * 当你调用 setState 的时候，React.js 并不会马上修改 state。
     * 而是把这个对象放到一个更新队列里面，稍后才会从队列当中把新的状态提取出来合并到 state 当中，
     * 然后再触发组件更新。
     */
    console.log(this.state.isLiked);
    this.setState({
      isLiked: !this.state.isLiked
    });
    console.log(this.state.isLiked);

    // 在setState之后使用新的state来做后续运算做不到
    this.setState({count: 0});
    this.setState({count: this.state.count + 1});
    this.setState({count: this.state.count + 2});
    console.log(this.state.count); //NaN

    // setState 函数作为参数，react.js会把上一个setState的结果传入这个函数
    this.setState((prevState) => {
      console.log(prevState);
      return { count1: 0 }
    });
    this.setState((prevState) => {
      console.log(prevState);
      return { count1: prevState.count1 + 1 }
    });
    this.setState((prevState) => {
      console.log(prevState);
      return { count1: prevState.count1 + 2 }
    });
    console.log(this.state.count1);
  }

  render() {
    return (
      <button onClick={this._handleClickOnLikeButton.bind(this)}>
        {this.state.isLiked ? '取消' : '点赞'} 👍
      </button>
    );
  }
}

class Index extends Component {
  render() {
    return (
      <div>
        <LikeButton />
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

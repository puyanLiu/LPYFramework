import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

/**
 * 更新阶段
 * setState导致React.js重新渲染组件并且把组件的变化应用到DOM元素上的过程，这是一个组件的变化过程
 */

class Header extends Component {
  /**
   * 一般情况，所有关于组件自身的状态的初始化工作都会放在constructor里面去做
   */
  constructor() {
    super();
    console.log('constructor');
    this.state = {
      date: new Date()
    };
  }

  /**
   * 一些组件启动的动作，包括像Ajax数据的拉取操作、一些定时器的启动等，就可以在componentWillMount里面进行
   */
  componentWillMount() {
    console.log('componentWillMount');
    this.timer = setInterval(() => {
      // setState只能在已经挂载或者正在挂载的组件上调用
      this.setState({ date: new Date() });
    }, 1000);
  }

  render() {
    console.log('render');
    return (
      <div>
        <h1 className='title'>现在的时间是</h1>
        {this.state.date.toLocaleTimeString()}
      </div>
    );
  }

  /**
   * 有些组件的启动工作室依赖DOM的，例如动画的启动，而在componentWillMount的时候组件还没有挂载完成，因此没法进行这些启动工作，
   * 这时候就把这些操作放在componentDidMount当中
   */
  componentDidMount() {
    console.log('componentDidMount');
  }

  /**
   * 组件销毁调用，做一些数据清理工作
   */
  componentWillUnmount() {
    console.log('componentWillUnmount');
    // 清除该组件的定时器和其他数据清理工作
    clearInterval(this.timer);
  }

  /**
   * 可以通过这个方法控制组件是否重新渲染，如果返回false组件就不会重新渲染，一般用在性能优化上
   * @param {*} nextProps 
   * @param {*} nextState 
   */
  shouldComponentUpdate(nextProps, nextState) {
    return false;
  }

  /**
   * 组件从父组件接收到新的props之前调用
   * @param {*} nextProps 
   */
  componentWillReceiveProps(nextProps) {

  }

  /**
   * 组件开始重新渲染之前调用
   */
  componentWillUpdate() {

  }

  /**
   * 组件重新渲染并且把更改变更到真实的DOM以后调用
   */ 
  componentDidUpdate() {

  }
}

class Index extends Component {
  constructor() {
    super();
    this.state = {
      isShowHeader: true
    }
  }

  _handleShowOrHide() {
    this.setState({
      isShowHeader: !this.state.isShowHeader
    });
  }

  render() {
    return (
      <div>
        { this.state.isShowHeader ? <Header /> : null }
        <button onClick={this._handleShowOrHide.bind(this)}>
          显示或者隐藏标题
        </button>
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import './index.css';
import Header from './containers/Header.js';
import Content from './containers/Content.js';

/**
 * Dumb组件：只会接受props并且渲染确定结果的组件
 * Smart组件：专门做数据相关的应用逻辑，和各种数据打交道、和Ajax打交道，然后把数据通过props传递给Dumb
 * 所有的Dumb组件都放在components/目录下
 * 所有的Smart组件都放在containers/目录下
 * 
 * Smart 组件可以使用 Smart、Dumb 组件；而 Dumb 组件最好只使用 Dumb 组件，否则它的复用性就会丧失
 * 
 * Smart 组件并不意味着完全不能复用，Smart 组件的复用性是依赖场景的，在特定的应用场景下是当然是可以复用 Smart 的。
 * 而 Dumb 则是可以跨应用场景复用，Smart 和 Dumb 都可以复用，只是程度、场景不一样
 * 
 * @param {*} state 
 * @param {*} action 
 */

const themeReducer = (state, action) => {
  if(!state) {
    return {
      themeColor: 'red',
      headerTitle: 'header Title'
    }; 
  }
  switch(action.type) {
    case 'CHANGE_COLOR':
      return {
        ...state, // 复制appState里面的内容
        themeColor: action.themeColor
      };
    case 'CHANGE_HEADERTITLE':
      return {
        ...state, // 复制appState里面的内容
        headerTitle: action.headerTitle
      };
    default:
      return state; // 没有修改，返回原来的对象
  }
}

const store = createStore(themeReducer);

class Index extends Component {

  render() {
    return (
      <div>
        <Header />
        <Content />
      </div>
    );
  }
}

/**
 * 把Provider作为组件树的根节点，外界通过props给它提供store，它会把store放到自己的context里面，子组件connect的时候能够获取到
 */
ReactDOM.render(
  <Provider store={store}>
    <Index />
  </Provider>,
  document.getElementById('root')
);

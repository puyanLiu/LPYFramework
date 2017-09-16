import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import Header from './Header.js';
import Content from './Content.js';
import { Provider } from './react-redux.js';

function createStore(reducer) {
  let state = reducer();
  const listeners = [];
  // const subscribe = (listener) => listeners.push(listener);
  const subscribe = (listener) => listeners.push(listener);
  // getState用户获取state数据，就是简单地把state参数返回
  const getState = () => state;
  // dispatch用于修改数据，接受action，然后会把state和action一并传给reducer，那么reducer就可以根据action来修改state了
  const dispatch = (action) => {
    let newState = reducer(state, action);
    state = newState;
    listeners.forEach((listener) => listener());
  };
  return { getState, dispatch, subscribe };
}

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

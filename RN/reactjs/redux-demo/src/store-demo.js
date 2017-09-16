
/**
 * Redux 
 * 一种新型的前端“架构模式”
 * 
 * Redux和React-redux并不是一个东西
 * Redux是一种架构模式（Flux架构的一种变种），它不关注你到底用什么库，你可以把它任意结合使用
 * React-redux就是把Redux这种架构模式和React.js结合起来的一个库，就是Redux架构在React.js中的体现
 * 
 */

/**
 * 此demo存在重大隐患，渲染数据使用的是一个共享状态appState，每个人都可以修改它
 * 一个可以被不同模块任意修改共享的数据状态就是魔鬼，一旦数据可以任意修改，所有对共享状态的操作都是不可预料的
 * 
 * 矛盾问题：
 * “模块（组件）之间需要共享数据”和“数据可能被任意修改导致不可预料的结果”之间的矛盾
 * 
 * 修改问题：
 * 模块（组件）之间可以共享数据，也可以改数据。但是我们约定，这个数据并不能直接改，
 * 你只能执行某些我允许的某些修改，而且你修改的必须大张旗鼓地告诉我
 * 
 */
let appState = {
  title: {
    text: 'React.js',
    color: 'red'
  },
  content: {
    text: 'React.js content',
    color: 'blue'
  }
}

function stateChanger(state, action) {
  switch(action.type) {
    case 'UPDATE_TITLE_TEXT':
        appState.title.text = action.text;
      break;
    case 'UPDATE_TITLE_COLOR':
      appState.title.color = action.color;
      break;
    default:
      break;
  }
}

/**
 * 函数createStore，用来专门生产这种state和dispatch的集合
 * 
 * state：表示应用程序状态
 * stateChanger：描述应用程序状态会根据action发生什么变化，相当于dispatch代码里面的内容
 * 
 * 监控数据变化，用订阅者模式
 */
function createStore(state, stateChanger) {
  const listeners = [];
  const subscribe = (listener) => listeners.push(listener);
  // getState用户获取state数据，就是简单地把state参数返回
  const getState = () => state;
  // dispatch用于修改数据，接受action，然后会把state和action一并传给stateChanger，那么stateChanger就可以根据action来修改state了
  const dispatch = (action) => {
    stateChanger(state, action);
    listeners.forEach((listener) => listener());
  };
  return { getState, dispatch, subscribe };
}

function renderApp(appState) {
  renderTitle(appState.title);
  renderContent(appState.content);
}

function renderTitle(title) {
  const titleDOM = document.getElementById('title');
  titleDOM.innerHTML = title.text;
  titleDOM.style.color = title.color;
}

function renderContent(content) {
  const contentDOM = document.getElementById('content');
  contentDOM.innerHTML = content.text;
  contentDOM.style.color = content.color;
}

/**
 * 将appState和dispatch集中到一个地方，起个名字叫store
 */
const store = createStore(appState, stateChanger);
store.subscribe(() => renderApp(store.getState()));

renderApp(store.getState()); // 首次渲染页面
store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '我是被修改的标题' });
store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'green' });
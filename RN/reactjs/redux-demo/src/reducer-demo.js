
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
// 定一个 reducer
function reducer (state, action) {
  // 初始化 state 和 switch case
}

// 生成 store
const store = createStore(reducer)

// 监听数据变化重新渲染页面
store.subscribe(() => renderApp(store.getState()))

// 首次渲染页面
renderApp(store.getState()) 

// 后面可以随意 dispatch 了，页面自动更新
store.dispatch(...)
 */

/**
 * reducer既充当了获取初始化数据的功能，也充当了生成更新数据的功能
 * 如果传入state就生成更新数据，否则就是初始化数据
 */
function reducer(state, action) {
  if(!state) {
    return {
      title: {
        text: 'React.js',
        color: 'red'
      },
      content: {
        text: 'React.js content',
        color: 'blue'
      }
    }
  }
  switch(action.type) {
    case 'UPDATE_TITLE_TEXT':
      // appState.title.text = action.text;
      return {
        ...state, // 复制appState里面的内容
        title: { // 用一个新的对象覆盖原来的title属性
          ...state.title,
          text: action.text
        }
      };
    case 'UPDATE_TITLE_COLOR':
      // appState.title.color = action.color;
      return {
        ...state, // 复制appState里面的内容
        title: { // 用一个新的对象覆盖原来的title属性
          ...state.title,
          color: action.color
        }
      };
    default:
      return state; // 没有修改，返回原来的对象
  }
}

/**
 * 函数createStore，用来专门生产这种state和dispatch的集合
 * 
 * state：表示应用程序状态
 * reducer： 这个函数规定是一个纯函数，它接受两个参数，state和action
 * reducer是不允许有副用作的，不能再里面操作DOM，也不能发ajax请求，更不能直接修改state，它要做的仅仅是：初始化和计算新的state
 * 
 * 监控数据变化，用订阅者模式
 */
function createStore(reducer) {
  let state = reducer();
  const listeners = [];
  const subscribe = (listener) => listeners.push(listener);
  // getState用户获取state数据，就是简单地把state参数返回
  const getState = () => state;
  // dispatch用于修改数据，接受action，然后会把state和action一并传给reducer，那么reducer就可以根据action来修改state了
  const dispatch = (action) => {
    let newState = reducer(state, action);
    let oldState = state;
    listeners.forEach((listener) => listener(newState, oldState));
  };
  return { getState, dispatch, subscribe };
}

/**
 * 在每个渲染函数执行渲染操作之前先做个判断，判断传入的新数据和旧的数据是不是相同的，相同的话就不渲染了
 */
function renderApp(newAppState, oldAppState = {}) { // 防止oldAppState没有传入，给个默认值
  if(newAppState === oldAppState)
    return; // 数据没有变化就不渲染
  console.log('render app');
  renderTitle(newAppState.title, oldAppState.title);
  renderContent(newAppState.content, oldAppState.content);
}

function renderTitle(newTitle, oldTitle = '') {
  if(newTitle === oldTitle) 
    return;
  console.log('render title');
  const titleDOM = document.getElementById('title');
  titleDOM.innerHTML = newTitle.text;
  titleDOM.style.color = newTitle.color;
}

function renderContent(newContent, oldContent = '') {
  if(newContent === oldContent)
    return;
  console.log('render content');
  const contentDOM = document.getElementById('content');
  contentDOM.innerHTML = newContent.text;
  contentDOM.style.color = newContent.color;
}

/**
 * 将appState和dispatch集中到一个地方，起个名字叫store
 */
const store = createStore(reducer);
// 监听数据变化
store.subscribe((newState, oldState) => {
  renderApp(newState, oldState);
});
renderApp(store.getState()); // 首次渲染页面
store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '我是被修改的标题' });
store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'green' });
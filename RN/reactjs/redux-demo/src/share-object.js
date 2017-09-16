
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
 * 共享结构的对象提高性能
 */

/**
 * 共享结构的对象
 */
//  const obj = { a: 1, b: 2};
//  const obj2 = { ...obj }; // 新建一个对象obj2，然后把obj所有的属性都复制到obj2里面，相当远对象的浅复制
//  const obj3 = { ...obj, b: 3, c: 4}; // 覆盖、拓展对象属性
//  console.log(obj === obj2, obj2, obj3);

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

/**
 * 禁止直接修改原来的对象，一旦要修改某些东西，就把修改路径上的所有对象复制一遍
 * 最后的所有对象具有某些不变共享的结构
 */
function stateChanger(state, action) {
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
    let newState = stateChanger(state, action);
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
const store = createStore(appState, stateChanger);
store.subscribe((newState, oldState) => {
  renderApp(newState, oldState);
});

renderApp(store.getState()); // 首次渲染页面
store.dispatch({ type: 'UPDATE_TITLE_TEXT', text: '我是被修改的标题' });
store.dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'green' });
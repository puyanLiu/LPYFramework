
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

/**
 * 专门负责数据的修改
 * 所有对数据的操作必须通过dispatch函数
 * 它接收一个参数action，这个action是一个普通的js对象，里面必须包含一个type字段来声明你到底想干什么
 * dispatch在switch里面会识别这个type字段，能够识别出来的操作才会执行对appState的修改
 */
function dispatch(action) {
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

renderApp(appState);
/**
 * 任何的模块想要修改appState里边的内容，必须大张旗鼓地调用dispatch
 */
dispatch({ type: 'UPDATE_TITLE_TEXT', text: '我是被修改的标题' });
dispatch({ type: 'UPDATE_TITLE_COLOR', color: 'green' });
renderApp(appState);
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

const users = [
  { username: 'Jerry', age: 21, gender: 'male' },
  { username: 'Tomy', age: 22, gender: 'male' },
  { username: 'Lily', age: 19, gender: 'female' },
  { username: 'Lucy', age: 20, gender: 'female' }
]

/**
 * 如果你往 {} 放一个数组，React.js 会帮你把数组里面一个个元素罗列并且渲染出来
 */
class Index extends Component {
  render() {
    const usersElements = [];
    for(let user of users) {
      usersElements.push(
        <div>
          <div>姓名：{user.username}</div>
          <div>年龄：{user.age}</div>
          <div>性别：{user.gender}</div>
          <hr/>
        </div>
      );
    }
    return (
      <div>
        {usersElements}
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

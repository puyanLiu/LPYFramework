import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

/**
 * PropTypes
 * 给组件的配置参数加上类型验证
 */
class Comment extends Component {

  /**
   *  PropTypes.array
      PropTypes.bool
      PropTypes.func
      PropTypes.number
      PropTypes.object
      PropTypes.string
      PropTypes.node
      PropTypes.element
   */
  static propTypes = {
    comment: PropTypes.object.isRequired
  }
  
  render() {
    const { comment } = this.props;
    return (
      <div className='comment'>
          <div className='comment-user'>
              <span>{comment.username} </span>：
          </div>
          <p>{comment.content}</p>
      </div>
    );
  }

}

ReactDOM.render(
  <Comment comment={{'username': '123', 'content': '哈哈'}} />,
  document.getElementById('root')
);

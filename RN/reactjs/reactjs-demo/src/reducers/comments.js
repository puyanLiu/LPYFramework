
/**
 * reducer文件书写习惯
 * 
 * 定义action types
 * 编写reducer
 * 跟这个reducer相关的action creators
 */

/**
 * 评论功能的组件之间共享的状态只有comments
 * 
 * 新增
 * 删除
 * 初始化数据
 */

// 初始化数据
const COMMENTS_INIT = 'COMMENTS_INIT';
// 添加数据
const COMMENTS_ADD = 'COMMENTS_ADD';
// 删除数据
const COMMENTS_DELETE = 'COMMENTS_DELETE';

// reducer
export default function(state, action) {
  if(!state) {
    state = {
      comments: []
    };
  }
  switch(action.type) {
    case COMMENTS_INIT:
      return {
        ...state, // 复制state里面的内容
        comments: action.comments
      };
    case COMMENTS_ADD:
      return {
        ...state, // 复制state里面的内容
        comments: [...state.comments, action.comment]
      };
    case COMMENTS_DELETE:
      return {
        ...state, // 复制state里面的内容
        comments: [
            ...state.comments.slice(0, action.commentIndex),
            ...state.comments.slice(action.commentIndex + 1)
        ]
      };
    default:
      return state; // 没有修改，返回原来的对象
  }
}

/**
 * action creators 
 * 把dispatch需要传递的对方封装到函数中，帮助我们构建action
 * 帮助我们对传入的数据做统一的处理
 * 
 * 返回action函数
 */

export const initComments = (comments) => {
    return {
        type: COMMENTS_INIT,
        comments
    };
};

export const addComment = (comment) => {
    return {
        type: COMMENTS_ADD,
        comment
    };
};

export const deleteComment = (commentIndex) => {
    return {
        type: COMMENTS_DELETE,
        commentIndex
    };
};
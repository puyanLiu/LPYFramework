import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Comment extends Component {

    render() {
        const {comment} = this.props;
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

export default Comment;
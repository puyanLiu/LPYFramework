import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import CommentInput from './CommentInput.js';
import CommentList from './CommentList.js';
import './index.css';

class CommentApp extends Component {
    constructor() {
        super();
        this.state = {
            comments: []
        };
    }

    _handleSubmitComment(comment) {
        if(!comment) 
            return;
        if(!comment.username) 
            return alert('请输入用户名');
        if(!comment.content)
            return alert('请输入评论内容');
        this.state.comments.push(comment);
        this.setState({
            comments: this.state.comments
        });
    }

    render() {
        return (
            <div className='wrapper'>
                <CommentInput onSubmit={this._handleSubmitComment.bind(this)} />
                <CommentList comments={this.state.comments} />
            </div>
        );
    }
}

export default CommentApp;
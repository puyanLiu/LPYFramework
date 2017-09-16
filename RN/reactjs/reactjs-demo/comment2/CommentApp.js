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

    componentWillMount() {
        this._loadComments();
    }

    /**
     * 获取评论列表内容
     */
    _loadComments() {
        const comments = localStorage.getItem('comments');
        if(comments) {
            this.setState({
                comments: JSON.parse(comments)
            });
        }
    }

    /**
     * 持久化评论列表
     */
    _saveComments(comments) {
        localStorage.setItem('comments', JSON.stringify(comments));
    }

    _handleSubmitComment(comment) {
        if(!comment) 
            return;
        if(!comment.username) 
            return alert('请输入用户名');
        if(!comment.content)
            return alert('请输入评论内容');
        const comments = this.state.comments;
        comments.push(comment);
        this.setState({
            comments
        });
        this._saveComments(comments);
    }

    _handleDeleteComment(index) {
         const comments = this.state.comments;
         comments.splice(index, 1);
         this.setState({
             comments
         });
         this._saveComments(comments);
    }

    render() {
        return (
            <div className='wrapper'>
                <CommentInput onSubmit={this._handleSubmitComment.bind(this)} />
                <CommentList comments={this.state.comments} 
                  onDeleteComment={this._handleDeleteComment.bind(this)} />
            </div>
        );
    }
}

export default CommentApp;
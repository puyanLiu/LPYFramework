import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import CommentInput from './CommentInput.js';
import CommentList from './CommentList.js';
import './index.css';
import commentWrapWithLoadData from './commentWrapWithLoadData.js';

class CommentApp extends Component {

    static propTypes = {
        data: PropTypes.any,
        saveData: PropTypes.func.isRequired
    }

    constructor(props) {
        console.log(props);
        super(props);
        this.state = {
            comments: props.data
        };
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
        this.props.saveData(comments);
    }

    _handleDeleteComment(index) {
         const comments = this.state.comments;
         comments.splice(index, 1);
         this.setState({
             comments
         });
         this.props.saveData(comments);
    }

    render() {
        return (
            <div className='wrapper'>
                <CommentInput onSubmit={this._handleSubmitComment.bind(this)} />
                <CommentList comments={this.props.data} 
                  onDeleteComment={this._handleDeleteComment.bind(this)} />
            </div>
        );
    }
}

CommentApp = commentWrapWithLoadData(CommentApp, 'comments');
export default CommentApp;
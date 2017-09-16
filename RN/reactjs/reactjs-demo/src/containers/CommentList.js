import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { initComments, deleteComment } from '../reducers/comments.js';
import CommentList from '../components/CommentList.js';

/**
 * CommentListContainer
 * 一个Smart组件，负责评论列表数据的加载、初始化、删除评论
 * 沟通CommentList和state
 */
class CommentListContainer extends Component {
    static PropTypes = {
        comments: PropTypes.array,
        onDeleteComment: PropTypes.func,
        initComments: PropTypes.func
    };

    componentWillMount() {
        this._loadComments();
    }

    _loadComments() {
        let comments = localStorage.getItem('comments');
        comments = comments ? JSON.parse(comments) : [];
        if(this.props.initComments) {
            this.props.initComments(comments);
        }
    }

    _handleDeleteComment(index) {
        const comments = this.props.comments;
        const newComments = [
            ...comments.slice(0, index),
            ...comments.slice(index + 1)
        ];
        localStorage.setItem('comments', JSON.stringify(newComments));
         if(this.props.onDeleteComment) {
            this.props.onDeleteComment(index);
        }
    }

    render() {
        return (
            <CommentList comments={this.props.comments} 
                  onDeleteComment={this._handleDeleteComment.bind(this)} />
        );
    }
}

const mapStateToProps = (state) => {
    return {
        comments: state.comments
    };
};

const mapDispatchToProps = (dispatch) => {
    return {
        initComments: (comments) => {
            dispatch(initComments(comments));
        },
        onDeleteComment: (commentIndex) => {
            dispatch(deleteComment(commentIndex));
        }
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(CommentListContainer);
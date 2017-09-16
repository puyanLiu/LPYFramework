import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { addComment } from '../reducers/comments.js';
import CommentInput from '../components/CommentInput.js';

class CommentInputContainer extends Component {

    static propTypes = {
        comments: PropTypes.array,
        onSubmit: PropTypes.func
    };

    constructor() {
        super();
        this.state = {
            username: ''
        };
    }

    componentWillMount() {
        // 从LocalStorage中加载用户名
        this._loadUsername();
    }

    _loadUsername() {
        const username = localStorage.getItem('username');
        if(username) {
            this.setState({
                username
            });
        }
    }

    _saveUsername(username) {
        localStorage.setItem('username', username);
    }

    _handleSubmitComment(comment) {
        if(!comment) {
            return;
        } else if(!comment.username) {
            return alert('请输入用户名');
        } else if(!comment.content) {
            return alert('请输入评论内容');
        }

        const { comments } = this.props;
        const newComments = [...comments, comment];
        localStorage.setItem('comments', JSON.stringify(newComments));

        if(this.props.onSubmit) {
            this.props.onSubmit(comment);
        }
    }

    render() {
        return (
            <CommentInput 
             username={this.state.username} 
             onSubmit={this._handleSubmitComment.bind(this)} 
             onUsernameInputBlur={this._saveUsername.bind(this)} />
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
        onSubmit: (comment) => {
            dispatch(addComment(comment));
        }
    };
};

export default connect(mapStateToProps, mapDispatchToProps)(CommentInputContainer);
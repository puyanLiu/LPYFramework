import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import Comment from './Comment.js';

class CommentList extends Component {

    static PropTypes = {
        onDeleteComment: PropTypes.func,
        comments: PropTypes.array
    };

    static defaultProps = {
        comments: [],
    };

    _handleDeleteComment(index) {
         if(this.props.onDeleteComment) {
            this.props.onDeleteComment(index);
        }
    }

    render() {
        return (
            <div>
                {
                    this.props.comments.map((comment, i) => 
                    <Comment key={i} comment={comment} index={i}
                     onDeleteComment={this._handleDeleteComment.bind(this)} />)
                }
            </div>
        );
    }
}

export default CommentList;
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import Comment from './Comment.js';

class CommentList extends Component {

    static defaultProps = {
        comments: []
    };

    render() {
        return (
            <div>
                {
                    this.props.comments.map((comment, i) => (<Comment key={i} comment={comment} />))
                }
            </div>
        );
    }
}

export default CommentList;
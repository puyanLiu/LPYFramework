import React, { Component, PropTypes } from 'react';
import CommentInput from './CommentInput.js';
import CommentList from './CommentList.js';
import '../index.css';

class CommentApp extends Component {
    render() {
        return (
            <div className='wrapper'>
                <CommentInput />
                <CommentList />
            </div>
        );
    }
}

export default CommentApp;
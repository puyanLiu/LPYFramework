import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class CommentInput extends Component {

    constructor() {
        super();
        this.state = {
            username: '',
            content: ''
        };
    }

    _handleUsernameChange(e) {
        this.setState({
            username: e.target.value
        });
    }

    _handleContentChange(e) {
        this.setState({
            content: e.target.value
        });
    }

    _handleSubmit() {
        if(this.props.onSubmit) {
            const { username, content } = this.state;
            this.props.onSubmit({username, content});
        }
        this.setState({
            content: ''
        });
    }

    render() {
        return (
            <div className='comment-input'>
                <div className='comment-field'>
                    <span className='comment-field-name'>用户名：</span>
                    <div className='comment-field-input'>
                        <input type="text" value={this.state.username} 
                        onChange={this._handleUsernameChange.bind(this)} />
                    </div>
                </div>
                <div className='comment-field'>
                    <span className='comment-field-name'>评论内容：</span>
                    <div className='comment-field-input'>
                        <textarea value={this.state.content}
                        onChange={this._handleContentChange.bind(this)} />
                    </div>
                </div>
                <div className='comment-field-button'>
                    <button onClick={this._handleSubmit.bind(this)}>发布</button>
                </div>
            </div>
        );
    }
}

export default CommentInput;
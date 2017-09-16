import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Comment extends Component {

    static PropTypes = {
        comment: PropTypes.object.isRequired,
        onDeleteComment: PropTypes.func,
        index: PropTypes.number
    };

    constructor() {
        super();
        this.state = {
            timeString: ''
        };
    }

    /**
     * 组件挂载阶段调用
     */
    componentWillMount() {
        this._updateTimeString();
        this.timer = setInterval(
            this._updateTimeString.bind(this), 5000);
    }

    componentWillUnmount() {
        clearInterval(this.timer);
    }

    _updateTimeString() {
        const comment = this.props.comment;
        if(!comment.createdTime)
            return;
        const duration = (+Date.now() - comment.createdTime) / 1000;
        this.setState({
            timeString: duration > 60 ? 
            `${Math.round(duration / 60)} 分钟前` : 
            `${Math.round(Math.max(duration, 1))} 秒前`
        });
    }

    _handleDeleteComment() {
        if(this.props.onDeleteComment) {
            this.props.onDeleteComment(this.props.index);
        }
    }

    _getProcessedContent(content) {
        // 会导致严重的XSS漏洞
        // return content.replace(/`([\S\s]+?)`/, '<code>$1</code>');
        return content
                .replace(/&/g, "$amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;")
                .replace(/`([\S\s]+?)`/, '<code>$1</code>');
    }

    render() {
        const {comment} = this.props;
        return (
            <div className='comment'>
                <div className='comment-user'>
                    <span>{comment.username} </span>：
                </div>
                <p dangerouslySetInnerHTML={{__html: this._getProcessedContent(comment.content)}}></p>
                <span className='comment-createdtime'>
                    {this.state.timeString}
                </span>
                <span className='comment-delete' 
                    onClick={this._handleDeleteComment.bind(this)}>
                    删除
                </span>
            </div>
        );
    }
}

export default Comment;
import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';

/**
 * 所有的私有方法都用_开头
 * 所有的事件监听方法都用handle开头
 * 把事件监听方法传给组件的时候，属性名用on开头
 * 
 * 监听(on)组件的(on后边内容)事件，并且交给this去处理(handle)
 * 
 * 组件的内容编写顺序
 * 1、static开头的类属性，如defaultProps、propTypes
 * 2、构造函数 constructor
 * 3、getter/setter
 * 4、组件声明周期
 * 5、_开头的私有方法
 * 6、事件监听方法 handle*
 * 7、render*开头的方法，有时候 render() 方法里面的内容会分开到不同函数里面进行，这些函数都以 render* 开头
 * 8、render()方法
 */
class CommentInput extends Component {

    /**
     * 组件参数验证
     */
    static propTypes = {
        onSubmit: PropTypes.func,
        username: PropTypes.any,
        onUsernameInputBlur: PropTypes.func
    };

    static defaultProps = {
        username: ''
    };

    constructor(props) {
        super(props);
        this.state = {
            username: props.username,
            content: ''
        };
    }

    componentDidMount() {
        this.textarea.focus();
    }

    /**
     * 输入框失去焦点
     */
    _handleUsernameBlur(e) {
        if(this.props.onUsernameInputBlur) {
            this.props.onUsernameInputBlur(e.target.value);
        }
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
            // console.log(new Date(), +new Date(), new Date().getTime());
            const { username, content } = this.state;
            this.props.onSubmit({
                username, 
                content,
                createdTime: +new Date()
            });
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
                        onChange={this._handleUsernameChange.bind(this)}
                        onBlur={this._handleUsernameBlur.bind(this)} />
                    </div>
                </div>
                <div className='comment-field'>
                    <span className='comment-field-name'>评论内容：</span>
                    <div className='comment-field-input'>
                        <textarea ref={(textarea) => this.textarea = textarea} value={this.state.content}
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
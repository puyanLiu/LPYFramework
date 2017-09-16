import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';


class LikeButton extends Component {

  static defaultProps = {
    likedText: '取消',
    unlikedText: '点赞'
  };

  constructor() {
    super();
    this.state = {
      isLiked: false,
      name: 'Tomy'
    };
  }

  _handleClickOnLikeButton() {
    this.setState({
      isLiked: !this.state.isLiked
    });
    if(this.props.onClick) {
      this.props.onClick();
    }
  }

  render() {
    const likedText = this.props.likedText || '取消';
    const unlikedText = this.props.unlikedText || '点赞';
    const wordings = this.props.wordings || {
      likedText: '取消',
      unlikedText: '点赞',
    };
    return (
      <button onClick={this._handleClickOnLikeButton.bind(this)}>
        {this.state.isLiked ? likedText : unlikedText} 👍
        {this.state.isLiked ? wordings.likedText : wordings.unlikedText} 👍
        {this.state.isLiked ? this.props.likedText : this.props.unlikedText} 👍
      </button>
    );
  }
}

class Index extends Component {
  render() {
    return (
      <div>
        <LikeButton likedText="已赞" unlikedText="攒" onClick={() => console.log('click on like button')} />
        <LikeButton wordings={{likedText: '已赞', unlikedText: '攒'}}/>
      </div>
    );
  }
}

ReactDOM.render(
  <Index />,
  document.getElementById('root')
);

import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

class Header extends Component {

  _renderGoodWord(goodWord, badWord) {
    const isGoodWorld = true;
    return isGoodWorld ? goodWord : badWord;
  }

  render () {
    const world = 'is good';
    const className = 'header';
    const isGoodWorld = false;
    const goodWord =  <strong>is Good</strong>;
    const badWord =  <span>is not good</span>;
    return (
      <div className={className}>
        <h1 class='title'>
          哈哈 
          {world} 
          { 1 + 2 } 
          { (function() { return '返回'; })() } 
          { isGoodWorld ? <strong>is Good</strong> : <span>is not good</span> }
          { isGoodWorld ? <strong>is Good</strong> : null }
          { isGoodWorld ? goodWord : badWord }
          { this._renderGoodWord(goodWord, badWord) }
        </h1>
      </div>
    );
  }
}

ReactDOM.render(
  <Header />,
  document.getElementById('root')
);

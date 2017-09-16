import React, { Component, PropTypes } from 'react';

class HeaderTop extends Component {

  /**
   * 可以通过这个方法控制组件是否重新渲染，如果返回false组件就不会重新渲染，一般用在性能优化上
   * @param {*} nextProps 
   * @param {*} nextState 
   */
  shouldComponentUpdate(nextProps, nextState) {
      return false;
  }

  render() {
    console.log('render headerTop');
    return (
      <div>
          哈哈我是HeaderTop
      </div>
    );
  }
}
export default HeaderTop;

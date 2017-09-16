import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import './index.css';

/**
 * 高阶组件 (Highter-Order Components)
 * 高阶组件就是一个函数，传给它一个组件，它返回一个新的组件。
 * 这个新的组件会使用你传给它的组件作为子组件
 * 
 * 为了组件之间的代码复用
 * 组件可能有着某些相同的逻辑，把这些逻辑抽离出来，放到高阶组件中进行复用
 * 高阶组件内部的包装组件和被包装组件之间通过props传递数据 
 */

export default (WrappedComponent, name) => {
  class NewComponent extends Component {

    constructor() {
      super();
      this.state = {
        data: null
      };
    }

    /**
     * NewComponent会根据第二个参数name在挂载阶段从localStorage加载数据
     */
    componentWillMount() {
      ajax.get('/data/' + this.props.data, (data) => {
          this.setState({
              data
          })
      });
    }

    render() {
      return <WrappedComponent data={this.state.data} />;
    }
  }

  return NewComponent;
}

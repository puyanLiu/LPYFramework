import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import wrapWithLoadData from './wrapWithLoadData.js';
import wrapWithAjaxData from './wrapWithAjaxData.js';

class InputWithUserName extends Component {
    render() {
        return <input value={this.props.data} />
    }
}

// 先从localStorage中加载数据，再用这个数据去服务器取数据
// InputWithUserName = wrapWithAjaxData(InputWithUserName);
InputWithUserName = wrapWithLoadData(InputWithUserName, 'username');
export default InputWithUserName;
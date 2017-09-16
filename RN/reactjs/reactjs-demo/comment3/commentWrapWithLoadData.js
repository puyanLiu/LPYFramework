import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';

export default (WrappedComponent, name) => {
    class LocalStorageActions extends Component {
        constructor() {
            super();
            this.state = {
                data: null
            }
        }

        componentWillMount() {
            this._loadData();
        }

        /**
         * 从localStorage加载数据
         */
        _loadData() {
            const data = localStorage.getItem(name);
            if(data) {
                try {
                   // 解析成JSON对象
                   this.setState({
                        data: JSON.parse(data)
                    }); 
                } catch (localStorage) {
                    // 解析错了，就普通字符串
                    this.setState({
                        data: data
                    }); 
                }
            }
        }

        /**
         * 持久化数据
         */
        _saveData(data) {
            if(data) {
                try {
                    localStorage.setItem(name, JSON.stringify(data));
                } catch (localStorage) {
                    localStorage.setItem(name, `${data}`); 
                }
            }
        }

        /**
         * {...this.props}  其他的参数原封不动地传递给被包装的组件
         */
        render() {
            return (
                <WrappedComponent data={this.state.data}
                saveData={this._saveData.bind(this)}
                {...this.props} />
            );
        }

    }

    return LocalStorageActions;
}
import React, { Component, PropTypes } from 'react';

/**
 * 复用性强的组件
 * 组件的渲染只依赖于外界传进去的props和自己的state,而并不依然与其他的外界的任何数据，像纯函数一样
 * 使用的时候只看PropTypes它能接受什么参数，然后把参数传进去控制它就行了
 * 
 * Pure Component/Dumb Component
 * 写组件的时候尽量写Dumb Component会提高我们的组件的可复用性
 * 
 * 我们需要高阶组件帮助我们从context取数据，需要Dumb组件帮助我们提高组件的复用性
 * 写Dumb组件人，然后用高阶组件把它们包装一层，高阶组件和context打交道，把里面数据取出来通过props传给Dumb组件
 * 
 * 把这个高阶组件起名为connect, 因为它把Dumb组件和context连接起来
 * 
 * connect现在是接受一个参数mapStateToProps，然后返回一个函数，这个返回的函数才是高阶组件
 * 它会接受一个组件作为参数，然后用Connect把组件包装以后再返回
 */
export const connect = (mapStateToProps, mapDispatchToProps) => (WrappedComponent) => {
    class Connect extends Component {

        static contextTypes = {
            store: PropTypes.object
        }

        /**
         * 给connect的高阶组件增加监听数据变化重新渲染的逻辑
         */
        constructor() {
            super();
            this.state = {
                // allProps 用来保存需要传给被包装组件的所有的参数
                allProps: {}
            };
        }

        componentWillMount() {
            // 从context取出store，把store里面的数据取出来通过props传给WrappedComponent
            const { store } = this.context;
            // 监听数据变化
            store.subscribe(() => {
                this._updateProps();
            });
            this._updateProps();
        }

        _updateProps() {
            // 从context取出store，把store里面的数据取出来通过props传给WrappedComponent
            const { store } = this.context;
            /**
                const mapStateToProps = (state) => {
                    return {
                        themeColor: state.themeColor,
                        themeName: state.themeName,
                        fullName: `${state.firstName} ${state.lastName}`
                        ...
                    }
                }

                这个函数会接受store.getState()的结果作为参数，然后返回一个对象，这个对象是根据state生成的
                mapStateToProps相当于告知了Connect应该如何取store里面的数据，然后可以把这个函数的返回结果传给被包装的组件
             */
            // let stateProps = mapStateToProps(getState, this.props); // 额外传入props，让获取数据更加灵活方便
            let stateProps = mapStateToProps ? mapStateToProps(store.getState(), this.props) : {}; // 防止maspStateProps没有传入
            let dispatchProps = mapDispatchToProps ? mapDispatchToProps(store.dispatch, this.props) : {};
            this.setState({
                allProps: { // 整合普通的props和从state生成的props
                    ...stateProps,
                    ...dispatchProps,
                    ...this.props
                }
            });
        }

        render() {
            // {...stateProps} 把这个对象里面的属性全部通过props方式传递进去
            return (<WrappedComponent {...this.state.allProps} />);
        }
    }

    return Connect;
};

/**
 * Provider 容器组件
 * 把嵌套的内容原封不动作为自己的子组件渲染出来
 * 把外界传给它的props.store放到context
 */
export class Provider extends Component {
    
    static propTypes = {
        store: PropTypes.object,
        children: PropTypes.any
    };

    static childContextTypes = {
        store: PropTypes.object
    };

    getChildContext() {
        return { store: this.props.store };
    }

    render() {
        return (
            <div>
                {this.props.children}
            </div>
        );
    }
}


/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
    TextInput,
    TouchableOpacity,
} from 'react-native';


class ImageDemo extends Component {

    // static defaultProps = {name: "张三"};

    constructor(props) {
        super(props);

        // 初始化状态
        this.state = {age: 18};
    }

    render() {
        return (
            <View ref="topView" style={styles.container}>
                <Text>姓名:{this.props.name}</Text>
                <Text>年龄:{this.state.age}</Text>

                <TouchableOpacity onPress={() => this.doSomeThing()}>
                    <Text>点我+1</Text>
                </TouchableOpacity>
            </View>
        );
    }

    doSomeThing() {
        this.setState({
            age: this.state.age + 1,
        });

        console.log(this.refs.topView);
    }

}

// 设置默认属性
ImageDemo.defaultProps = {name: "李四"};
// 设置属性类型
ImageDemo.propTypes = {
    name: React.PropTypes.string,
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    },
});

AppRegistry.registerComponent('ImageDemo', () => ImageDemo);

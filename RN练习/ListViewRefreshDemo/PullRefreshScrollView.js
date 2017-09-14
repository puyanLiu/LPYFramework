'use strict';

import React, { Component } from 'react';
import {
    View,
    Text,
    Image,
    StyleSheet,
    AsyncStorage,
    Animated,
    Easing,
    ScrollView,
    ActivityIndicator
} from 'react-native';

var height = 70;

import ScrollableMixin from './ScrollableMixin';

import pullToRefreshImage from './images/bg_pulltorefresh.png';
import loadingImage from './images/ic_loading.png';

export default class PullRefreshScrollView extends Component {
    constructor(props) {
        super(props);

         // = this.scrollView;
        this.refreshedText = props.refreshedText;
        this.refreshingText = props.refreshingText;
        this.refreshText = props.refreshText;
        this.state = {
            prTitle:this.refreshText,
            prState:0,
            prLoading:false,
            prArrowDeg:new Animated.Value(0),
            circleLoadingValue: new Animated.Value(0)
        };


        this.base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAABQBAMAAAD8TNiNAAAAJ1BMVEUAAACqqqplZWVnZ2doaGhqampoaGhpaWlnZ2dmZmZlZWVmZmZnZ2duD78kAAAADHRSTlMAA6CYqZOlnI+Kg/B86E+1AAAAhklEQVQ4y+2LvQ3CQAxGLSHEBSg8AAX0jECTnhFosgcjZKr8StE3VHz5EkeRMkF0rzk/P58k9rgOW78j+TE99OoeKpEbCvcPVDJ0OvsJ9bQs6Jxs26h5HCrlr9w8vi8zHphfmI0fcvO/ZXJG8wDzcvDFO2Y/AJj9ADE7gXmlxFMIyVpJ7DECzC9J2EC2ECAAAAAASUVORK5CYII=';
        this.dragFlag = false; //scrollview是否处于拖动状态的标志
    }

    onScroll(e){
      var y = e.nativeEvent.contentOffset.y;
      if (this.dragFlag) {
        if (y <= -height) {
          this.setState({
            prTitle:this.refreshedText,
            prState:1
          });

          Animated.timing(this.state.prArrowDeg, {
                toValue: 1,
                duration: 100,
                easing: Easing.inOut(Easing.quad)
            }).start();

        } else {

          this.setState({
            prTitle:this.refreshText,
            prState:0
          });
          Animated.timing(this.state.prArrowDeg, {
                toValue: 0,
                duration: 100,
                easing: Easing.inOut(Easing.quad)
            }).start();
        }
      }

      if (this.props.onScroll) {
        this.props.onScroll(e);
      }
    }

    // 手指离开
    onScrollEndDrag(){

      this.dragFlag = false;
      if (this.state.prState) {

        // 回到待收起状态
        this.scrollView.scrollTo({x:0,y:-height,animated:true});

        this.setState({
          prTitle:this.refreshingText,
          prLoading:true,
          prArrowDeg:new Animated.Value(0),

        });

        this.startCircleAnimation();

        // 触发外部的下拉刷新方法
        if (this.props.onRefresh) {
          this.props.onRefresh(this);
        }
      }

    }
    // 手指未离开
    onScrollBeginDrag(){

      this.dragFlag = true;

      if (this.props.onScrollBeginDrag) {
        this.props.onScrollBeginDrag();
      }
    }

    startCircleAnimation() {
      this.state.circleLoadingValue.setValue(0);
      Animated.timing(this.state.circleLoadingValue, {
        toValue: 1,
        duration: 1000,
        easing: Easing.linear
      }).start(() => {
        if (this.state.prLoading) {
          this.startCircleAnimation()
        }
      });
    }

    onRefreshEnd(){
      this.setState({
        prTitle:this.refreshText,
        prLoading:false,
      });
      this.scrollView.scrollTo({x:0,y:0,animated:true});
    }
    renderNormalContent(){
      this.transform = [{rotate:this.state.prArrowDeg.interpolate({
                        inputRange: [0,1],
                        outputRange: ['0deg', '-180deg']
                    })}];
      let jsxarr = [];

        let arrowStyle = {
            width:14,
            height:23,
            transform:this.transform
        };
        let indicatorStyle = {
            width:20,
            height:20
        };
        let diamondStyle = {
          position: 'absolute',
          top: 6,
          left: 6,
          borderColor: 'yellow',
          borderWidth: 1,
          height: 8,
          width: 8,
        };

        if (this.props.indicatorImg.url) {
          if (this.props.indicatorImg.style) {
            indicatorStyle = this.props.indicatorImg.style;
          }
          if (this.state.prLoading) {
            jsxarr.push(<Image style={indicatorStyle} source={{uri:this.props.indicatorImg.url}}/>);
          } else {
            jsxarr.push(null);
          }
        } else {
          if (this.state.prLoading) {
            jsxarr.push(<Animated.View style={indicatorStyle}>
              <Animated.Image source={loadingImage} style={[{transform: [{
                  rotate: this.state.circleLoadingValue.interpolate({
                    inputRange: [0, 1],
                    outputRange: ['0deg', '360deg']
                  })
                }]}]}></Animated.Image>
              <Animated.View style={[diamondStyle, {transform: [{rotate: '45deg'}]}]}></Animated.View>
            </Animated.View>);
          } else {
            jsxarr.push(null);
          }
        }

        if (this.props.indicatorArrowImg.url) {
          if (this.props.indicatorArrowImg.style) {
            arrowStyle = this.props.arrowStyle.style;
          }
          arrowStyle.transform = this.transform;
          if (!this.state.prLoading) {
            jsxarr.push(<Animated.Image style={arrowStyle} resizeMode={'contain'} source={{uri: this.props.indicatorArrowImg.url}}/>);
          } else {
            jsxarr.push(null);
          }
        } else {
          if (!this.state.prLoading) {
            jsxarr.push(<Animated.Image style={arrowStyle} resizeMode={'contain'} source={{uri: this.base64Icon}}/>);
          } else {
            jsxarr.push(null);
          }
        }
        jsxarr.push(<Text style={styles.prState}>{this.state.prTitle}</Text>)

        return (
          <View style={{alignItems:'center'}}>
            <Image source={pullToRefreshImage} style={styles.pullImageStyle} />
            <View style={styles.indicatorContent}>

                {jsxarr.map((item,index)=>{
                  return <View key={index}>{item}</View>
                })}

            </View>
          </View>
          );

    }
    rendeTextContent(){

      let prStateStyle = {
            marginBottom:20,
            fontSize:12,
          };
      return (<Text style={prStateStyle}>{this.state.prTitle}</Text>);
    }

    rendeImgContent(){
      this.transform = [{rotate:this.state.prArrowDeg.interpolate({
                        inputRange: [0,1],
                        outputRange: ['0deg', '-180deg']
                    })}];
      let jsxarr = [];
      let arrowStyle = {
          width:14,
          height:23,
          marginBottom:20,
          transform:this.transform
      };
      let indicatorStyle = {
          width:16,
          height:16,
          marginBottom:20,
      };
      if (this.props.indicatorImg.url) {
          if (this.props.indicatorImg.style) {
            indicatorStyle = this.props.indicatorImg.style;
          }
          if (this.state.prLoading) {
            jsxarr.push(<Image style={indicatorStyle} source={{uri:this.props.indicatorImg.url}}/>);
          } else {
            jsxarr.push(null);
          }
        } else {
          if (this.state.prLoading) {
            jsxarr.push(<ActivityIndicator style={indicatorStyle} animated={true}/>);
          } else {
            jsxarr.push(null);
          }
        }

        if (this.props.indicatorArrowImg.url) {
          if (this.props.indicatorArrowImg.style) {
            arrowStyle = this.props.arrowStyle.style;
          }
          arrowStyle.transform = this.transform;
          if (!this.state.prLoading) {
            jsxarr.push(<Animated.Image style={arrowStyle} resizeMode={'contain'} source={{uri: this.props.indicatorArrowImg.url}}/>);
          } else {
            jsxarr.push(null);
          }
        } else {
          if (!this.state.prLoading) {
            jsxarr.push(<Animated.Image style={arrowStyle} resizeMode={'contain'} source={{uri: this.base64Icon}}/>);
          } else {
            jsxarr.push(null);
          }
        }

      return jsxarr;
    }

    renderIndicatorContent(){
      let type = this.props.refreshType;
      let jsx;

      if (type == 'normal') {
        jsx = [this.renderNormalContent()];
      }
      if (type == 'text') {
        jsx = [this.rendeTextContent()];
      }

      if (type == 'image') {
        jsx = this.rendeImgContent();
      }

      return (
              <View style={styles.pullRefresh}>

                  {jsx.map((item,index)=>{
                    return <View key={index}>{item}</View>
                  })}
              </View>
              );
    }
    getScrollResponder() {
      return this.scrollView.getScrollResponder();
    }

    setNativeProps(props) {
      this.scrollView.setNativeProps(props);
    }
    render() {

        return React.cloneElement(<ScrollView
                  ref={(scrollView) => this.scrollView = scrollView}
                  {...this.props}
                  scrollEventThrottle={16}
                  onScrollEndDrag={()=>this.onScrollEndDrag()}
                  onScrollBeginDrag={()=>this.onScrollBeginDrag()}
                  onScroll={(e)=>this.onScroll(e)}>

                    {this.renderIndicatorContent()}
                    {this.props.children}
            </ScrollView>, {
            ref: component => {
            this.scrollView = component;
          },
        });

    }

}

const styles = StyleSheet.create({
    pullImageStyle: {
      marginBottom: 15,
    },
    pullRefresh:{
      position:'absolute',
      top:-(height - 1),
      left:0,
      right:0,
      height:height,
      backgroundColor:'#fafafa',
      alignItems:'center',
      justifyContent:'flex-end'
    },
    prState:{
      marginLeft: 10,
      fontSize:12,
      color: 'yellow',
    },
    indicatorContent:{
      flexDirection:'row',
      alignItems: 'center',
      marginBottom: 10
    },

});

PullRefreshScrollView.defaultProps = {
    refreshedText: '松开放立即刷新...',
    refreshingText: '正在刷新数据中...',
    refreshText:'下拉刷新数据...',
    indicatorArrowImg: {  // 下拉箭头图片和样式 default arrow.png
      style:'',
      url:''
    },
    indicatorImg: {
      style:'', // loading图片和样式 default
      url:''
    },
    refreshType:'normal',
    onRefresh:''
};
Object.assign(PullRefreshScrollView.prototype, ScrollableMixin);

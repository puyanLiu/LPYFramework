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
  ListView,

} from 'react-native';

import PullRefreshScrollView from './PullRefreshScrollView';
import loadingImage from './images/ic_loading.png';

class ListViewRefreshDemo extends Component {

  constructor(props) {
        super(props);
        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows(['有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊',, '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊', '有种你滑我啊']),

        }
    }

    onRefresh(PullRefresh){
        console.log('refresh------------', PullRefresh);


        setTimeout(function(){
            PullRefresh.onRefreshEnd();
        },2000);

    }

  render() {
    return (
        <View style={styles.container}>
            <View style={styles.header}>
            </View>

            <ListView
                dataSource={this.state.dataSource}
                renderSeparator={(sectionID, rowID) => <View key={`${sectionID}-${rowID}`} style={styles.separator} />}
                renderRow={(rowData) => <View style={styles.rowItem}><Text style={{fontSize:16}}>{rowData}</Text></View>}
                renderScrollComponent={(props) => <PullRefreshScrollView
                onRefresh={(PullRefresh)=>this.onRefresh(PullRefresh)} {...props} />}
            />


        </View>
        );
  }
}

const styles = StyleSheet.create({
  container: {
        flex: 1
    },
    header:{
        height:64,
        backgroundColor: 'transparent',
    },
    rowItem:{
        flex:1,
        height:50,
        alignItems:'center',
        justifyContent:'center'
    },
    separator: {
        height: 1,
        backgroundColor: '#CCCCCC',
    },
});

AppRegistry.registerComponent('ListViewRefreshDemo', () => ListViewRefreshDemo);

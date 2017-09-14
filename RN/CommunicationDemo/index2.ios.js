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
  TouchableOpacity,
  NativeModules,
  NativeAppEventEmitter
} from 'react-native';

var CalendarManager = NativeModules.CalendarManager;

class CalendarDemo extends Component {
  constructor(props) {
    super(props);
    this.state = {
      names: [],
      events: null,
      firstDayOfTheWeek: null,
      updateStatusBarAnimation: '',
    };
  }

  async updateEvents() {
    try {
      var events = await CalendarManager.findEventsResolver();
      console.log(events);
      this.setState({ events });
    } catch (e) {

    } finally {

    }
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={() => {
          CalendarManager.setUserInfo('小张', '广州市');
        }}>
          <Text style={styles.welcome}>
            setUserInfo
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          CalendarManager.setUserInfo2('小红', '深圳市', '13412341234');
        }}>
          <Text style={styles.welcome}>
            setUserInfo2
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          CalendarManager.setUserName('小红', '1992-10-11T10:11:59.100Z');
        }}>
          <Text style={styles.welcome}>
            setUserName
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          CalendarManager.setUserNameBirthdayAge('小红', '1992-10-11T10:11:59.100Z', 15);
        }}>
          <Text style={styles.welcome}>
            setUserNameBirthdayAge
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          var date = new Date();
          CalendarManager.dateConvert(date.getTime(), date.toISOString());
        }}>
          <Text style={styles.welcome}>
            dateConvert
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          var date = new Date();
          CalendarManager.setUser({
            name: '张三',
            birthday: date.toISOString()
          });
        }}>
          <Text style={styles.welcome}>
            setUser
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          var date = new Date();
          CalendarManager.jsGetNames((error, names) => {
            if (error) {
              console.log(error);
            } else {
              this.setState({
                names: names
              });
            }
          });
        }}>
          <Text style={styles.welcome}>
            jsGetNames: {this.state.names}
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          this.updateEvents();
        }}>
          <Text style={styles.welcome}>
            findEventsResolver
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          console.log(CalendarManager.firstDayofTheWeek);
          this.setState({
            firstDayOfTheWeek : CalendarManager.firstDayOfTheWeek
          });
        }}>
          <Text style={styles.welcome}>
            firstDayOfTheWeek: {this.state.firstDayOfTheWeek}
          </Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => {
          CalendarManager.updateStatusBarAnimation(CalendarManager.UIStatusBarAnimationFade, (error, message) => {
            if(error) {
              this.setState({
                updateStatusBarAnimation: '失败'
              });
            } else {
              this.setState({
                updateStatusBarAnimation: message
              });
            }
          })
        }}>
          <Text style={styles.welcome}>
            updateStatusBarAnimation: {this.state.updateStatusBarAnimation}
          </Text>
        </TouchableOpacity>




      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

AppRegistry.registerComponent('CalendarDemo', () => CalendarDemo);

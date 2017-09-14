import React, {
  Component
} from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  Platform,
} from 'react-native';

var Dimensions = require('Dimensions');
var screenWidth = Dimensions.get('window').width;

class CommonNavBar extends Component {

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity onPress={() => {
          alert('左边');
        }}>
          {this.renderLeftImg()}
        </TouchableOpacity>
        <View>
          <Text style={styles.navTitleStyle}>
            {this.props.title}
          </Text>
        </View>
        <TouchableOpacity onPress={() => {
          alert('右边');
        }}>
          {this.renderRightImg()}
        </TouchableOpacity>
      </View>
    );
  }

  renderLeftImg() {
    if (this.props.leftIconArray.length > 0) {
      var img = this.props.leftIconArray.map((value, index) =>
      <Image key={index} source={value} style={styles.leftIconStyle}/>);
      return (<View style={styles.iconArrayStyle}>{img}</View>);
    } else if (this.props.leftIcon) {
      return <Image source={this.props.leftIcon} style={styles.leftIconStyle}/>
    }
    return null;
  }
  renderRightImg() {
    if (this.props.rightIconArray.length > 0) {
      var img = this.props.rightIconArray.map((value, index) =>
      <Image key={index} source={value} style={styles.rightIconStyle}/>);
      return (<View style={styles.iconArrayStyle}>{img}</View>);
    } else if (this.props.rightIcon) {
      return <Image source={this.props.rightIcon} style={styles.rightIconStyle}/>
    }
    return null;
  }
}

const styles = StyleSheet.create({
  container: {
    height: Platform.OS === 'ios' ? 64 : 44,
    backgroundColor: 'rgba(255, 96, 0, 1.0)',
    borderBottomWidth: 0.5,
    borderBottomColor: '#f8f8f8',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingTop: Platform.OS === 'ios' ? 20 : 0,
  },
  navTitleStyle: {
    color: '#fff',
    fontSize: Platform.OS === 'ios' ? 18 : 14,
    fontWeight: 'bold'
  },
  leftIconStyle: {
    width: 22,
    height: 22,
    marginLeft: 8,
  },
  iconArrayStyle: {
    flexDirection: 'row'
  },
  rightIconStyle: {
    width: 22,
    height: 22,
    marginRight: 8,
  },
});

CommonNavBar.defaultProps = {
  leftIcon: '',
  title: '',
  rightIcon: '',
  leftIconArray: [],
  rightIconArray: [],
};

module.exports = CommonNavBar;

import React, {
  Component
} from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableOpacity,
  Switch,
  Platform
} from 'react-native';

class More extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isOn: false
    };
  }

  render() {
    return (
      <TouchableOpacity onPress={() => {
        alert('点击了');
      }}>
        <View style={styles.container}>
          <Text>
            {this.props.leftTitle}
          </Text>
          {this.renderRightView()}
        </View>
      </TouchableOpacity>
    );
  }

  renderRightView() {
    var component;
    if (this.props.isShowSwitch) {
      component = <Switch onValueChange={() => {
        this.setState({
          isOn: !this.state.isOn
        });
      }}
      value={this.state.isOn}
      >
      </Switch>;
    } else {
      component = <Image source={require('../../Image/icon_cell_rightarrow.png')}
      style={{width: 8, height: 13}}/>
    }
    return (
      <View style={styles.rightViewStyle}>
        {this.renderRightTitle()}
        {component}
      </View>
    );
  }

  renderRightTitle() {
    if (this.props.rightTitle) {
      return (
        <Text style={{marginRight: 3, color: 'gray'}}>
          {this.props.rightTitle}
        </Text>
      );
    }
    return null;
  }
}

More.defaultProps = {
  leftTitle: '',
  isShowSwitch: false,
  rightTitle: '',
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    height: Platform.OS === 'ios' ? 44 : 36,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'space-between',
    borderBottomWidth: 0.5,
    borderBottomColor: '#ddd',
    paddingLeft: 15,
    paddingRight: 15,
  },
  rightViewStyle: {
    flexDirection: 'row',
    alignItems: 'center',
  },
});

module.exports = More;

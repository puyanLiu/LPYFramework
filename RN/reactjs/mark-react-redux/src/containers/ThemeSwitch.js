import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import ThemeSwitch from '../components/ThemeSwitch.js';

const mapStateToProps = (state) => {
    return {
        themeColor: state.themeColor
    };
};
const mapDispatchToProps = (dispatch) => {
    return {
        onSwitchColor: (color) => {
            dispatch({ type: 'CHANGE_COLOR', themeColor: color });
        }
    };
};
export default connect(mapStateToProps, mapDispatchToProps)(ThemeSwitch);

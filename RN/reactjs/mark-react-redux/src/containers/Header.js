import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import Header from '../components/Header.js';

const mapStateToProps = (state) => {
    return {
        themeColor: state.themeColor,
        headerTitle: state.headerTitle
    };
};
const mapDispatchToProps = (dispatch) => {
    return {
        onChangeHeaderTitle: (headerTitle) => {
            dispatch({ type: 'CHANGE_HEADERTITLE', headerTitle: headerTitle });
        }
    };
};
export default connect(mapStateToProps, mapDispatchToProps)(Header);

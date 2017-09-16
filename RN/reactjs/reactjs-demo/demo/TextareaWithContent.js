import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import wrapWithLoadData from './wrapWithLoadData.js';

class TextareaWithContent extends Component {
    render() {
        return <textarea value={this.props.data} />
    }
}

TextareaWithContent = wrapWithLoadData(TextareaWithContent, 'content');
export default TextareaWithContent;
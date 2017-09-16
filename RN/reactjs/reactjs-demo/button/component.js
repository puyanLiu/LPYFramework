
class Component {

    constructor(props = {}) {
        this.props = props;
    }

    setState(state) {
        const oldEl = this.el;
        this.state = state;
        this.el = this._renderDOM();
        if(this.onStateChange) {
            this.onStateChange(oldEl, this.el);
        }
    }

    _renderDOM() {
        this.el = createDOMFromString(this.render());
        if(this.onClick) {
            this.el.addEventListener('click', this.onClick.bind(this), false);
        } 
        return this.el;
    }
}
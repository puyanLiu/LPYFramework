
class RedBuleButton extends Component {

    constructor(props) {
        super(props);
        this.state = {
            color: 'red'
        }
    }

    onClick() {
        this.setState({
            color: 'blue'
        });
    }

    render() {
        return `
            <div style="color: ${this.state.color}">${this.state.color}</div>
        `;
    }
}


var React = require("react");
var CssHeader = require("./multi_components.js").with_css
var config = require("reaxt/config")

module.exports = class app extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      focused: 0
    };
  }

  getInitialState() {
    return { focused: 0 }
  }

  clicked(index) {
    this.setState({focused: index})
  }

  render() {
    var self = this
    return (
      <div>
        <CssHeader></CssHeader>
        <div>Example config : { config.example_config }</div>
        <ul>{ this.props.items.map(function(m, index){
          var style = ''
          if(self.state.focused == index) style = 'focused'
          return <li className={style} onClick={self.clicked.bind(self, index)}>{m}</li>
        }) }
        </ul>
        <p>Selected: {this.props.items[this.state.focused]}</p>
      </div>
    )
  }
}

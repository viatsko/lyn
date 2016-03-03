var React = require("react")
var CssHeader = require("./multi_components.js").with_css
var config = require("reaxt/config")
module.exports = React.createClass({displayName: 'app',
  getInitialState: function(){
    return { focused: 0 }
  },
  clicked: function(index){
    this.setState({focused: index})
  },
  render: function() {
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
})

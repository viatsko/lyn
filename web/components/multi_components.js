var React = require("react")

module.exports.no_stacktrace = React.createClass({
  render: function() {
    throw "an error just thrown without Error() wrapping"
  }
})

module.exports.with_stacktrace = React.createClass({
  render: function() {
    throw new Error("with stacktrace")
  }
})

module.exports.with_css = React.createClass({
  render: function() {
    // You can attach css dynamically to a component, server side rendering
    // will render it only if the component is rendered and client side
    // rendering will load it on demand
    require("./../css/index.css")
    return (
      <div className="header">Header of your Application !!</div>
    )
  }
})

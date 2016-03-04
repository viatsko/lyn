import React from 'react';

module.exports.no_stacktrace = class NoStacktrace extends React.Component {
  render() {
    throw "an error just thrown without Error() wrapping"
  }
}

module.exports.with_stacktrace = class WithStacktrace extends React.Component {
  render() {
    throw new Error("with stacktrace")
  }
}

module.exports.with_css = class WithCss extends React.Component {
  render() {
    // You can attach css dynamically to a component, server side rendering
    // will render it only if the component is rendered and client side
    // rendering will load it on demand
    require("./../css/index.css");

    return (
      <div className="header">Header of your Application !!</div>
    )
  }
}

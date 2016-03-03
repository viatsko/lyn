// dynamic component and props example, here an example with react router
var React = require('react')
var Router = require('react-router')
var { Route, NotFoundRoute, RouteHandler, Link } = Router

// Require the routed handlers of your application and generate the routing component
var App = require("./app")
var AppWithHeader = require("./multi_components").with_css
var NotFound = React.createClass({ render (){return <div>No React router route found !!</div>} })
var Root = React.createClass({
  render (){return (
    <div>
    <br/><Link to="/myrouter/routed-app">first Link History location routing</Link>
    <br/><Link to="/myrouter/routed-css-app">second Link history location routing</Link>
    <RouteHandler {...this.props}/>
    </div>
  )}
})
var routes = <Route handler={Root} path="/myrouter">
               <Route name="routed-app" handler={App}/>
               <Route name="routed-css-app" handler={AppWithHeader}/>
               <NotFoundRoute handler={NotFound}/>
             </Route>

var generate_props = function(router_state){
  // generate initial props for this router_state from ajax queries for instance
  // use a library which handles with the same interface for client window.XMLHttpRequest or server require('http') (like npm jquery)
  // else use directly XMLHttpRequest with npm "xmlhttprequest" package
  // var xhr = window && window.XMLHttpRequest || require('xmlhttprequest').XMLHttpRequest
  return {items: ["JSHome","JSContact","JSPage"]}
}

module.exports = {
  reaxt_server_render (path,render){
    Router.run(routes, path,function (Handler, state) {
      render(<Handler {...generate_props(state)}/>)
    })
  },
  reaxt_client_render (initial_props,render){
    var first = true
    Router.run(routes,Router.HistoryLocation,function(Handler,state){
      // first rendering use server side generated props, next one generate new props
      var props = first && initial_props || generate_props(state)
      render(<Handler {...props}/>)
      first = false
    })
  }
}

import React from 'react';
import {
  IndexRoute,
  Router,
  RouterContext,
  Route,
  match,
  browserHistory
} from 'react-router';
// import config from 'reaxt/config';

import App from './App/App';
import Home from './Home/Home';
import News from './News/News';
import About from './About/About';

const routes = (
  <Route path="/" component={App}>
    <IndexRoute component={Home} />
    <Route path="/news" component={News} />
    <Route path="/about" component={About} />
  </Route>
);

module.exports = {
  reaxt_server_render(initialProps, render) {
    match({ routes, location: initialProps.location }, (error, redirectLocation, renderProps) => {
      render(
        <RouterContext {...renderProps} />
      );
    });
  },
  reaxt_client_render(initialProps, render) {
    render(
      <Router history={browserHistory}>
        {routes}
      </Router>
    );
  }
};

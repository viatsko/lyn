import React from 'react';
import { IndexLink, Link } from 'react-router';

require('./App.scss');

export default class App extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-static-top navbar-dark bg-inverse">
          <div className="container">
            <div className="row">
              <a className="navbar-brand" href="#">Project name</a>
              <ul className="nav navbar-nav">
                <li className="nav-item">
                  <IndexLink className="nav-link" activeClassName="active" to={'/'}>
                    Home <span className="sr-only">(current)</span>
                  </IndexLink>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" activeClassName="active" to={'/news'}>News</Link>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" activeClassName="active" to={'/about'}>About</Link>
                </li>
              </ul>
            </div>
          </div>
        </nav>

        <div className="main-container container">
          <div className="row">
            {this.props.children}
          </div>
        </div>

        <footer>
          <div className="container">
            <div className="row">
              <hr />

              <p>&copy; Company 2015</p>
            </div>
          </div>
        </footer>
      </div>
    );
  }
}

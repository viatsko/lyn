import React from 'react';
import { IndexLink, Link } from 'react-router';

export default class App extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-static-top navbar-dark bg-inverse">
          <a className="navbar-brand" href="#">Project name</a>
          <ul className="nav navbar-nav">
            <li className="nav-item">
              <IndexLink className="nav-link" activeClassName="active" to={'/'}>
                Home <span className="sr-only">(current)</span>
              </IndexLink>
            </li>
            <li className="nav-item">
              <Link className="nav-link" activeClassName="active" to={'/about'}>About</Link>
            </li>
            <li className="nav-item">
              <Link className="nav-link" activeClassName="active" to={'/news'}>News</Link>
            </li>
          </ul>
        </nav>

        {this.props.children}

        <hr />
        <footer>
          <p>&copy; Company 2015</p>
        </footer>
      </div>
    );
  }
}

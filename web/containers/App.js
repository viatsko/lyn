import React from 'react';
import config from 'reaxt/config';

module.exports = class app extends React.Component {
  static propTypes = {
    items: React.PropTypes.array
  };

  constructor(props) {
    super(props);

    this.state = {
      focused: 0
    };

    this._clicked = (index) => this.clicked.bind(this, index);
  }

  clicked(index) {
    this.setState({ focused: index });
  }

  render() {
    const self = this;

    return (
      <div>
        <div>Example config : { config.example_config }</div>
        <ul>{this.props.items.map((m, index) => {
          let style = '';

          if (self.state.focused === index) {
            style = 'focused';
          }

          return <li key={index} className={style} onClick={this._clicked(index)}>{m}</li>;
        })}
        </ul>
        <p>Selected: {this.props.items[this.state.focused]}</p>
      </div>
    );
  }
};

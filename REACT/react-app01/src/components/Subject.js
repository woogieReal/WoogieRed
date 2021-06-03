import { Component } from 'react';

class Subject extends Component {
  shouldComponentUpdate(newProps){
    if(this.props.data === newProps.data) return false
    else return true;
  }
  render() {
    console.log('Subject render');
    return (
      <header>
        <h1><a href="/" onClick={function(e){
          e.preventDefault();
          this.props.onChangePage();
        }.bind(this)}>{this.props.title}</a></h1>
        <hr></hr>
        {this.props.sub}
      </header>
    );
  }
}

export default Subject;
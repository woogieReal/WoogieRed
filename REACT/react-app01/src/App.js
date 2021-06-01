import './App.css';
import { Component } from 'react';
import TOC from './components/TOC';
import Content from './components/Content';
import Subject from './components/Subject';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      mode: 'read',
      selected_content_id: 1,
      welcome: {title: 'Welcome', desc: 'Hello, React!'},
      subject: {title: 'WEB', sub: 'World Wide Web!!'},
      contents: [
        {id:1, title:'HTML', desc:'HTML is HyperText ...'},
        {id:2, title:'CSS', desc:'CSS is for design ...'},
        {id:3, title:'JAVASCRIPT', desc:'JAVASCRIPT is for interactive ...'}
      ]
    }
  }

  render() {
    let _title, _desc = null;
    if(this.state.mode === 'welcome'){
      _title = this.state.welcome.title;
      _desc = this.state.welcome.desc;
    } else if(this.state.mode === 'read'){
      const findContent = this.state.contents.find(content => {
        return content.id === this.state.selected_content_id;
      });
      _title = findContent.title;
      _desc = findContent.desc;
    }
    return (
      <div className="App">
        <Subject 
          title={this.state.subject.title} 
          sub={this.state.subject.sub}
          onChangePage={function(){
            this.setState({
              mode: 'welcome'
            });
          }.bind(this)}>
        </Subject>
        <TOC 
          onChangePage={function(id){
            this.setState({
              mode: 'read',
              selected_content_id:Number(id)
            });
          }.bind(this)} data={this.state.contents}>
        </TOC>
        <Content title={_title} desc={_desc}></Content>
      </div>
    );
  }
}

export default App;
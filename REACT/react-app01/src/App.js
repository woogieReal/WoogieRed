import './App.css';
import { Component } from 'react';
import TOC from './components/TOC';
import ReadContent from './components/ReadContent';
import Subject from './components/Subject';
import Control from './components/Control';
import CreateContent from './components/CreateContent';
import UpdateContent from './components/UpdateContent';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      mode: 'welcome',
      selected_content_id: 1,
      welcome: {title: 'Welcome', desc: 'Hello, React!'},
      subject: {title: 'WEB', sub: 'World Wide Web!!'},
      contents: [
        {id:1, title:'HTML', desc:'HTML is HyperText.'},
        {id:2, title:'CSS', desc:'CSS is for design.'},
        {id:3, title:'JAVASCRIPT', desc:'JAVASCRIPT is for interactive.'}
      ]
    }
  }

  getReadContent() {
    return this.state.contents.find(content => {
      return content.id === this.state.selected_content_id;
    });
  }

  getContent() {
    let _title, _desc, _article = null;
    if(this.state.mode === 'welcome'){
      _title = this.state.welcome.title;
      _desc = this.state.welcome.desc;
      _article = <ReadContent title={_title} desc={_desc}></ReadContent>
    } else if(this.state.mode === 'read'){
      const findContent = this.getReadContent();
      _title = findContent.title;
      _desc = findContent.desc;
      _article = <ReadContent title={_title} desc={_desc}></ReadContent>
    } else if(this.state.mode === 'create') {
      const nextId = this.state.contents[this.state.contents.length-1].id + 1;

      _article = <CreateContent onSubmit={function (_title, _desc){
        let _contents = Array.from(this.state.contents);
        _contents.push({id: nextId,title: _title, desc: _desc});

        this.setState({
          contents: _contents,
          mode: 'read',
          selected_content_id: nextId
        });
      }.bind(this)}></CreateContent>
    } else if(this.state.mode === 'update') {
      const findContent = this.getReadContent();
      _article = <UpdateContent data={findContent} onSubmit={function (_id, _title, _desc){
        let _contents = [];
        this.state.contents.forEach(content => {
          if(content.id === _id) content = {id: _id, title: _title, desc: _desc};
          _contents.push(content);
        });
        this.setState({
          contents: _contents,
          mode: 'read'
        });
        
      }.bind(this)}></UpdateContent>
    }
    return _article;
  }

  render() {
    console.log('App render');
    
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
        <Control onChangeMode={function (_mode) {
          if(_mode === 'delete'){
            if(!window.confirm('really?')) return;
            const _contents = this.state.contents.filter(content => {
              return content.id !== this.state.selected_content_id;
            });
            this.setState({contents: _contents, mode: 'welcome'});
          } else {
            this.setState({mode: _mode});
          }
        }.bind(this)}></Control>
        {this.getContent()}
      </div>
    );
  }
}

export default App;
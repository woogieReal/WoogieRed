## Install
---

### 다운로드
 * 도스 창에서 npm을 사용해서 설치
   * node.js가 설치 되어 있어야 한다
   * npm -v 를 통해 설치 되었는지 확인 할 수 있다.
``` command
npm install -g create-react-app
```
 * 설치가 완료되면 create-react-app -V(대문자)를 통해 확인 할 수 있다.
``` command
create-react-app -V
4.0.3
```

## Create react-app
---

### 리액트 앱 생성
 * 리액트 앱을 생성할 폴더명은 'react'는 사용불가
``` command
cd 경로
create-react-app  .
// . 은 현재 폴더에 생성한다는 의미
```

### 리액트 앱 실행/종료
 * VS Code 터미널에서 실행
``` command
//실행
npm run start

//종료
Ctrl + c
```

## Coding & Build & Deploy
---

### Coding

 * index.html
   * import <span style="color: red;">App</span> from './App'; 
   * <span style="color: red;">&lt;App /&gt;</span> 이름이 같아야 함
``` react
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App'; //App뒤에 js가 생략 되어 있다.
import reportWebVitals from './reportWebVitals';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
```

 * App.js  

``` react
//함수 타입
function App() {
  return (
    <div className="App">
	
	</div>
  );
}
```

``` react
//클래스 타입 
//생활코딩에서는 이쪽을 사용
class App extends Component {
  render () {
    return (
      <div className="App">
		이 안에 코드를 작성한다.
      </div>
    );
  }
}
```

### Deploy
 * build
``` react
npm run build
```
 * serve
``` react
//이 컴퓨터 어디에서나 serve라는 명령어를 통해서 웹서버를 설치 가능
npm install -g serve 
```

``` react
//한 번만 실행 시킬 웹서버를 다운로드 받아서 실행
npx serve -s build
```

## Component
---

### Component 생성
 * class 이름은 태그이름으로 사용된다.
 * react의 Component를 상속 받아야 한다.
 * 컴포넌트를 만들 때는 반드시 하나의 최상위 태그로 시작해야 한다.
``` react
class Subject extends Component {
  render() {
    return (
      <header>
        <h1>WEB</h1>
        <hr></hr>
        World Wide Web!
      </header>
    );
  }
}

class App extends Component {
  render () {
    return (
      <div className="App">
        <Subject></Subject>
      </div>
    );
  }
}
```

## props
---

### 특징
 * 컴포넌트를 재사용할 수 있도록 함
 * **`this.props.어트리뷰트_이름`**

### 코드 설명
 * App 컴포넌트는 Subject 컴포넌트를 사용한다.
 * Subject 컴포넌트의 데이터를 App 컴포넌트에서 주입한다.(객체지향개념)
 * App 컴포넌트에서 Subject 태그에서 어트리뷰트를 만들고 값을 주입한다.
 * Subject 컴포넌트에서 이 어트리뷰트를 통해 값을 주입받는다(this.props.title or sub)

``` react
class Subject extends Component {
  render() {
    return (
      <header>
        <h1>{this.props.title}</h1>
        <hr></hr>
        {this.props.sub}
      </header>
    );
  }
}

class App extends Component {
  render () {
    return (
      <div className="App">
        <Subject title="WEB" sub="World Wide Web!!"></Subject>
        <TOC></TOC>
        <Content></Content>
      </div>
    );
  }
}
```

## export & import 
---

### 특징
 * 다른 파일에서 만든 컴포넌트를 쓰도록 하기 위함
 * **`export default 컴포넌트 이름;`**
 * **`import export_컴포넌트_이름 from '경로';`**
 
### export
 * Subject.js -> export
``` react
import { Component } from 'react';

class Subject extends Component {
    render() {
      return (
        <header>
          <h1>{this.props.title}</h1>
          <hr></hr>
          {this.props.sub}
        </header>
      );
    }
  }

export default Subject;
```
 * App.js -> import
``` react
import Subject from './components/Subject';

class App extends Component {
  render () {
    return (
      <div className="App">
        <Subject title="WEB" sub="World Wide Web!!"></Subject>
        <TOC></TOC>
        <Content></Content>
      </div>
    );
  }
}
```

## State
---

### constructor
 * 컴포넌트가 실행 될 때 render 함수보다 먼저 실행
 * state의 값을 초기화
 * **`this.state = {}`**

### 코드설명
 * App.js
   * App컴포넌트의 constructor에서 하위 컴포넌트의 데이터를 주입한다.
   * 데이터는 오브젝트 형태로 작성한다.
``` react
class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      subject: {title: 'WEB', sub: 'World Wide Web!!'},
      contents: [
        {id:1, title:'HTML', desc:'HTML is HyperText ...'},
        {id:2, title:'CSS', desc:'CSS is for design ...'},
        {id:3, title:'JAVASCRIPT', desc:'JAVASCRIPT is for interactive ...'}
      ]
    }
  }

  render() {
    return (
      <div className="App">
        <Subject title={this.state.subject.title} sub={this.state.subject.sub}></Subject>
        <TOC data={this.state.contents}></TOC>
        <Content title="HTML" desc="HTML is HyperText Markup Language."></Content>
      </div>
    );
  }
}
```
 * TOC.js
   * App 컴포넌트에서 주입한 데이터를 받아 html요소들을 생산한다.
   * 태그 내의 어트리뷰트에 값을 할당 할 때는 따옴표로 감싸지 않고 {}로 감싼다.
``` react
class TOC extends Component {
    render() {
      let lists = [];
      const data = this.props.data;
      let i = 0;
      while(i < data.length){
        lists.push(<li key={data[i].id}><a href={"/content/"+data[i].id}>{data[i].title}</a></li>)
        i += 1;
      }
      return (
        <nav>
          <ul>
            {lists}
          </ul>
        </nav>
      );
    }
}
```

## Component Event
---

### 컴포넌트 간 이벤트 제어
 * App.js
``` react
import './App.css';
import { Component } from 'react';
import TOC from './components/TOC';
import Content from './components/Content';
import Subject from './components/Subject';

class App extends Component {

  ★constructor는 render보다 먼저 실행되어 state에 값을 주입한다.
  constructor(props) {
    super(props);
    this.state = {
      mode: 'read', ★기본값 지정
      selected_content_id: 1, ★기본값 지정
      welcome: {title: 'Welcome', desc: 'Hello, React!'},
      subject: {title: 'WEB', sub: 'World Wide Web!!'},
      contents: [
        {id:1, title:'HTML', desc:'HTML is HyperText ...'},
        {id:2, title:'CSS', desc:'CSS is for design ...'},
        {id:3, title:'JAVASCRIPT', desc:'JAVASCRIPT is for interactive ...'}
      ]
    }
  }

  ★render안의 컴포넌트에서 이벤트가 일어나면 해당 컴포넌트를 포함한 모든 컴포넌트를 다시 렌더링한다.
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
            ★this.state로 하면 오류가 난다. 자바의 setter처럼 생각하자
            this.setState({ 
              mode: 'welcome'
            });
          ★bind를 사용해서 this를 넘겨줘야 함수 안에서 this를 사용할 수 있다.			
          }.bind(this)}> 
        </Subject>
        <TOC 
          onChangePage={function(id){
            this.setState({
              mode: 'read',
              ★Number() -> 자바스크립트의 Integer.parserInt()
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
```
 * TOC.js
``` react
import { Component } from 'react';

class TOC extends Component {
    render() {
      let lists = [];
      const dataList = this.props.data;

      dataList.forEach(data => {
        lists.push(
          <li key={data.id}>
            <a 
              href={"/content/"+data.id}
              data-id={data.id} ★사용자 정의 어트리뷰트
              onClick={function(e){
                ★태그의 기본적인 동작제거. ex)&lt;a href&gt;&lt;/a&gt;의 페이지 이동
                e.preventDefault();
                this.props.onChangePage(e.target.dataset.id);
              }.bind(this)}>
                {data.title}
            </a>
          </li>
        );
      });
      
      return (
        <nav>
          <ul>
            {lists}
          </ul>
        </nav>
      );
    }
}

export default TOC;
```

## CRUD
---

### Control.js
 * e.preventDefault(): a태그 기본 기능을 제거(페이지 이동)
 * this.props.onChangeMode('mode'):
   * 상위 컴포넌트인 App.js의 함수를 이용해서 {mode: create/update/delete}로 바꿈
``` react
import { Component } from 'react';

class Control extends Component {
  shouldComponentUpdate(newProps){
    if(this.props.data === newProps.data) return false
    else return true;
  }
  render() {
    console.log('Control render');
    return (
      <ul>
        <li><a href="/create" onClick={function (e) {
          e.preventDefault();
          this.props.onChangeMode('create');
        }.bind(this)}>create</a></li>
        <li><a href="/update" onClick={function (e) {
          e.preventDefault();
          this.props.onChangeMode('update');
        }.bind(this)}>update</a></li>
        <li><input onClick={function (e) {
          e.preventDefault();
          this.props.onChangeMode('delete');
        }.bind(this)} type="button" value="delete"></input></li>
      </ul>
    );
  }
}

export default Control;
```

### CreateContent.js
 * create form을 생성
``` react
import { Component } from 'react';

class CreateContent extends Component {
  shouldComponentUpdate(newProps){
    if(this.props.data === newProps.data) return false
    else return true;
  }
  render() {
    console.log('CreateContent render');
    return(
      <article>
        <h2>Create</h2>
        <form action="/create_process" method="post"
          onSubmit={function (e){
            e.preventDefault();
			
            ★ 상위 컴포넌트인 App.js의 onSubmit() 함수를 호출해서 create
            this.props.onSubmit(e.target.title.value, e.target.desc.value);
			
          }.bind(this)}
        >
          <p>
            <input type="text" name="title" placeholder="title"></input>
          </p>
          <p>
            <textarea name="desc" placeholder="description"></textarea>
          </p>
          <p>
            <input type="submit"></input>
          </p>
        </form>
      </article>
    );
  }
}

export default CreateContent;
```

### UpdateContent.js
 * Update의 경우 기존의 데이터를 update 폼에 가져다 놓는다.
 * 이 기존의 데이터는 상위 컴포넌트의 state에서 가져오는 것인데 이는 하위 컴포넌트에서 조작이 불가능하다.
 * 그러므로 constructor를 사용해 하위 컴포넌트인 UpdateContent.js의 state에서 새롭게 초기화한다.
``` react
import { Component } from 'react';

class UpdateContent extends Component {
  constructor(props){
    super(props);
    this.state = {
      id: this.props.data.id,
      title: this.props.data.title,
      desc: this.props.data.desc
    }
    ★ inputFormHandler함수를 항상 bind(this)를 구현한 것으로 한다 -> bind 생략가능
    this.inputFormHandler = this.inputFormHandler.bind(this);
  }

  ★ update form에서 값을 변경하면 state의 값을 변경하여 화면에 동기적으로 변경되도록 함(title, desc)
  inputFormHandler(e){
    this.setState({[e.target.name]: e.target.value});
  }

  render() {
    console.log('UpdateContent render');
    return(
      <article>
        <h2>Update</h2>
        <form action="/update_process" method="post"
          onSubmit={function (e){
            e.preventDefault();
			
            ★ 상위 컴포넌트인 App.js의 onSubmit() 함수를 호출해서 update
            this.props.onSubmit(this.state.id ,this.state.title, this.state.desc);
			
          }.bind(this)}
        >
          <input type="hidden" name="id" value={this.state.id}></input>
          <p>
            <input type="text" name="title" value={this.state.title} 
              onChange={this.inputFormHandler}></input>
          </p>
          <p>
            <textarea name="desc" value={this.state.desc}
              onChange={this.inputFormHandler}></textarea>
          </p>
          <p>
            <input type="submit"></input>
          </p>
        </form>
      </article>
    );
  }
}

export default UpdateContent;
```

### App.js

``` react
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
	
      ★ 새로운 content를 추가할 때의 id값을 구함
      const nextId = this.state.contents[this.state.contents.length-1].id + 1;

      ★ CreateContent.js의 form에서 받아온 _title _desc로 create 실행
      _article = <CreateContent onSubmit={function (_title, _desc){
	  
        ★ 기존의 contents 배열을 받아 새로운 변수를 선언
        let _contents = Array.from(this.state.contents);
		
		★ 새로운 배열변수에 요소 추가
        _contents.push({id: nextId,title: _title, desc: _desc});

        ★ 기존의 contents를 새롭게 배열이 추가된 _contents로 변경
        this.setState({
          contents: _contents,
          mode: 'read',
          selected_content_id: nextId
        });
      }.bind(this)}></CreateContent>
    } else if(this.state.mode === 'update') {
	
      ★ 업데이트할 배열의 id 값
      const findContent = this.getReadContent();
	  
      ★ UpdateContent.js의 form에서 받아온 _title _desc로 update 실행
      _article = <UpdateContent data={findContent} onSubmit={function (_id, _title, _desc){

        let _contents = [];
        this.state.contents.forEach(content => {
          
		  ★ update할 id값과 동일한 요소는 변경 후 new 배열에 push 
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
			
            ★ filter(): return 조건에 맞는 요소들만 반환하여 배열로 생성
            const _contents = this.state.contents.filter(content => {
			
              ★ delete할 id값을 가진 요소를 제외하고 return
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
```


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



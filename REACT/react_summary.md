## Install
---

### �ٿ�ε�
 * ���� â���� npm�� ����ؼ� ��ġ
   * node.js�� ��ġ �Ǿ� �־�� �Ѵ�
   * npm -v �� ���� ��ġ �Ǿ����� Ȯ�� �� �� �ִ�.
``` command
npm install -g create-react-app
```
 * ��ġ�� �Ϸ�Ǹ� create-react-app -V(�빮��)�� ���� Ȯ�� �� �� �ִ�.
``` command
create-react-app -V
4.0.3
```

## Create react-app
---

### ����Ʈ �� ����
 * ����Ʈ ���� ������ �������� 'react'�� ���Ұ�
``` command
cd ���
create-react-app  .
// . �� ���� ������ �����Ѵٴ� �ǹ�
```

### ����Ʈ �� ����/����
 * VS Code �͹̳ο��� ����
``` command
//����
npm run start

//����
Ctrl + c
```

## Coding & Build & Deploy
---

### Coding

 * index.html
   * import <span style="color: red;">App</span> from './App'; 
   * <span style="color: red;">&lt;App /&gt;</span> �̸��� ���ƾ� ��
``` react
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App'; //App�ڿ� js�� ���� �Ǿ� �ִ�.
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
//�Լ� Ÿ��
function App() {
  return (
    <div className="App">
	
	</div>
  );
}
```

``` react
//Ŭ���� Ÿ�� 
//��Ȱ�ڵ������� ������ ���
class App extends Component {
  render () {
    return (
      <div className="App">
		�� �ȿ� �ڵ带 �ۼ��Ѵ�.
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
//�� ��ǻ�� ��𿡼��� serve��� ��ɾ ���ؼ� �������� ��ġ ����
npm install -g serve 
```

``` react
//�� ���� ���� ��ų �������� �ٿ�ε� �޾Ƽ� ����
npx serve -s build
```

## Component
---

### Component ����
 * class �̸��� �±��̸����� ���ȴ�.
 * react�� Component�� ��� �޾ƾ� �Ѵ�.
 * ������Ʈ�� ���� ���� �ݵ�� �ϳ��� �ֻ��� �±׷� �����ؾ� �Ѵ�.
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

### Ư¡
 * ������Ʈ�� ������ �� �ֵ��� ��
 * **`this.props.��Ʈ����Ʈ_�̸�`**

### �ڵ� ����
 * App ������Ʈ�� Subject ������Ʈ�� ����Ѵ�.
 * Subject ������Ʈ�� �����͸� App ������Ʈ���� �����Ѵ�.(��ü���ⰳ��)
 * App ������Ʈ���� Subject �±׿��� ��Ʈ����Ʈ�� ����� ���� �����Ѵ�.
 * Subject ������Ʈ���� �� ��Ʈ����Ʈ�� ���� ���� ���Թ޴´�(this.props.title or sub)

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

### Ư¡
 * �ٸ� ���Ͽ��� ���� ������Ʈ�� ������ �ϱ� ����
 * **`export default ������Ʈ �̸�;`**
 * **`import export_������Ʈ_�̸� from '���';`**
 
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
 * ������Ʈ�� ���� �� �� render �Լ����� ���� ����
 * state�� ���� �ʱ�ȭ
 * **`this.state = {}`**

### �ڵ弳��
 * App.js
   * App������Ʈ�� constructor���� ���� ������Ʈ�� �����͸� �����Ѵ�.
   * �����ʹ� ������Ʈ ���·� �ۼ��Ѵ�.
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
   * App ������Ʈ���� ������ �����͸� �޾� html��ҵ��� �����Ѵ�.
   * �±� ���� ��Ʈ����Ʈ�� ���� �Ҵ� �� ���� ����ǥ�� ������ �ʰ� {}�� ���Ѵ�.
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

### ������Ʈ �� �̺�Ʈ ����
 * App.js
``` react
import './App.css';
import { Component } from 'react';
import TOC from './components/TOC';
import Content from './components/Content';
import Subject from './components/Subject';

class App extends Component {

  ��constructor�� render���� ���� ����Ǿ� state�� ���� �����Ѵ�.
  constructor(props) {
    super(props);
    this.state = {
      mode: 'read', �ڱ⺻�� ����
      selected_content_id: 1, �ڱ⺻�� ����
      welcome: {title: 'Welcome', desc: 'Hello, React!'},
      subject: {title: 'WEB', sub: 'World Wide Web!!'},
      contents: [
        {id:1, title:'HTML', desc:'HTML is HyperText ...'},
        {id:2, title:'CSS', desc:'CSS is for design ...'},
        {id:3, title:'JAVASCRIPT', desc:'JAVASCRIPT is for interactive ...'}
      ]
    }
  }

  ��render���� ������Ʈ���� �̺�Ʈ�� �Ͼ�� �ش� ������Ʈ�� ������ ��� ������Ʈ�� �ٽ� �������Ѵ�.
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
            ��this.state�� �ϸ� ������ ����. �ڹ��� setteró�� ��������
            this.setState({ 
              mode: 'welcome'
            });
          ��bind�� ����ؼ� this�� �Ѱ���� �Լ� �ȿ��� this�� ����� �� �ִ�.			
          }.bind(this)}> 
        </Subject>
        <TOC 
          onChangePage={function(id){
            this.setState({
              mode: 'read',
              ��Number() -> �ڹٽ�ũ��Ʈ�� Integer.parserInt()
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
              data-id={data.id} �ڻ���� ���� ��Ʈ����Ʈ
              onClick={function(e){
                ���±��� �⺻���� ��������. ex)&lt;a href&gt;&lt;/a&gt;�� ������ �̵�
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



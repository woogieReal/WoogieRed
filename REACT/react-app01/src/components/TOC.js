import { Component } from 'react';

class TOC extends Component {
  shouldComponentUpdate(newProps){
    if(this.props.data === newProps.data) return false
    else return true;
  }
  render() {
    console.log('TOC render');
    let lists = [];
    const dataList = this.props.data;

    dataList.forEach(data => {
      lists.push(
        <li key={data.id}>
          <a 
            href={"/content/"+data.id}
            data-id={data.id}
            onClick={function(e){
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
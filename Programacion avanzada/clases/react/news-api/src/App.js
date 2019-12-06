import React, { Component, Fragment } from 'react';
import Header from './components/Header';
import NoticesList from './components/NoticesList';
import Formulary from './components/Formulary';

class App extends Component {

  state = {
    notices: []
  }

  getNotices = async (category='general') => {
    const APPID = 'bba9af5509ab49f48b309c6329b79036';
    const newsapi = `https://newsapi.org//v2/top-headlines?country=ar&category=${category}&apiKey=${APPID}`;
    const response = await fetch(newsapi);
    const notices = await response.json();

    this.setState({ notices: notices.articles })
  }

  componentDidMount() {
    this.getNotices();
  }

  render() {
    return(
        <Fragment>
          <Header title='React News'/>
          <div className="container white container-news">
            <Formulary getNotices={ this.getNotices }/>
          </div>

          <div>
            <NoticesList notices={ this.state.notices }></NoticesList>
          </div>
        
        </Fragment>
    );
  }

}

export default App;

import React, {Fragment} from 'react';
import './App.css';
import Header from './components/Header';
import ProductList from './components/ProductList';
import Footer from './components/Footer';


function App() {
    
  return (


    <Fragment>
      <Header
        title = 'Virtual Store'
      />
      <ProductList />
      <Footer
        date = { new Date().getFullYear() }
      />
    </Fragment>

  );
}

export default App;

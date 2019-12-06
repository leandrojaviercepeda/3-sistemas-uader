import React from 'react';

// Redux
import { Provider } from 'react-redux';
import store from './store';

import './bootstrap.min.css'
import './index.css'

function App() {
  return (
    <Provider store={store}>
      <div className='container'>

        <header>
          <h1 className='text-center'>Administrador de pacientes</h1>
        </header>

        <div className='row mt=3'>

          <div className='col-md-6'>
            Formulario
          </div>

          <div className='col-md-6'>
            Listado aqui
          </div>

        </div>

      </div>
    </Provider>
  );
}

export default App;

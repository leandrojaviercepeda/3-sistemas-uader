import { createStore } from 'redux';
import reducers from './reducers/citasReducer'

// Definimos el state inicial
//const INITIAL_STATE = [];

// El reducer son todas las funciones que se van a encargar de modificar todo el state.
// Ejemplos: agregarCita, eliminarCita, etc.


const store = createStore(
    reducers, 
    //INITIAL_STATE,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
  );

export default store;

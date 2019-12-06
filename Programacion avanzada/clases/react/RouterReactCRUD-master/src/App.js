import React, {useEffect, useState} from 'react';
import { BrowserRouter as Router, Route, Switch} from 'react-router-dom';
import axios from 'axios';

import Productos from './components/Productos'
import EditarProducto from './components/EditarProducto'
import AgregarProducto from './components/AgregarProducto'
import Producto from './components/Producto'
import Header from './components/Header';

function App() {

  const [ productos, guardarProductos ] = useState([])
  const [ recargarProductos, guardarRecargaProductos ] = useState(true)

  useEffect(() => {

      if(recargarProductos){
        const consultarApi = async () => {
          // consultar la api de json -server
          const resultado = await axios.get('http://localhost:4000/restaurant');
  
         // console.log(resultado);
         guardarProductos(resultado.data); // pasamos el resultado al state
      }
     
      consultarApi();// llamamos a la funcion

      // cambiar a false la recarga de los productos
      guardarRecargaProductos(false)
        
      }
     
  },[recargarProductos])
  return (
    
    <Router>
      <Header/>
      <main className="container mt-5">
      <Switch>
        <Route exact path="/productos" 
        render = { ()=> (
          <Productos
          productos={ productos }
          />
        )}
          />
         
        <Route exact path="/nuevo-producto" 
        render={() => (
          <AgregarProducto
            guardarRecargaProductos={ guardarRecargaProductos }
          />
        )}></Route>
        <Route exact path="/productos/:id" component={Productos}></Route>
        <Route exact path="productos/editar/:id" component={EditarProducto}></Route>
      </Switch>
      </main>
      <p className="mt-4 p2 text-center">Todos los derechos reservados</p>
    </Router>
  );
}

export default App;

import React, {Component} from 'react';
import './bootstrap.min.css'

import Header from './component/Header'
import NuevaCita from './component/NuevaCita';
import ListaCitas from './component/ListaCitas';


class App extends Component  {

  state = {
    citas : []
  }

  // crea una nueva cita
  crearNuevaCita = datos => {
    //console.log(datos);
    //copiar el state actual
    const citas = [...this.state.citas, datos]

    // agregar el nuevo state
    this.setState({
      citas
    })
    
  }

  //elimina una cita del state
  eliminarCita = id => {
    //console.log(id)

    //tomar una copia del state
    const citas = [...this.state.citas].filter(cita => cita.id !== id)

    this.setState({
      citas
    })
    
  }

  // cuando la aplicacion se carga
  componentDidMount(){
    const citasLS = localStorage.getItem('citas')
    
    if(citasLS) this.setState({ citas: JSON.parse(citasLS) })
  }

  // cuando agregamos o eliminamos una nueva cita
  componentDidUpdate() {
    localStorage.setItem('citas', JSON.stringify(this.state.citas))
  }

  render() {

    return (

      <div className="container">

        <Header 
          titulo="Administrador  de Pacientes Veterinaria"
        />
        <NuevaCita
          crearNuevaCita={this.crearNuevaCita}
        />

        <ListaCitas
          citas = { this.state.citas }
          eliminarCita = { this.eliminarCita }
         />

      </div>
        
    );
  }
 

}

export default App;

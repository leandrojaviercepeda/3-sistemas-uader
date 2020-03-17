import React ,{Component} from 'react'
import uuid from 'uuid';

const stateInicial = {

    cita: {
        mascota: '',
        propietario: '',
        fecha: '',
        hora:'',
        sintomas:''
    },
    error: false
 }


class NuevaCita extends Component {
    
    state = {...stateInicial}

       
     handleChange = e => {
        // colocar lo que el usuario escribe en el state
        this.setState({
            cita : {
                ...this.state.cita,
                [e.target.name] : e.target.value
            }
        })
   
     }

    // cuando el usuario envia el formulario
    handleSubmit = e => {
        e.preventDefault();

    //extraer los valores del state
    const { mascota, propietario, fecha, hora, sintomas } = this.state.cita

       //validar que todos los campos esten llenos
       if(mascota === '' || propietario === '' || fecha === ''|| hora === ''|| sintomas === '' )
       {
            this.setState({
                error: true
            })

            // detener la ejecucion
            return;
       }

       // generar objeto cons los datos
       const nuevaCita = {...this.state.cita};
       nuevaCita.id = uuid();


          // agragar la cita al state de App
          this.props.crearNuevaCita(nuevaCita)

          //colocar en el state el stateInicial
          this.setState({
              ...stateInicial
          })

    }

    render() { 

        /// extrar valor del state
        const {error} = this.state;
        return ( 
            <div className="card mt-5 py-5">
                <div className="card-body">
                    <h2 className="card-title text-center mb-5">
                        Llene el formulario para crear una nueva cita
                    </h2>

                    {error ? <div className="alert alert-danger mt-2 mb-5 
                    text-center">Todos los campos son obligatorios</div> : null}

                <form onSubmit={this.handleSubmit}>
                    <div className="form-group row">
                        <label className="col-sm-4 col-lg-2 col-form-label">
                            Nombre de Mascota
                        </label>
                        <div className="col-sm-8 col-lg-10">
                            <input
                                type="text"
                                className="form-control"
                                placeholder="Nombre Mascota"
                                name="mascota"
                                onChange={this.handleChange}
                                value={this.state.cita.mascota}
                            />
                        </div>
                    </div>

                    <div className="form-group row">
                        <label className="col-sm-4 col-lg-2 col-form-label">
                            Nombre del dueño
                        </label>
                        <div className="col-sm-8 col-lg-10">
                            <input
                                type="text"
                                className="form-control"
                                placeholder="Nombre Dueño"
                                name="propietario"
                                onChange={this.handleChange}
                                value={this.state.cita.propietario}
                            />
                        </div>
                    </div>
                    {/*form-group */} 

                    <div className="form-group row">
                        <label className="col-sm-4 col-lg-2 col-form-label">
                           Fecha
                        </label>
                        <div className="col-sm-8 col-lg-4">
                            <input
                                type="date"
                                className="form-control"
                                name="fecha"
                                onChange={this.handleChange}
                                value={this.state.cita.fecha}
                            />
                        </div>
                    </div>
                    {/*form-group */} 


                    <div className="form-group row">
                        <label className="col-sm-4 col-lg-2 col-form-label">
                            Hora
                        </label>
                        <div className="col-sm-8 col-lg-4">
                            <input
                                type="time"
                                className="form-control"
                                name="hora"
                                onChange={this.handleChange}
                                value={this.state.cita.hora}
                            />
                        </div>
                    </div>
                    {/*form-group */} 

             
                    <div className="form-group row">
                        <label className="col-sm-4 col-lg-2 col-form-label">
                            Sintomas
                        </label>
                        <div className="col-sm-8 col-lg-10">
                            <textarea
                                type="text"
                                className="form-control"
                                placeholder="Ingrese síntomas"
                                name="sintomas"
                                onChange={this.handleChange}
                                value={this.state.cita.sintomas}
                                />
                        </div>
                    </div>
                    <input
                        type="submit"
                        className="py-3 mt-2 btn btn-success btn-block"
                        value="Agregar nueva cita"
                    />
                
                </form>  
                {/*form-group */} 
                
                </div>
            </div>
         );
    }
}
 
export default NuevaCita;

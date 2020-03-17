import React from 'react';

const Cita = ({cita, eliminarCita}) => (

    <div className="media mt-3">
        <div className="media-body">
            <h3 className="mt-0">{cita.mascota}</h3>
            <p className="card-text">
              <span>Nombre del dueño: </span> {cita.propietario}
            </p>
            <p><span>Fecha: </span> {cita.fecha}</p>
            <p><span>Hora: </span> {cita.hora}</p>
            <p><span>Sintomas: </span> {cita.sintomas}</p>

            <button 
              className="btn btn-danger" 
              onClick={ () => eliminarCita(cita.id) }
            >
              Borrar &times;
            </button>
        </div>
    </div>
)

export default Cita;

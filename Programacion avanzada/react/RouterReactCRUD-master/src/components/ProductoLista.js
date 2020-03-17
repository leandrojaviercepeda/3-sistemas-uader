import React from 'react'
import { Link } from 'react-router-dom'

function ProductoLista({producto}) {

    // Generamos la funcion para eliminar producto
    const eliminarProducto = id => {
        
        console.log('eliminado', id);
        
    }
    return(
        <li data-categoria={producto.categoria} className="list-group-item d-flex justify-content-between
        align-item-center">

            <p>
                {producto.nombrePlato} {' '}
                <span className="font-weight-bold">${producto.precioPlato}</span>
            </p>

            <div>

                <Link 
                    to={`/productos/editar/${producto.id}`}
                    className="btn btn-success mr-2"
                >
                    Editar
                </Link>

                <button
                type="button"
                className=" btn btn-danger"
                onClick={() => eliminarProducto(producto.id) }
                >
                        Eliminar &times;
                </button>

            </div>

        </li>
    )
}

export default ProductoLista;
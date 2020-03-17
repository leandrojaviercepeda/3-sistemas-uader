import React, {Fragment} from 'react';
import ProductoLista from './ProductoLista';

function Productos({productos}) {
     
    return (
        <Fragment>
        <h1 className="text-center">Productos</h1>
        <ul className=" list-group mt-5">
            { productos.map(producto => (
        // damos por implicito al return con los parentesis
                <ProductoLista
                    key= {producto.id}
                    producto = { producto }
                // en cada iteracion le voy pasando el objeto producot
                 />
            ))}
        </ul>
        </Fragment>
    )
}

export default Productos;

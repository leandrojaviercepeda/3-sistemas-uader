import React from 'react';

const Cotizacion = ({resultado}) => {

    const {MONEDA} = resultado;
    const {PRICE, HIGHDAY, LOWDAY, CHANGE24HOUR, LASTUPDATE} = resultado[MONEDA];

    return ( 
        <div className="resultado">
            <h2>Resultado</h2>
            <p className="precio">El precio es <span>{PRICE}</span> </p>

            <p>Precio más alto del día: <span>{HIGHDAY}</span> </p>
            <p>Precio más bajo del día: <span>{LOWDAY}</span> </p>
            <p>Variación últimas 24 horas: <span>{CHANGE24HOUR}</span> </p>
            <p>Última Actualización: <span>{new Date().getDay(LASTUPDATE)}/{new Date().getMonth(LASTUPDATE)}/{new Date().getFullYear(LASTUPDATE)}</span></p>
        </div>
     );
}
 
export default Cotizacion;
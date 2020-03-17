import React, {useState, useEffect} from 'react';
import axios from 'axios'

import Criptomoneda from './Criptomoneda';
import Error from './Error';

function Formulario(props) {
       
    const [topCriptoMonedas, setTopCriptoMonedas] = useState([]);
    const [criptoMoneda, setCriptoMoneda] = useState(null);
    const [ultimaMoneda, setUltimaMoneda] = useState(null);
    const [moneda, setMoneda] = useState(null);
    const [error, setError] = useState(false);

    const handleMoneda = e => {
        setMoneda(e.target.value);
    }

    const handleCriptoMoneda = e => {
        const cm = topCriptoMonedas.find((coin) => {
            return (coin.CoinInfo.Name == e.target.value) ? coin : null;
        })
        cm.RAW.MONEDA = moneda; //Agregamos el campo al objeto para luego poder obtener los datos de la cotizacion
        setCriptoMoneda(cm);
    }
    
    useEffect(() => {

        const consultarApi = async (tsym, limit=10) => {
            const API_KEY = '38f4093e44dbffaf6695d000676cc5bf17471e63fd9e6bd6a98f9ada1461259d';
            const resultado = await axios.get(`https://min-api.cryptocompare.com/data/top/totaltoptiervolfull?limit=${limit}&tsym=${tsym}&api_key=${API_KEY}`);
            const topCoins = resultado.data.Data;

            setUltimaMoneda(tsym);
            setTopCriptoMonedas(topCoins);
        }

        if ((moneda !== ultimaMoneda) || (moneda && topCriptoMonedas.length === 0)) {
            consultarApi(moneda);
        }
    });
      
    // Validar que el usuario llene ambos campos
    const cotizarMoneda = e => {
        e.preventDefault();      
        
        // validar si ambos campos estan llenos
        if (!moneda || !criptoMoneda) {
            setError(true);
        } else {

            //pasar los datos al componente principal
            props.onCahngeCotizacion(criptoMoneda.RAW);
            
        }
        
    }

    // Mostrar el error en caso de que exista
    let componenteError = (error) ?  <Error mensaje="Ambos campos son obligatorios"/> : null;
    let options = topCriptoMonedas.map((coin, index) => {return (<Criptomoneda key={index} criptomoneda={coin}/>)});
    return (
        <form>
            {componenteError}
            <div className="row">
                <label>Elige tu Moneda</label>
                <select className="u-full-width" onChange={handleMoneda}>
                    <option value="">- Elige tu Moneda -</option>
                    <option value="USD" >Dolar Estadounidense</option>
                    <option value="MXN">Peso Mexicano</option>
                    <option value="GBP">Libras</option>
                    <option value="EUR">Euro</option>
                </select>
            </div>

            <div className="row">
                <label>Elige tu Criptomoneda</label>
                <select className="u-full-width" id="selectCriptomoneda" onChange={handleCriptoMoneda}>
                    <option value="">- Elige tu Criptomoneda -</option>
                        {options}
                </select>
            </div>

            <input type="submit" className="button-primary u-full-width" value="Calcular" onClick={cotizarMoneda}/>
        </form>

    );
}

export default Formulario;
import React, {useEffect, useState} from 'react';

import axios from 'axios';
import imagen from './cryptomonedas.png';

import Formulario from './components/Formulario';
import Cotizacion from './components/Cotizacion';
import Spinner from './components/Spinner';

function App() {

  const [coinInfo, setCoinInfo] = useState(null)
  const [cargando, setCargando] = useState(true);

  const handleCoinInfo = info => {
    setCoinInfo(info);
  }

  useEffect(() => {
    // si no hay moneda, no ejecutar
    if (!coinInfo) {
      setCargando(true);
    } else if (coinInfo) setCargando(false);
  })
  
  // Mostrar Spinner o resultado
  const componente = (cargando) ? <Spinner /> : <Cotizacion resultado={coinInfo} />

  return (
    <div className="container">
        <div className="row">
            <div className="one-half column">
                <img src={imagen} alt="imagen criptomonedas" className="logotipo" />
            </div>
            <div className="one-half column">
                <h1>Cotiza Criptomonedas al Instante</h1>
                {componente}
          </div>
          <Formulario  onCahngeCotizacion={handleCoinInfo}/>
        </div>       
    </div>
    
  );
}

export default App;

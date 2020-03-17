
function getRandomArbitrary(min, max) {
    const number = Math.random() * (max - min) + min
    return number.toFixed(2);
  }

let generateRandomWeatherData = () => {

    let temperature = getRandomArbitrary(-30, 50)
    let pressure = getRandomArbitrary(1, 100)
    let uv_radiation = getRandomArbitrary(1, 100)
    let humidity = getRandomArbitrary(1, 100)
    let wind_vel = getRandomArbitrary(1, 100)
    let wind_dir = getRandomArbitrary(1, 100)
    let rain_mm = getRandomArbitrary(0, 100)
    let rain_intensity = getRandomArbitrary(0, 100)
    let id_station = Math.floor(Math.random() * (10 - 1)) + 1

    console.log(`INSERT INTO measurement (temperature, pressure, uv_radiation, humidity, wind_vel, wind_dir, rain_mm, rain_intensity, id_station)
     VALUES (${temperature}, ${pressure}, ${uv_radiation}, ${humidity}, ${wind_vel}, ${wind_dir}, ${rain_mm}, ${rain_intensity}, ${id_station})`);
    
}


for (i = 0; i <= 10 ; i++) {
    generateRandomWeatherData()
}

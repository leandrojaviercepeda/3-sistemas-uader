const axios = require('axios')

const getTemperature = async(lat, lon) => {

    const apikey = 'cb48e3f55749701e6c3d3d7adb739bb2'
        //const resp = await axios.get(`api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apikey}`)
    const resp = await axios.get(`http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apikey}`)
    return resp.data.main.temp

}

module.exports = { getTemperature }
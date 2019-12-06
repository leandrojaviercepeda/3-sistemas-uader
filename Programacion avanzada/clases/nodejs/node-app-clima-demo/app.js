const place = require('./place/place')
const weather = require('./weather/weather')


const yargs = require('yargs').options({
    direction: {
        alias: 'p',
        desc: 'Place name',
        demand: true
    }
}).argv


const getInfo = (direction) => {

    place.getGeoLocation(direction).then((location, err) => {

        if (err) {
            throw new Error(err)
        } else {

            weather.getTemperature(location.lat, location.lon).then((temperature, err) => {
                if (err) {
                    throw new Error(err)
                } else {
                    console.log(`La temperatura de ${direction} es de ${temperature} C° y su latitud y longitud es ${location.lat}, ${location.lon}`)
                }
            })
        }
    })

}

getInfo(yargs.direction)
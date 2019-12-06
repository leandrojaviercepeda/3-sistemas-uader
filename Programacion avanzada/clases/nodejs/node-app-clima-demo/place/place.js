const axios = require('axios')

let getGeoLocation = async(location) => {


    const rapidAPI = axios.create({
        baseURL: `https://devru-latitude-longitude-find-v1.p.rapidapi.com/latlon.php?location=${location}`,
        headers: {
            "x-rapidapi-key": "ce15ac61b3mshd262e621fd75e5ep19bb4bjsn3634fe4da3cf"
        }
    })

    const resp = await rapidAPI.get()

    if (resp.data.Results.lenght === 0) {
        throw new Error(`Not results for this ${location}.`)
    }

    const data = resp.data.Results[0]
    const name = data.name
    const lat = data.lat
    const lon = data.lon

    return {
        name,
        lat,
        lon
    }
}

module.exports = { getGeoLocation }
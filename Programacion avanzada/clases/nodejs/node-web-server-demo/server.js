const express = require('express')
const hbs = require('hbs')
const app = express();

require('./hbs/helpers')

//Generamos una variable de entorno para el deploy en Heroku
const  port = process.env.PORT || 3000

app.use(express.static(__dirname + '/public'))

//EXPRESS HBS ENGINE
app.set('view engine', 'hbs')

hbs.registerPartials(__dirname + '/views/partials')


//Render home
app.get('/', (req, res) =>{
    
    res.render('home', { name: 'Leandro', family_name: 'Cepeda' } )
})

app.get('/about', (req, res)=>{
    res.render('about', { name: 'Leandro', family_name: 'Cepeda' })
})

app.listen(port, () => {
    console.log(`Escuchando peticiones en el puerto ${port}`)
        //LIsten recibe un callback y le paso una funcion
})


// Para correr la aplicacion en entorno de desarrollo con nodemon, use el comando: nodemon run server

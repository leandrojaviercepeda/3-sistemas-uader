const express = require('express')
const path = require('path')
const http = require('http')
const socketIO = require('socket.io')

const app = express()

//Instanciamos http, lo cual es requerido por socket.io
let server = http.createServer(app)

const publicPath = path.resolve(__dirname, '../public')
const port = process.env.PORT || 3000

app.use(express.static(publicPath))

//IO = esta es la comunicacion del backend a travez del socket
let IO = socketIO(server)

IO.on('connection', (client) => {
    console.log('User connected')


    let messaje = { user: 'Sever', msj: 'Bienvenido a la coscu Army!!' }
    client.emit('sendMessaje', messaje)
    client.on('sendMessaje', (msj) => console.log(`Messaje of ${msj.user}: ${msj.msj}`))

    client.on('disconnect', () => console.log('Usser disconnected'))

})

server.listen(port, (err) => {
    if (err) throw new Error(err)
    console.log(`Servidor corriendo en puerto ${ port }`)
});
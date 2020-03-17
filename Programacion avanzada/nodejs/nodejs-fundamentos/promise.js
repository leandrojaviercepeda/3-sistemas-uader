//Una Promise nos permite ejecutar un trabajo ya sea asincrono o sincrono despues de ejecutar una tarea
let empleados = [{
    id: 1,
    nombre: 'Leandro'
}, {
    id: 2,
    nombre: 'Javier'
}, {
    id: 3,
    nombre: 'Gonzalo'
}]

let salarios = [{
    id: 1,
    salario: 3000
}, {
    id: 2,
    salario: 4000
}]


//Promise empleado
let getEmpleado = (id) => {
    return new Promise((resolve, reject) => {
        //resolve se llama si la promesa es exitosa
        //reject se llama si la promesa no es exitosa

        let empleadosDB = empleados.find(empleados => empleados.id === id)

        if (!empleadosDB) {
            reject(`No existe el empleado con este ID: ${id}.`)
        } else {
            resolve(empleadosDB)
        }
    })
}

getEmpleado(1).then(empleado => {
    console.log(`El empleado de DB es: ${empleado.nombre}`)
}, (error) => {
    console.log(error);
})

//Promise salario
let getSalario = (id) => {
    return new Promise((response, reject) => {
        let salarioDB = salarios.find(salarios => salarios.id === id)

        if (!salarioDB) {
            reject(`No existe el salario con este ID: ${id}.`);
        } else {
            response(salarioDB)
        }
    })
}

getSalario(2).then((salario) => {
    console.log(`El salario de DB es: ${salario.salario}`)
}, (error) => {
    console.log(error);
})
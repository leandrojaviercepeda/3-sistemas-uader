// var a = 30; // Variable global
// function primerFuncion (){
//     var a = 40; // Variable local
//     console.log(a);
// }

// primerFuncion();


//Parametros de una funcion
// function imprimir(nombre, apellido) {
//     console.log(`Mi nombre es: ${nombre}`);
//     console.log(`Mi apellido es: ${apellido}`);
// }

// Los parametro que puede recibir una funcion pueden ser, objetos, variables primitivas o funciones inclusive
// imprimir('Leandro', 'Cepeda');


// Enviar objetos anonimos
// function imprimir(persona) {
//     console.log(`Nombre: ${persona.nombre}, Apellido: ${persona.apellido}`);
// }

// imprimir({nombre: 'Leandro', apellido: 'Cepeda'});

// //Otra forma de declarar objetos
// var leandro = {nombre: 'Leandro', apellido: 'Cepeda'};

// imprimir(leandro);


//Pasando funciones como parametros
// function imprimir(fn) {
//     fn(); //Funcion que sera llamada
// }

// var comoMeLlamo = function () { 
//     var leandro = {nombre: 'Leandro', apellido: 'Cepeda'};
//     console.log(`Nombre: ${leandro.nombre}, Apellido: ${leandro.apellido}`);
// }

// imprimir(comoMeLlamo);


//Retorno de funcion
// function obtenerAleatorio() {
//     return Math.random();
// }

// console.log(obtenerAleatorio() + 100);


//Notacion por par (asi se llama a la asignacion del valor a la clave del objeto)
// function crearPersona(nombre, apellido) {
//     return {nombre: nombre, apellido: apellido};
// }

// var persona = crearPersona('Luke', 'Sky');
// console.log(persona);

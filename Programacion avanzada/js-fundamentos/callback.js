const SWAPI = 'https://swapi.co/api/';
const PEOPLE = 'people/:id';

//Las peticiones asincronas con jquery se utilizan con el simbolo '$'
const pj1 = `${SWAPI}${PEOPLE.replace(':id', '1')}`;
const pj2 = `${SWAPI}${PEOPLE.replace(':id', '2')}`;
const pj3 = `${SWAPI}${PEOPLE.replace(':id', '3')}`;

//Callback: es una funcion que se va a pasar como parametro y se ejecuta luego de que finalice la respuesta

$.get(pj1, function(pj) {
    console.log(`Hola soy ${pj.name}`);

    if (callback) { callback(); }
});
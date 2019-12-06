// New es parecido al concepto de clases en otros lenguajes
function Jedi() {
    this.nombre = 'Kylo';
    this.apellido = 'Ren';
    this.edad = 123;

    console.log('Esto paso por aca!'); //Visualizando el sincronismo de js
}

var jedi = new Jedi(); //Invocacion a la funcion
console.log(jedi);
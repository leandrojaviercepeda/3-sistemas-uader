//Los prototipos sirven para expandir los objetos en funciones
//Mejora el manejo de los objetos

function Persona() {
    this.nombre = 'Leandro';
    this.apellido = 'Cepeda';
    this.edad = 26;
    this.pais = '';

    this.imprimirInfo = function() {
        console.log(`${this.nombre} ${this.apellido} ${this.edad} ${this.pais}`);
    }
}

Persona.prototype.pais = 'Argentina';
var er = new Persona();
console.log(Persona.prototype.pais);
console.log(er);
// Definiendo una funcion dentro del objeto
var persona = {
    nombre: 'Leandro',
    apellido: 'Cepeda',
    imprimirNombre: function() {
        console.log(`${this.nombre} ${this.apellido}`);
    }
}

persona.imprimirNombre();
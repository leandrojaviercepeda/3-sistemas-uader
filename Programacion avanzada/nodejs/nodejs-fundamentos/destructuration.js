//Destructuracion de objetos

let deadpool = {
    nombre: 'Wade',
    apellido: 'Winston',
    poder: 'Regeneracion',
    getInfo: () => `${this.nombre} ${this.apellido} ${this.poder}..`
}

let { nombre, apellido, poder } = deadpool; //Esto es lo que se denomina como destructuracion 

console.log(nombre, apellido, poder);
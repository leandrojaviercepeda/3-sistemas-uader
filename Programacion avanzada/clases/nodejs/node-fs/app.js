const fs = require('fs')

let base = 3
let data = ''

for (let i = 1; i <= 10; i++) {
    data += `${base}*${i} = ${base * i}\n`
}

fs.writeFile(path = `tabla-${base}.txt`, data, (error) => {
    if (error) throw (error)
    console.log(`El archivo "${path}" ha sido creado.`)
})
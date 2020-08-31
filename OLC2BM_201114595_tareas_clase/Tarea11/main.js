var parser = require('./Gramatica/gramatica');

let salida;
try {
    //---donde entrada representa una cadena aritmética
    const entrada ="1+3/4*2"
    salida = parser.parse(entrada.toString());
    console.log(salida)
} catch (e) {
    console.error(e);
    return;
}



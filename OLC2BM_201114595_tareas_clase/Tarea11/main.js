var parser = require('./Gramatica/gramatica');
const readline = require('readline');

let ast;
try {
    //---donde entrada representa una cadena aritmética
    const entrada ="1+3/4*2"
    ast = parser.parse(entrada.toString());
    console.log(ast)
} catch (e) {
    console.error(e);
    return;
}



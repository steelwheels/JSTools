/* require0.js */

console.log("* Test require function to load external library\n") ;
let primitives = require('Graphics/Primitives') ;

let pt0 = new primitives.Point(11, 12) ;
console.log("x = " + pt0.x + ", y = " + pt0.y + "\n") ;


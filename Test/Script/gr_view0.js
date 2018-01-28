/* gr_view0.js */

console.log("* Test Graphics/Primitive Library\n") ;
const primitives = require('Graphics/Primitives') ;
const grcons     = require('Graphics/Console') ;

const pt0  = new primitives.Point(1, 1) ;
const sz0  = new primitives.Size(13, 14) ;
const rct0 = new primitives.Rect(pt0, sz0) ;
const view0 = new primitives.View(rct0) ;

const astr0 = view0.alignStringToLeft(10, "hello") ;
const astr1 = view0.alignStringToRight(10, "hello") ;
const astr2 = view0.alignStringToCenter(10, "hello") ;
console.log("alignLeft:   \"" + astr0 + "\"\n") ;
console.log("alignRight:  \"" + astr1 + "\"\n") ;
console.log("alignCenter: \"" + astr2 + "\"\n") ;

const astr10 = view0.alignStringToLeft(10,   "hello, world !!!") ;
const astr11 = view0.alignStringToRight(10,  "hello, world !!!") ;
const astr12 = view0.alignStringToCenter(10, "hello, world !!!") ;
console.log("alignLeft:   \"" + astr10 + "\"\n") ;
console.log("alignRight:  \"" + astr11 + "\"\n") ;
console.log("alignCenter: \"" + astr12 + "\"\n") ;

/* End of this script */
console.log("Bye") ;


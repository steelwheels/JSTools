/* gr_primitive0.js */

console.log("* Test Graphics/Primitive Library\n") ;
const primitives = require('Graphics/Primitives') ;

const pt0 = new primitives.Point(11, 12) ;

const pt1 = pt0.clone() ;
pt1.x += 1 ;
pt1.x += 1 ;

console.log("pt0: x = " + pt0.x + ", y = " + pt0.y + "\n") ;
console.log("pt1: x = " + pt1.x + ", y = " + pt1.y + "\n") ;

const sz0  = new primitives.Size(13, 14) ;
const rct0 = new primitives.Rect(pt0, sz0) ;
const rct1 = rct0.clone() ;
rct0.size.width += 1 ;
rct0.size.height += 1 ;

if(rct0.size.width==14 && rct0.size.height==15 && rct1.size.width==13 && rct1.size.height==14){
  console.log("Clone rect ... OK\n") ;
} else {
  console.log("Clone rect ... NG\n") ;
}

/* End of this script */
console.log("Bye\n") ;


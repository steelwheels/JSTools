console.log("setup curses start\n") ;

prim	= require('Graphics/Primitives') ;
gtcons 	= require('Graphics/Console') ;

if(gtcons == null){
	console.log("[Error] Can not read Graphics/Console") ;
}

console.setScreenMode(true) ;

const origin = new prim.Point(1, 1) ;
const size   = new prim.Size(40, 3) ;
const frame  = new prim.Rect(origin, size) ;

//const view   = new gtcons.View(frame) ;
//view.drawLine(1, 1, 30, "Hello", Align.Center) ;

console.log("Press \"q\" to quit\n") ;
let key = 0 ;
while((key = console.getKey()) != null){
	let c = String.fromCharCode(key) ;
	console.log("Key : " + c + "\n") ;
	if(c == "q"){
		break ;
	}
}

console.log("Bye\n") ;


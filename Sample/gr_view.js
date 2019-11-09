console.log("setup curses start") ;

prim	= require('Graphics/Primitives') ;
gtcons 	= require('Graphics/Console') ;

if(gtcons == null){
	console.error("[Error] Can not read Graphics/Console") ;
}

console.setScreenMode(true) ;

const origin = new prim.Point(1, 1) ;
const size   = new prim.Size(40, 3) ;
const frame  = new prim.Rect(origin.x, origin.y, size.width, size.height) ;

const view   = new prim.View(frame) ;
view.foregroundColor = Color.Yellow ;
view.backgroundColor = Color.Blue ;
view.drawRect(1, 1, 30, 3, "Hello", Align.Center) ;

console.moveTo(30, 7) ;
console.setColor(Color.White, Color.Black) ;
console.log("Press \"q\" to quit") ;
let key = 0 ;
while((key = console.getKey()) != null){
	let c = String.fromCharCode(key) ;
	console.log("Key : " + c) ;
	if(c == "q"){
		break ;
	}
}

console.log("Bye") ;


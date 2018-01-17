console.log("setup curses start\n") ;

console.setScreenMode(true) ;

console.log("screenWidth  = " + console.screenWidth + "\n") ;
console.log("screenHeight = " + console.screenHeight + "\n") ;
console.log("cursorX      = " + console.cursorX + "\n") ;
console.log("cursorY      = " + console.cursorY + "\n") ;

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


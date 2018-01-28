console.log("setup curses start\n") ;

console.visiblePrompt = false ;
console.doBuffering   = false ;
console.doEcho	      = false ;
console.setScreenMode(true) ;
console.setColor(Color.Yellow, Color.Blue) ;

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


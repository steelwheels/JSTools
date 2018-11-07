console.log("setup curses start\n") ;

Curses.mode(true) ;
Curses.put("Press \"q\" to quit\n") ;

let window = Curses.window(5, 5, 40, 20) ;
window.moveTo(1, 1) ;
window.put("Hello, world !!") ;

let docont = true ;
while(docont){
	let key = Curses.getKey() ;
	if(key != null){
		let c = String.fromCharCode(key) ;
		if(c == "q"){
			break ;
		} 
	}
}

window.put("Good bye") ;

Curses.mode(false) ;
console.log("Bye\n") ;


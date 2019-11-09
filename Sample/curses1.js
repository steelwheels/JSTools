console.log("setup curses start\n") ;

Curses.mode(true) ;
Curses.put("Press \"q\" to quit\n") ;


let docont = true ;
let x = 0 ;
let y = 0 ;
while(docont){
	let key = Curses.getKey() ;
	if(key != null){
		let c = String.fromCharCode(key) ;
		Curses.moveTo(x, y) ;
		Curses.put("Key : " + c + "\n") ;
		if(c == "q"){
			break ;
		} else {
			//x += 1 ;
			y += 1 ;
		}
	}
}

Curses.mode(false) ;
console.log("Bye") ;


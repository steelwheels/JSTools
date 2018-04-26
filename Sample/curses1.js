console.log("setup curses start\n") ;

var curses = require('curses') ;

curses.mode(true) ;
//curses.visiblePrompt = false ;
//curses.doBuffering   = false ;
//curses.doEcho	     = false ;

//curses.setColor(Color.Yellow, Color.Blue) ;

//curses.put("Press \"q\" to quit\n") ;


let docont = true ;
let x = 0 ;
let y = 0 ;
while(docont){
	let key = curses.getKey() ;
	if(key != null){
		let c = String.fromCharCode(key) ;
		curses.moveTo(x, y) ;
		curses.put("Key : " + c + "\n") ;
		if(c == "q"){
			break ;
		} else {
			x += 1 ;
			y += 1 ;
		}
	}
}

curses.mode(false) ;
console.log("Bye\n") ;


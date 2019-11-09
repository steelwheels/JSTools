console.log("setup curses start") ;

Curses.mode(true) ; // screen mode

const width  = Curses.screenWidth ;
const height = Curses.screenHeight ;
const orgx   = Curses.cursorX
const orgy   = Curses.cursorY

Curses.moveTo(0, 0) ; Curses.put("width  = " + width) ;
Curses.moveTo(0, 1) ; Curses.put("height = " + height) ;
Curses.moveTo(0, 2) ; Curses.put("orgx   = " + orgx) ;
Curses.moveTo(0, 3) ; Curses.put("orgy   = " + orgy) ;

//console.log("Press \"q\" to quit") ;

while(Curses.getKey() == null){
}

Curses.mode(false) ; // console mode

console.log("Bye") ;


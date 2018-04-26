var curses = require('curses') ;

console.log("setup curses start\n") ;

curses.mode(true) ;
curses.put("Hello, world\n") ;
curses.mode(false) ;

console.log("Good bye, world\n") ;


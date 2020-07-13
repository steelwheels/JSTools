
function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	Curses.moveTo(0, 0) ;
	Curses.put("a") ;

	Curses.moveTo(1, 0) ;
	Curses.put("b") ;

	Curses.moveTo(0, 1) ;
	Curses.put("c") ;

	/* Wait any key is pressed */
	while(Curses.inkey() == null){
		sleep(0.1) ;
	}

	Curses.end() ;

	return 0 ;
}



function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	Curses.moveTo(10, 10) ;
	console.log("Hello, world !!");

	sleep(2) ;
	Curses.end() ;

	return 0 ;
}




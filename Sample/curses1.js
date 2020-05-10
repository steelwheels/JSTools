
function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	Curses.end() ;

	let cols  = Curses.columns ;
	let lines = Curses.lines ;
	console.log("cols=" + cols + ", lines=" + lines + "\n") ;

	return 0 ;
}




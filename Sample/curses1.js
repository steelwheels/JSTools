
function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	Curses.end() ;

	let width  = Curses.width ;
	let height = Curses.height ;
	console.log("width=" + width + ", height=" + height + "\n") ;

	return 0 ;
}


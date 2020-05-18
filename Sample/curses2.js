
function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	let width  = Curses.width ;
	let height = Curses.height ;

	Curses.moveTo(10, 10) ;
	console.log("Hello, world !!: " + width + "x" + height);

	Curses.moveTo(12, 12) ;
	console.log("Press any key\n") ;

	while(true){
		let c = stdin.getc() ;
		if(c != null){
			break ;
		}
	}

	Curses.end() ;

	return 0 ;
}


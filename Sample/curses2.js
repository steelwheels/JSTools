
function main()
{
	console.log("setup curses start\n") ;

	Curses.start() ;

	let width  = Curses.width ;
	let height = Curses.height ;

	Curses.moveTo(10, 10) ;
	console.print("Hello, world !!: " + width + "x" + height);

	Curses.moveTo(12, 12) ;
	console.print("Press any key") ;

	while(true){
		let c = stdin.getc() ;
		if(c != null){
			break ;
		}
	}

	Curses.end() ;

	return 0 ;
}


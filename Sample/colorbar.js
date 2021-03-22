
function main()
{
	Curses.start() ;

	const width  = Curses.width ;
	const height = Curses.height ;
	const colnum = EscapeCode.maxColor - EscapeCode.minColor + 1 ;
	const diff   = width / colnum ;

	let   xpos  = 0 ;
	for(let col=EscapeCode.minColor ; col<=EscapeCode.maxColor ; col++){
		Curses.foregroundColor = Color.white
		Curses.backgroundColor = col ;

		Curses.fill(xpos, 0, diff, height, " ") ;
		xpos += diff ;
	}

	while(Curses.inkey() == null){
		sleep(0.1) ;
	}

	Curses.end() ;

	return 0 ;
}


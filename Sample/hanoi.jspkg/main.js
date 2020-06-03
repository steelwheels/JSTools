
function main(args)
{
	console.print("Hello, world !!\n") ;

	Curses.start() ;
		let tower0 = new Tower(3, 3, 0) ;
		let tower1 = new Tower(3, 3, 1) ;
		let tower2 = new Tower(3, 3, 2) ;

		tower0.draw() ;
		tower1.draw() ;
		tower2.draw() ;

		sleep(3) ;
	Curses.end() ;
}


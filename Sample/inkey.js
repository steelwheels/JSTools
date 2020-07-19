
function main(args)
{
	let docont = true ;

	Curses.start() ;
	while(docont){
		let c = Curses.inkey() ;
		if(c != null){
			switch(c){
			  case "q":
				docont = false ;
			  break ;
			  default:
				console.print(c) ;
			  break ;
			}
		}
	}
	Curses.end() ;
}


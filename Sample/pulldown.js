
function main(args)
{
	console.print("1.") ;

	let save = EscapeCode.saveCursorPosition() ;
	console.print(save) ;

	for(let i=0 ; i<5 ; i++){
		let sup = EscapeCode.scrollUp(1) ;
		console.print(sup) ;

		let nln = EscapeCode.cursorNextLine(1) ;
		console.print(nln) ;

		console.print("2." + i) ;
	}

	sleep(2.0) ;

	let sdn = EscapeCode.scrollDown(5) ;
	console.print(sdn) ;

	let restore = EscapeCode.restoreCursorPosition() ;
	console.print(restore) ;

	console.print("3.") ;

	console.print("\n") ;
	return 0 ;
}


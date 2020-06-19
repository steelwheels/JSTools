
function main(args)
{
	for(let i=0 ; i<10 ; i++){
		console.print(i + "\n") ;
	}
	sleep(2) ;

	let scrup = EscapeCode.scrollUp(5) ;
	console.print(scrup) ;
	console.print("-\n") ;
	sleep(2) ;

	let scrdown = EscapeCode.scrollDown(5) ;
	console.print(scrdown) ;
	console.print("+\n") ;
	sleep(2) ;

	return 0 ;
}


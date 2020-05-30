
function main(args)
{
	console.print("This is main function\n") ;
	console.print(" call lib_a from main ... ") ; lib_a() ;
	console.print(" call lib_b from main ... ") ; lib_b() ;

	console.print(" run thread_a by main ... ") ;
	let thread_a = Thread("thread_a", stdin, stdout, stderr) ;
	thread_a.start([]) ;
	thread_a.waitUntilExit() ;

	console.print(" run thread_b by main ... ") ;
	let thread_b = Thread("thread_b", stdin, stdout, stderr) ;
	thread_b.start([]) ;
	thread_b.waitUntilExit() ;

	return 0 ;
}


function main(args)
{
	console.log("Hello from main function") ;

	let thread0 = Thread("thread0", stdin, stdout, stderr) ;
	let result  = -1 ;
	if(thread0 != null){
		console.log("start: thread0") ;
		thread0.start(["a", "b"]) ;
		console.log("start: wait until exit") ;
		let ecode = thread0.waitUntilExit() ;
		console.log("exit code = " + ecode) ;
		result = ecode ;
	} else {
		console.log("start: FAILED") ;
		console.error("Failed to allocate thread\n") ;
	}
	return result ;
}


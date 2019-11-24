function main(args)
{
	console.log("Hello from main function") ;

	let thread0 = Thread("thread0", stdin, stdout, stderr) ;
	if(thread0 != null){
		thread0.start(["a", "b"]) ;
		let ecode = thread0.waitUntilExit() ;
		console.log("exit code = " + ecode) ;
	} else {
		console.log("thread = nil") ;
		console.error("Failed to allocate thread\n") ;
	}
}


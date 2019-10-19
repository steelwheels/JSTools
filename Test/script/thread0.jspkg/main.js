function main(args)
{
	console.log("Hello from main function\n") ;

	let thread = Thread("thread0", stdin, stdout, stderr) ;
	thread.start(["a", "b"]) ;
	let ecode = thread.waitUntilExit() ;
	console.log("exit code = " + ecode + "\n") ;
}


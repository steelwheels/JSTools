function main(args)
{
	console.log("Hello from main function\n") ;

	let thread = Thread("thread0", stdin, stdout, stderr) ;
	thread.start(["a", "b"]) ;
	thread.waitUntilExit() ;
	let ecode = thread.exitCode() ;
	console.log("exit code = " + ecode + "\n") ;
}


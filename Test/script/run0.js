function main(args)
{
	console.log("main-func (b)") ;

	let proc = run("../Test/script/run0-func.js", stdin, stdout, stderr) ;
	proc.start(["a", "b"]) ;
	proc.waitUntilExit() ;

	console.log("main-func (e)") ;
}


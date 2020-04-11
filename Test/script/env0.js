
function main(args)
{
	let pwd = Environment.get("PWD") ;
	console.log("pwd is string => " + isString(pwd)) ;

	Environment.set("A", "1234") ;
	console.log("A = " + Environment.get("A")) ;

	let curdir = Environment.currentDirectory ;
	console.log("curdir is URL: " + isURL(curdir)) ;

	let tmpdir = Environment.temporaryDirectory ;
	console.log("tmpdir is URL: " + isURL(tmpdir)) ;

	return 0 ;
}


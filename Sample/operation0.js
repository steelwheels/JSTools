/*
 * operation0.js
 */

function main()
{
	let op0 = Operation() ;

	let prog0 = "console.log(\"[op0] program\\n\") ;" ;
	let main0 = "console.log(\"[op0] main\\n\") ;" ;
	if(!op0.compile(prog0, main0)){
		console.log("[Error] Could not compile op0\n") ;
		return false ;
	}

	let queue0 = OperationQueue() ;
	if(!queue0.execute(op0, null)){
		console.log("[Error] Could not execute op0\n") ;
		return false ;
	}
	queue0.waitOperations() ;

	return true ;
}

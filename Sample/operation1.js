/*
 * operation0.js
 */

function main()
{
	let op0   = Operation() ;
	let prog0 = "console.log(\"[op0] program\\n\") ;" ;
	let main0 = "function(){ console.log(\"[opX] main\\n\") ; }" ;
	if(!op0.compile(prog0, main0)){
		console.log("[Error] Could not compile op0\n") ;
		return false ;
	}

	let op1   = Operation() ;
	let prog1 = "console.log(\"[op1] program\\n\") ;" ;
	let main1 = "function(){ console.log(\"[opX] main\\n\") ; }" ;
	if(!op1.compile(prog1, main1)){
		console.log("[Error] Could not compile op1\n") ;
		return false ;
	}

	let queue = OperationQueue() ;
	if(queue.execute(op0, null)){
		console.log("[op0] start\n")
	} else {
		console.log("[Error] Could not execute op0\n") ;
		return false ;
	}
	if(queue.execute(op1, null)){
		console.log("[op1] start\n")
	} else {
		console.log("[Error] Could not execute op1\n") ;
		return false ;
	}

	console.log("[opX] [begin] wait operations\n") ;
	queue.waitOperations() ;
	console.log("[opX] [end  ] wait operations\n") ;

	return true ;
}

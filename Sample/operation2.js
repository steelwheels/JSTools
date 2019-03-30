/*
 * operation0.js
 */

function main()
{
	let op0    = Operation(null) ;
	op0.input  = {a:10, b:20} ;
	let prog0  = "console.log(\"[op0] program\\n\") ;" ;
	let main0  = "function(){\n" +
						   " Operation.output = Operation.input.a + Operation.input.b ;\n" +
							 " console.log(\"[op0] exec\\n\") ;\n" +
							 "}" ;
	if(!op0.compile(prog0, main0)){
		console.log("[Error] Could not compile op0\n") ;
		return false ;
	}

	let op1   = Operation() ;
	op1.input  = {a:30, b:40} ;
	let prog1  = "console.log(\"[op1] program\\n\") ;" ;
	let main1  = "function(){\n" +
						   " Operation.output = Operation.input.a + Operation.input.b ;\n" +
							 " console.log(\"[op1] exec\\n\") ;\n" +
							 "}" ;
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

	let result0 = op0.output ;
	let result1 = op1.output ;
	console.log("[Output] result0 = " + result0 + ", result1 = " + result1 + "\n") ;

	return true ;
}

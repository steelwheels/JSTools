/*
 * operation0.js
 */

function allocateOperation(opfile, a, b, c)
{
	let url = URL(opfile) ;
	let op  = Operation([url], console) ;
	op.set("a", a) ;
	op.set("b", b) ;
	op.set("c", c) ;
	return op ;
}

function main()
{
	let op0 = allocateOperation("../Test/Script/Operation/op1.js", 1, 2, 3) ;
	let op1 = allocateOperation("../Test/Script/Operation/op1.js", 3, 4, 7) ;

	let queue0 = OperationQueue() ;
	if(!queue0.execute(op0)){
		console.error("[Error] Could not execute op0\n") ;
		return false ;
	}
	if(!queue0.execute(op1)){
		console.error("[Error] Could not execute op1\n") ;
		return false ;
	}
	queue0.waitOperations() ;

	return true ;
}

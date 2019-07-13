/*
 * operation0.js
 */

function main(args)
{
	let opfile = null ;
	if(isArray(args) && args.length == 1) {
		opfile = args[0] ;
		console.log("input script: " + opfile + "\n") ;
	} else {
		console.error("Invalid parameter\n") ;
		console.dump(args) ;
		return false
	}

	let url0 = URL(opfile) ;
	let op0  = Operation([url0], console) ;
	if(!checkVariables("check op", op0)){
		return false ;
	}

	let queue0 = OperationQueue() ;
	if(!queue0.execute(op0)){
		console.log("[Error] Could not execute op0\n") ;
		return false ;
	}
	queue0.waitOperations() ;

	return true ;
}

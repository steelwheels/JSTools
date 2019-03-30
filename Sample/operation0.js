/*
 * operation0.js
 */

function main()
{
	let op0 = Operation() ;

	const prog =
	  "class Task extends Operation {\n" +
		"  constructor(){\n" +
		"    super() ;\n" +
		"    console.log(\"* Hello from constructor\\n\"); \n" +
		"  }\n" +
		"  main(){\n" +
		"    console.log(\"* Hello from main\\n\"); \n" +
		"  }\n" +
		"}\n" +
		"console.log(\"Define operation object\\n\") ;\n" +
		"operation = new Task() ;\n" +
		"console.log(\"End of operation object\\n\") ;\n" ;

	//console.log("PROGRAM: " + prog + "\n") ;

	if(!op0.compile(prog)){
		console.log("[Error] Could not compile op0\n") ;
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

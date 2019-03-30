/*
 * operation0.js
 */

function main()
{
	const prog =
	  "class Task extends Operation {\n" +
		"  constructor(){\n" +
		"    super() ;\n" +
		"    console.log(\"* Hello from constructor\\n\"); \n" +
		"    this.name = \"Unknown\" ;\n" +
		"  }\n" +
		"  set(name, value){\n" +
		"     this.name = value ; \n" +
		"  }" +
		"  main(){\n" +
		"    console.log(\"* Hello from main\\n\"); \n" +
		"  }\n" +
		"}\n" +
		"operation = new Task() ;\n" ;

	let op0   = Operation() ;
	if(!op0.compile(prog)){
		console.log("[Error] Could not compile op0\n") ;
		return false ;
	}
	op0.set(0, "op0") ;

	let op1   = Operation() ;
	if(!op1.compile(prog)){
		console.log("[Error] Could not compile op1\n") ;
		return false ;
	}
	op1.set(0, "op1") ;

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

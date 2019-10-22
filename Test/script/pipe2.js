/**
 * pipe2.js
 */

/**
 * Allocate Pipe objects to connect data stream
 */
let pipe0 = Pipe() ;
let pipe1 = Pipe() ;

/**
 * Execute "cat" command to copy input into output
 *   - The pipe0 object is connected with input
 *   - The pipe1 object is connected with output
 */
console.log("[allocate process]\n") ;
let process = system("/bin/cat", pipe0, pipe1, stderr) ;
if(process == null){
	console.log("[Error] Could not launch command\n") ;
	exit(1) ;
}

/*
 * send input data into pipe0 
 */
console.log("[send input]\n") ;
pipe0.writing.put("Input from JavaScript !!\n") ;
pipe0.writing.close() ;

/*
 * Wait the cat process finished
 */
process.waitUntilExit() ;

/*
 * receive output data from pipe1
 */
console.log("[receive output]\n") ;
let c = pipe1.reading.getc() ;
while(c != null){
	console.log(`[receive] ${c}\n`) ;
	c = pipe1.reading.getc() ;
}

console.log("[bye]\n");


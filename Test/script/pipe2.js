/**
 * pipe1.js
 */

let pipe0 = Pipe() ;
let pipe1 = Pipe() ;

console.log("[allocate process]\n") ;
let process = system("/bin/cat", pipe0.reading, pipe1.writing, stderr) ;

if(process == null){
	console.log("[Error] Could not launch command\n") ;
	exit(1) ;
}

/* send input */
console.log("[send input]\n") ;
pipe0.writing.put("Input from JavaScript !!\n") ;
pipe0.writing.close() ;

/* receive output */
console.log("[receive output]\n") ;
let c = pipe1.reading.getc() ;
while(c != null){
	console.log(`[receive] ${c}\n`) ;
	c = pipe1.reading.getc() ;
}

process.waitUntilExit() ;

console.log("[bye]\n");


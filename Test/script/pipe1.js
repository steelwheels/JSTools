/**
 * pipe1.js
 */

let pipe = Pipe() ;

console.log("[allocate process]") ;
let process = system("/bin/echo \"Hello, world !!\"",
					stdin, pipe, stderr) ;

if(process == null){
	console.error("[Error] Could not launch command\n") ;
	exit(1) ;
}

console.log("Wait until exit ... begin") ;
process.waitUntilExit() ;
console.log("Wait until exit ... done") ;

/* receive output */
console.log("Receive output... begin") ;
let reader = pipe.reading ;
let c = reader.getc() ;
while(c != null){
	console.log(`[receive] ${c}`) ;
	c = reader.getc() ;
}
console.log("Receive output... done") ;

console.log("[bye]");


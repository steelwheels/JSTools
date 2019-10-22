/**
 * pipe1.js
 */

let pipe = Pipe() ;

console.log("[allocate process]\n") ;
let process = system("/bin/echo \"Hello, world !!\"",
					stdin, pipe, stderr) ;

if(process == null){
	console.log("[Error] Could not launch command\n") ;
	exit(1) ;
}

console.log("Wait until exit ... begin\n") ;
process.waitUntilExit() ;
console.log("Wait until exit ... done\n") ;

/* receive output */
console.log("Receive output... begin\n") ;
let reader = pipe.reading ;
let c = reader.getc() ;
while(c != null){
	console.log(`[receive] ${c}\n`) ;
	c = reader.getc() ;
}
console.log("Receive output... done\n") ;

console.log("[bye]\n");


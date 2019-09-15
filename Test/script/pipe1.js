/**
 * pipe1.js
 */

let pipe = Pipe() ;

console.log("[allocate process]\n") ;
let process = system("/bin/echo \"Hello, world !!\"",
					stdin, pipe.writing, stderr) ;

if(process == null){
	console.log("[Error] Could not launch command\n") ;
	exit(1) ;
}

console.log("Wait until exit\n") ;
process.waitUntilExit() ;

//console.log("Close write pipe\n") ;
//pipe.writing.close() ;

/* receive output */
let reader = pipe.reading ;
//console.log("[receive output] " + reader + "\n") ;
let c = reader.getc() ;
while(c != null){
	console.log(`[receive] ${c}\n`) ;
	c = reader.getc() ;
}

console.log("[bye]\n");


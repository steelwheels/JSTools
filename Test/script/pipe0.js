/**
 * pipe0.js
 */

let pipe = Pipe() ;

let process = system("/bin/cat", pipe.reading, stdout, stderr) ;

if(process != null){
	pipe.writing.put("Hello, world !!\n") ;
	pipe.writing.close() ;

	process.waitUntilExit() ;
} else {
	console.log("[Error] Could not launch command\n") ;
}

console.log("[bye]\n");


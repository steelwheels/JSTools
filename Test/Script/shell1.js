//let lscmd = Shell.searchCommand("ls") ;
//console.log("ls command = " + lscmd + "\n") ;

console.log("exec echo command = ") ;
let process = system("echo \"Hello, world !!\"", function(proc){
	console.log("Process done\n") ;
}) ;
if(process != null){
	process.waitUntilExit() ;
} else {
	console.print("[Error] Failed to allocate process\n") ;
}
console.log("[Bye]\n") ;


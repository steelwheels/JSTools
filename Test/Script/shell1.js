//let lscmd = Shell.searchCommand("ls") ;
//console.log("ls command = " + lscmd + "\n") ;

console.log("exec echo command = ") ;
let process = system("echo \"Hello, world !!\"", null) ;
process.waitUntilExit() ;


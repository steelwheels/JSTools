let lscmd = Shell.searchCommand("ls") ;
console.log("ls command = " + lscmd + "\n") ;

console.log("exec echo command = ") ;
let process = Shell.execute("echo \"Hello, world !!\"", null, null, null) ;
process.waitUntilExit() ;



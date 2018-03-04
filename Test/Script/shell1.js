let shell = require('shell') ;
let lscmd = shell.searchCommand("ls") ;
console.log("ls command = " + lscmd + "\n") ;
console.log("exec echo command = ") ;

let process = shell.execute("echo \"Hello, world !!\"", null, null, null) ;
process.waitUntilExit() ;



let shell = require('shell') ;

let pipe  = Pipe.open() ;
console.log("pipe input=" + pipe.input + ", output=" + pipe.output + "\n");

let sh = shell.execute("echo \"Hello, world !!\"", null, pipe, stderr);
let wc = shell.execute("wc -c", pipe, stdout, stderr);

sh.waitUntilExit() ;
wc.waitUntilExit() ;


let pipe = Pipe.open() ;

let sh = Shell.execute("/bin/echo -n \"hello\"", null, pipe, null);
let wc = Shell.execute("/usr/bin/wc -c", pipe, null, null);

sh.waitUntilExit() ;
wc.waitUntilExit() ;


/* pipe3.jsh */

let pipe = Pipe() ;
let infp = pipe.reading ;

/* Send input */
pipe.writing.put("Hello, world !!\n") ;
pipe.writing.close() ;

/* Execute thread */
(infp, stdout, stderr) > tr [a-z] [A-Z]


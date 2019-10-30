/* pipe3.jsh */

let outpipe = Pipe() ;
> echo "Hello, world !!" | tr [a-z] [A-Z] > @outpipe

let file = outpipe.reading ;

let line = file.getl() ;
while(line != null){
	stdout.put(line) ;
	line = file.getl() ;
}


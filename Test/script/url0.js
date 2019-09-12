
const url0 = URL("/bin/ls") ;
if(isNull(url0)){
	console.print("url0 = <null>\n") ;
} else if(isUndefined(url0)){
	console.print("url0 = <undefined>\n") ;
} else {
	console.print("url0 = " + url0.absoluteString + "; \n") ;
}


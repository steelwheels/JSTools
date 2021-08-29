
function json0(){
 	var data = JSON.read(stdin) ;
	console.log("a = " + data.a) ;
	console.log(data) ;

	data.a += 1 ;
	data.c =  0xff ;

	var res = JSON.write(stdout, data) ;
	if(res != 0){
		console.error("Failed to write JSON: " + res + "\n") ;
	}
}

json0()

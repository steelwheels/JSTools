/*
 * math0.js
 */

console.log("Test: randomInt ... ") ;

let result = true ;
for(let i=0 ; i<11 ; i++){
	const v = Math.randomInt(0, 10) ;
	if(!(0<=v && v<=10)){
		result = false ;
	}
}

if(result){
	console.log("OK\n") ;
	exit(0) ;
} else {
	console.log("NG\n") ;
	exit(1) ;
}


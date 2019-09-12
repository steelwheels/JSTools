/*
 * math0.js
 */

let result = true ;

console.log("Test: RandomInt\n") ;
for(let i=0 ; i<11 ; i++){
	const v = Math.randomInt(0, 10) ;
	if(!(0<=v && v<=10)){
		result = false ;
	}
}

console.log("Test: Math\n") ;
console.log(" PI = " + PI + "\n") ;

for(let i=0 ; i<=8 ; i++){
	let angle = (PI / 8.0) * i ;
	console.log("sin(" + angle.toFixed(2) + ") = " + sin(angle).toFixed(2) + "\n") ;
	console.log("cos(" + angle.toFixed(2) + ") = " + cos(angle).toFixed(2) + "\n") ;
	console.log("tan(" + angle.toFixed(2) + ") = " + tan(angle).toFixed(2) + "\n") ;
}

if(result){
	console.log("OK\n") ;
	exit(0) ;
} else {
	console.log("NG\n") ;
	exit(1) ;
}

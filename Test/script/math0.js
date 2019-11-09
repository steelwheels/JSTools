/*
 * math0.js
 */

let result = true ;

console.log("Test: RandomInt") ;
for(let i=0 ; i<11 ; i++){
	const v = Math.randomInt(0, 10) ;
	if(!(0<=v && v<=10)){
		result = false ;
	}
}

console.log("Test: Math") ;
console.log(" PI = " + PI) ;

for(let i=0 ; i<=8 ; i++){
	let angle = (PI / 8.0) * i ;
	console.log("sin(" + angle.toFixed(2) + ") = " + sin(angle).toFixed(2));
	console.log("cos(" + angle.toFixed(2) + ") = " + cos(angle).toFixed(2));
	console.log("tan(" + angle.toFixed(2) + ") = " + tan(angle).toFixed(2));
}

if(result){
	console.log("OK") ;
	exit(0) ;
} else {
	console.log("NG") ;
	exit(1) ;
}


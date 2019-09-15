/*
 * thread0.js
 */

console.log("start\n") ;
let t0 = thread(function() {
	console.log("Message from thread\n") ;
	return 0 ;
}) ;
//console.log("thread: " + t0 + "\n") ;
t0.waitUntilExit() ;
console.log("bye\n") ;


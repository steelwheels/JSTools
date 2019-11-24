/* process0.js */
let proc0  = system("/bin/ls", stdin, stdout, stderr) ;

if(false){
	let ecode0 = proc0.waitUntilExit() ;
	console.log("ecode = " + ecode0) ;
} else {
	let ecode0 = _waitUntilExitAll([proc0]) ;
	console.log("ecode = " + ecode0) ;
}


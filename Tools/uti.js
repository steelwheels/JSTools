/*
 * uti.js
 */

function main(arguments) {
	for (let arg of arguments){
		if(isString(arg)){
			var uti = FileManager.uti(arg) ;
			if(isString(uti)){
				console.log(uti + "\n") ;
			} else {
				console.error("[Error] Can not get uti: "
				  + arg + "\n") ;
			}
		} else {
			console.error("[Error] Invald parameter for file name: "
				+ arg + "\n") ;
		}
	}
}


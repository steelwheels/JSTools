/* rsync.js */

const JSON = require("JSON") ;

function main(arguments)
{
	/* Get config file name */
	let conffile = "" ;
	if(arguments.length == 1){
		conffile = arguments[0] ;
	} else {
		console.log("[Error] Invalid number of arguments\n") ;
		Process.exit(1) ;
	}

	/* Read config file */
	const config = JSON.read(conffile) ;
	if(config == null) {
		console.log("Failed to read \"" + conffile + "\"\n") ;
		Process.exit(1) ;
	}

	const srcdir = config.source_directory ;
	console.log("srcdir = " + srcdir + "\n") ;
}


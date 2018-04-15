/* rsync.js */

const JSON  = require("JSON") ;
const shell = require("shell") ;

function main(arguments)
{
	/* Parse arguments */
	const config = parse(arguments) ;
	if(isNull(config)){
		return 1 ;
	}
  /* Encode to command line */
	const cmdline = encode(config) ;
	/* Execute the command */
	if(config.dry_run){
		console.log(cmdline + "\n") ;
	} else {
		let process = shell.execute(cmdline, stdin, stdout, stderr) ;
		process.waitUntilExit() ;
	}
	return 0 ;
}

function parse(arguments)
{
	/* Get config file name */
	let conffile = "" ;
	if(arguments.length == 1){
		conffile = arguments[0] ;
	} else {
		console.error("[Error] Invalid number of arguments.\n") ;
		return null ;
	}

	/* Read config file */
	const config = JSON.read(conffile) ;
	if(config == null) {
		console.error("[Error] Failed to read \"" + conffile + "\".\n") ;
		return null ;
	}

	/* Check source_directory */
	const srcdir = config.source_directory ;
	if(isUndefined(srcdir)){
		console.error("[Error] \"source_directory\" property must be defined.\n") ;
		return null ;
	} else if(isString(srcdir)){
		if(File.checkFileType(srcdir) != File.type.Directory){
			console.error("[Error] \"source_directory\" property \"" + srcdir + "\" is NOT directory.\n") ;
			return null ;
		}
	} else {
		console.error("[Error] \"source_directory\" property must has string value.\n") ;
		return null ;
	}

	/* Check destination_directory */
	const dstdir = config.destination_directory ;
	if(isUndefined(dstdir)){
		console.error("[Error] \"destination_directory\" property must be defined.\n") ;
		return null ;
	} else if(isString(dstdir)){
		if(File.checkFileType(dstdir) != File.type.Directory){
			console.error("[Error] \"destination_directory\" property \"" + dstdir + "\" is NOT directory.\n") ;
			return null ;
		}
	} else {
		console.error("[Error] \"destination_directory\" property must has string value.\n") ;
		return null ;
	}

	/* check verbose_mode */
	const verbmode = config.verbose_mode ;
	if(isUndefined(verbmode)){
		config.verbose_mode = false ;
	} else if(!isBoolean(verbmode)){
		console.error("[Error] \"verbose_mode\" property must has boolean value.\n") ;
		return null ;
	}

	/* check dry_run */
	const dryrun = config.dry_run ;
	if(isUndefined(dryrun)){
		config.dry_run = false ;
	} else if(!isBoolean(dryrun)){
		console.error("[Error] \"dry_run\" property must has boolean value.\n") ;
		return null ;
	}
	return config ;
}

function encode(config)
{
	var cmdline = "/usr/bin/rsync -a" ;
	if(config.dry_run){
		cmdline += " --dry-run" ;
	}
	if(config.verbose_mode){
		cmdline += " --verbose" ;
	}
	cmdline += " " + config.source_directory ;
	cmdline += " " + config.destination_directory ;
	return cmdline ;
}

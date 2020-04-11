/*
 * fmgr0.js
 */

function main(args)
{
	let curdir   = Environment.currentDirectory ;
	let plisturl = FileManager.fullPath("./Info.plist", curdir) ;
	let result   = -1 ;
	if(plisturl != null){
		if(FileManager.isReadable(plisturl)){
			console.log("OK: Info.plist -> Readable") ;
			result = 0 ;
		} else {
			console.log("NG: Info.plist -> Readable") ;
		}
	} else {
		console.log("Failed to call \"fullPath\" method\n") ;
	}
	return result ;
}


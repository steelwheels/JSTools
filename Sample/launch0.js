
let apppath = "/System/Applications/TextEdit.app" ;
let docpath = null ;
let app = launch(apppath, docpath) ;
if(app != null){
	console.print("Wait until application finish .. ") ;
	app.waitUntilExit() ;
	console.print("done\n") ;
} else {
	console.printf("[Error] Failed to launch " + apppath + "\n") ;
}


/* cat1.js */

function cat(){
	var file = FileManager.open("../LICENSE", "r")
	if(file != null){
		var line
		console.log("*** File Start")
		while((line = file.getl()) != null){
			stdout.put(line)
		}
		console.log("*** File End")
	} else {
		console.error("Failed to open file\n")
	}
}

cat()
console.log("*** Bye")


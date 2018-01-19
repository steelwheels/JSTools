/* curses3.js */

function main()
{
	let maxlen = maxNameLength() + 1 ; // +1 for space

	console.setScreenMode(true) ; 

	let pos = 0 ;
	for(let fcol=Color.Min ; fcol<=Color.Max ; fcol++){
		console.moveTo(0, pos) ;
		let label = makeLabel(Color.description(fcol), maxlen) ;
		for(let bcol=Color.Min ; bcol<=Color.Max ; bcol++){
			console.foregroundColor = fcol ;
			console.backgroundColor = bcol ;
			console.log(label) ;
		}
		pos += 1 ;
	}

	/* Wait key press */
	while(console.getKey() == null){
	}
}

function maxNameLength()
{
	let maxlen = 0 ;
	for(let col=Color.Min ; col<=Color.Max ; col++){
		let name    = Color.description(col) ;
		let namelen = name.length ;
		if(namelen > maxlen){
			maxlen = namelen ;
		}
	}
	return maxlen ;
}

function makeLabel(name, maxlen)
{
	let padding = maxlen - name.length ;
	for(let i=0 ; i<padding ; i++){
		name += " " ;
	}
	return name ;
}

main()


/* curses3.js */

function main()
{
	let maxlen = maxNameLength() + 1 ; // +1 for space

	console.setScreenMode(true) ; 

	let vpos = (console.screenHeight - 8) / 2 ;
	let hpos = (console.screenWidth  - maxlen*8) / 2 ;
	for(let fcol=Color.Min ; fcol<=Color.Max ; fcol++){
		console.moveTo(hpos, vpos) ;
		let label = makeLabel(Color.description(fcol), maxlen) ;
		for(let bcol=Color.Min ; bcol<=Color.Max ; bcol++){
			console.foregroundColor = fcol ;
			console.backgroundColor = bcol ;
			console.log(label) ;
		}
		vpos += 1 ;
	}

	console.foregroundColor = Color.Black ;
	console.backgroundColor = Color.White ;
	centering( 2, "J S T o o l s") ;
	centering(22, "Press any key to quit") ;

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

function centering(vpos, label)
{
	let hpos = (console.screenWidth - label.length) / 2 ;
	console.moveTo(hpos, vpos) ;
	console.log(label) ;
}

main()


/* color_table.js */

var curses = require("curses") ;

function main()
{
	let maxlen = maxNameLength() + 1 ; // +1 for space

	curses.mode(true) ; 

	let vpos = (curses.screenHeight - 8) / 2 ;
	let hpos = (curses.screenWidth  - maxlen*8) / 2 ;

	const mincol = EscapeCode.minColor ;
	const maxcol = EscapeCode.maxColor ;

	for(let fcol=mincol ; fcol<=maxcol ; fcol++){
		curses.moveTo(hpos, vpos) ;
		let label = makeLabel(colorName(fcol), maxlen) ;
		for(let bcol=mincol ; bcol<=maxcol ; bcol++){
			curses.setColor(fcol, bcol) ;
			curses.put(label) ;
		}
		vpos += 1 ;
	}

	curses.setColor(Color.black, Color.white) ;
	centering( 2, "J S T o o l s") ;
	centering(22, "Press any key to quit") ;

	/* Wait key press */
	while(curses.getKey() == null){
	}

	/* Finish */
	curses.mode(false) ; 
}

function maxNameLength()
{
	const mincol = EscapeCode.minColor ;
	const maxcol = EscapeCode.maxColor ;

	let maxlen = 0 ;
	for(let col=mincol ; col<=maxcol ; col++){
		let name    = colorName(col) ;
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
	let hpos = (curses.screenWidth - label.length) / 2 ;
	curses.moveTo(hpos, vpos) ;
	curses.put(label) ;
}

function colorName(color) {
	var result = "unknown" ;
	switch (color) {
	  case Color.black:	result = "black" ;	break ;
	  case Color.red:	result = "red" ;	break ;
	  case Color.green:	result = "green" ;	break ;
	  case Color.yellow:	result = "yellow" ;	break ;
	  case Color.blue:	result = "blue" ;	break ;
	  case Color.magenta:	result = "magenta" ;	break ;
	  case Color.cyan:	result = "cyan" ;	break ;
	  case Color.white:	result = "white" ;	break ;
	  default:		result = "unknown" ;	break ;
	}
	return result ;
}

main()


/* color_table.js */

var curses = require("curses") ;

function main()
{
	let maxlen = maxNameLength() + 1 ; // +1 for space

	curses.mode(true) ; 

	let vpos = (curses.screenHeight - 8) / 2 ;
	let hpos = (curses.screenWidth  - maxlen*8) / 2 ;

	const mincol = Curses.minColor ;
	const maxcol = Curses.maxColor ;

	for(let fcol=mincol ; fcol<=maxcol ; fcol++){
		curses.moveTo(hpos, vpos) ;
		let label = makeLabel(colorName(fcol), maxlen) ;
		for(let bcol=mincol ; bcol<=maxcol ; bcol++){
			curses.setColor(fcol, bcol) ;
			curses.put(label) ;
		}
		vpos += 1 ;
	}

	curses.setColor(Curses.black, Curses.white) ;
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
	const mincol = Curses.minColor ;
	const maxcol = Curses.maxColor ;

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
	  case Curses.black:	result = "black" ;	break ;
	  case Curses.red:	result = "red" ;	break ;
	  case Curses.green:	result = "green" ;	break ;
	  case Curses.yellow:	result = "yellow" ;	break ;
	  case Curses.blue:	result = "blue" ;	break ;
	  case Curses.magenta:	result = "magenta" ;	break ;
	  case Curses.cyan:	result = "cyan" ;	break ;
	  case Curses.white:	result = "white" ;	break ;
	  default:		result = "unknown" ;	break ;
	}
	return result ;
}

main()


/* colors.js */

function main(args)
{
	for(let fg=Color.min ; fg<=Color.max ; fg++){
		for(let bg=Color.min ; bg<=Color.max ; bg++){
			let fname = colorName(fg) ;
			let bname = colorName(bg) ;
			let fesc  = EscapeCode.color(1, fg) ;
			let besc  = EscapeCode.color(0, bg) ;
			console.print(`${fesc}${besc}${fname}/${bname} `) ;
		}
	}
	console.print("\n") ;
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


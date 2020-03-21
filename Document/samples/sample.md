

# Samples

## Terminal control
### Color
Display colored messages on terminal.
[EscapeCode class](https://github.com/steelwheels/KiwiScript/blob/master/KiwiLibrary/Document/Class/EscapeCode.md) is used to generate escape code for coloring.

````

function main(args)
{
	for(var fg=Color.min ; fg<=Color.max ; fg++){
		for(var bg=Color.min ; bg<=Color.max ; bg++){
			let fgstr  = EscapeCode.color(1, fg) ;
			let bgstr  = EscapeCode.color(0, bg) ;
			let fgname = colorName(fg) ;
			let bgname = colorName(bg) ;
			console.print(fgstr + bgstr + fgname + "/" + bgname) ;
		}
		console.print("\n") ;
	}
	console.print(EscapeCode.reset()) ;
}

function colorName(code)
{
	let result = "?" ;
	switch(code){
	  case 0:	result = "black  " ;	break ;
	  case 1:	result = "red    " ;	break ;
	  case 2:	result = "green  " ;	break ;
	  case 3:	result = "yellow " ;	break ;
	  case 4:	result = "blue   " ;	break ;
	  case 5:	result = "magenta" ;	break ;
	  case 6:	result = "cyan   " ;	break ;
	  case 7:	result = "white  " ;	break ;
	}
	return result ;
}

````

### Key code
````

function main(args)
{
	let c     = "?" ;
	let prevc = "-" ;
	while(c != "q"){
		c = stdin.getc() ;
		if(c != null && c != prevc){
			let len = c.length ;
			for(let i=0 ; i<len ; i++){
				let code = c.charCodeAt(i) ;
				printCode(code) ;
			}
			prevc = c ;
		}
	}
	return 0 ;
}

function printCode(code)
{
	let name = asciiCodeName(code) ;
	if(name == null){
		name = "?" ;
	}
	let hexcode = "0x" + code.toString(16) ;
	stdout.put(name + ":" + hexcode + "\n") ;
}


````


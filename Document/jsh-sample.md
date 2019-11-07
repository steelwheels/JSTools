

# Sample scripts for JSH

## `keycode.js` : 
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
				stdout.put("c:" + c + " code:" + code + "\n") ;
			}
			prevc = c ;
		}
	}
	return 0 ;
}


````


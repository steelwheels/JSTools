
for(let i=0 ; i<10 ; i++){
	let m     = i % 2 ;
	let ecode = 0 ;
	> [ "${m}" = "0" ] -> ecode
	if(ecode == 0){
		console.log("even") ;
	} else {
		console.log("odd") ;
	}
}

/* Transpose.js */
function transpose () {
  /* Prepare array to store all lines */
  let rows = [] ;

  /* Read input file */
  let line   = "" ;
  let maxlen = 0 ;
  while((line = stdin.getl()) != null){
    let cols = [] ;
    let len  = line.length - 1 ; // remove last newline
    for(let i=0 ; i<len ; i++){
      let c = line.charAt(i) ;
      cols.push(c) ;
    }
    if(maxlen < len){
      maxlen = len ;
    }
    rows.push(cols) ;
  }

  /* Put translated lines */
  for(let i=maxlen-1 ; i>=0 ; i--){
    for(let r=0 ; r<rows.length ; r++){
      let cols = rows[r] ;
      //console.log("*** cols=" + cols.length + ":" + cols) ;
      if(i < cols.length){
        stdout.put(cols[i]) ;
      } else {
        stdout.put(" ") ;
      }
    }
    stdout.put("\n") ;
  }
}

transpose()
Process.exit(0)

/* Main.js */

function main()
{
  /* setup screen mode */
  console.setScreenMode(true) ;
  console.doBuffering = false ;

  const fields = [null, null]
  fields[0] = new Field(console.screenWidth, console.screenHeight) ;
  fields[1] = new Field(console.screenWidth, console.screenHeight) ;
  fields[0].randomize() ;
  fields[0].draw() ;

  let curidx = 0 ;

  /* Wait user press some key */
  while(console.getKey() != "q"){
    let nextidx = (curidx == 0) ? 1 : 0 ;
    fields[nextidx].update(fields[curidx]) ;
    fields[nextidx].draw() ;
    curidx = nextidx ;
  }
  console.setScreenMode(false) ;
  console.log("Finish program\n") ;
}

main() ;

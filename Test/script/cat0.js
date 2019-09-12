/* cat0.js */

function cat(){
  while(true){
    var c = stdin.getc() ;
    if(c == null){
      break ;
    } else {
      stdout.put(c)
    }
  }
}

cat()


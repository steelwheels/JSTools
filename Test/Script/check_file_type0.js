/* check_file_type0.js */

function main(arguments)
{
  if(arguments.length != 1){
    console.log("[Error] Invalid argument num") ;
    return 1 ;
  }
  const path = arguments[0] ;
  const type = FileManager.checkFileType(path) ;
  console.log("File: " + path + " -> Type: " + type + " -> ") ;

  var result = 1 ;
  if(type == FileManager.type.File){
    console.log("OK\n") ;
    result = 0 ;
  } else {
    console.log("NG\n") ;
    result = 1 ;
  }
  return result ;
}

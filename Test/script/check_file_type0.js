/* check_file_type0.js */

function main(arguments)
{
  if(arguments.length != 1){
    console.log("[Error] Invalid argument num") ;
    return 1 ;
  }
  const path = arguments[0] ;
  const type = FileManager.checkFileType(path) ;
  console.print("File: " + path + " -> Type: " + type + " -> ") ;

  var result = 1 ;
  if(type == FileType.file){
    console.log("OK") ;
    result = 0 ;
  } else {
    console.log("NG") ;
    result = 1 ;
  }
  return result ;
}


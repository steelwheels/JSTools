/* Field.js */

class Field
{
  /*
   * width    : Int
   * height   : Int
   */
  constructor(width, height){
    this.width  = width ;
    this.height = height ;
    let field = new Array(height) ;
    for(let i=0 ; i<height ; i++){
      field[i] = new Array(width).fill(false) ;
    }
    this.field = field
  }
} ;


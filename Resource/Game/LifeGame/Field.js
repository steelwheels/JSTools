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
    this.field = field ;
  }

  randomize(){
    const width  = this.width ;
    const height = this.height ;
    for(let y=0 ; y<height ; y++){
      for(let x=0 ; x<width ; x++){
        let value = false ;
        if(Math.random() > 0.667){
          value = true ;
        }
        this.field[y][x] = value ;
      }
    }
  }

  update(srcfield) {
    const arounds = [
      [-1, -1], [0, -1], [+1, -1],
      [-1,  0],          [+1,  0],
      [-1, +1], [0, +1], [+1, +1],
    ] ;
    const anum = arounds.length ;

    const width  = srcfield.width ;
    const height = srcfield.height ;
    for(let y=0 ; y<height ; y++){
      for(let x=0 ; x<width ; x++){
        let sum = 0 ;
        for(let i=0 ; i<anum ; i++){
          const ax = x + arounds[i][0] ;
          const ay = y + arounds[i][1] ;
          if(srcfield.get(ax, ay)){
            sum += 1 ;
          }
        }
        let alive = true ;
        if(this.get(x, y)){
          if(sum == 2 || sum == 3){
            alive = true ;
          } else if(sum <= 1 || 4 <= sum){
            alive = false ;
          } else {
            alive = true ;
          }
        } else {
          if(sum == 3){
            alive = true ;
          } else {
            alive = false ;
          }
        }
        this.put(x, y, alive)
      }
    }
  }

  get(x, y){
    if(0<=x && x<this.width && 0<=y && y<this.height){
      return this.field[y][x] ;
    } else {
      return false
    }
  }

  put(x, y, value){
    if(0<=x && x<this.width && 0<=y && y<this.height){
      this.field[y][x] = value ;
    }
  }

  draw(){
    const width  = this.width ;
    const height = this.height ;
    for(let y=0 ; y<height ; y++){
      for(let x=0 ; x<width ; x++){
        let sym = ' ' ;
        if(this.field[y][x]){
          sym = '*' ;
        }
        console.moveTo(x, y) ;
        console.log(sym) ;
      }
    }
  }
} ;

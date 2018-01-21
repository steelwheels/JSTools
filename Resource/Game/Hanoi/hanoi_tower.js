/*
 * @file hanoi_tower.js
 */

class HanoiTower
{
    constructor(towerid, maxheight) {
      this.tower_id   = towerid ;
      this.max_width  = maxheight * 2 ;
      this.max_height = maxheight ;
      this.disks      = [] ;
    }

    push_disk(disk) {
      this.disks.unshift(disk) ;
    }

    pop_disk(){
      return this.disks.shift() ;
    }

    draw(){
      for(let v=0 ; v<this.max_height ; v++){
        this.moveTo(0, v) ;

        let size  = (v < this.disks.length) ? this.disks[v] : 0 ;
        let color = this.selectColor(v) ;
        this.drawDisk(size, color) ;
      }
    }

    selectColor(v){
      if(v < this.disks.length){
        let result = Color.White
        switch(v){
          case 0: result = Color.Red ;    break ;
          case 1: result = Color.Blue ;   break ;
          case 2: result = Color.Yellow ; break ;
          case 3: result = Color.Green ;  break ;
          case 4: result = Color.Cyan ;   break ;
        }
        return result ;
      } else {
        return Color.Black ;
      }
    }

    moveTo(x, y){
      let newy = y + 5 ;
      console.moveTo(x, newy) ;
    }

    drawDisk(size, color){
      let leftnum  = (this.max_width - size) / 2 ;
      let rightnum = this.max_width - size - leftnum ;
      for(let h=0 ; h<leftnum ; h++){
        console.foregroundColor = Color.Black ;
        console.log(" ") ;
      }
      for(let h=0 ; h<size ; h++){
        console.foregroundColor = color ;
        console.log("#") ;
      }
      for(let h=0 ; h<rightnum ; h++){
        console.foregroundColor = Color.Black ;
        console.log(" ") ;
      }
    }
}

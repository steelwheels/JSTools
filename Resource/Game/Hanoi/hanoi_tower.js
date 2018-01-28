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
      this.disks.push(disk) ;
    }

    pop_disk(){
      return this.disks.pop() ;
    }

    draw(){
      for(let v=this.max_height-1 ; v>=0 ; v--){
        this.moveTo(0, v) ;

        let size  = (v < this.disks.length) ? this.disks[v] : 0 ;
        let color = this.selectColor(v, size) ;
        this.drawDisk(size, color) ;
      }
    }

    selectColor(v, size){
      if(v < this.disks.length){
        let result = Color.White
        switch(size){
          case 1: result = Color.Red ;    break ;
          case 3: result = Color.Blue ;   break ;
          case 5: result = Color.Yellow ; break ;
          case 7: result = Color.Green ;  break ;
          case 9: result = Color.Cyan ;   break ;
        }
        return result ;
      } else {
        return Color.Black ;
      }
    }

    moveTo(x, y){
      let newx = x + this.tower_id * this.max_width ;
      let newy = this.max_height - y ;
      console.moveTo(newx, newy) ;
    }

    drawDisk(size, color){
      let leftnum  = (this.max_width - size) / 2 ;
      let rightnum = this.max_width - size - leftnum ;
      for(let h=0 ; h<leftnum ; h++){
        console.log(" ") ;
      }
      for(let h=0 ; h<size ; h++){
        console.log("#") ;
      }
      for(let h=0 ; h<rightnum ; h++){
        console.log(" ") ;
      }
    }
}

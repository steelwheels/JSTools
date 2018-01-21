/*
 * @file hanoi_main.js
 */

 function main()
 {
   let maxheight = 4 ;

   console.setScreenMode(true) ;
   let tower0 = new HanoiTower(0, maxheight) ;
   tower0.push_disk(7) ;
   tower0.push_disk(5) ;
   tower0.push_disk(3) ;
   tower0.push_disk(1) ;
   tower0.draw() ;

   //console.moveTo(0, 20) ;
   console.log("Press any key")
   let key = "a" ;
   while((key = console.getKey()) == null) {

   }
 }

 main() ; /* start main function */

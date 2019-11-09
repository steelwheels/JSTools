/* op1.js */

class UTOperation1 extends Operation
{
        execute(){

		let a = this.parameter("a") ;
		let b = this.parameter("b") ;
		let c = this.parameter("c") ;
                if(a + b == c){
                        console.log("Hello from UTOperation1 ... OK") ;
                } else {
                        console.log("Hello from UTOperation1 ... NG") ;
                }
        }
}

operation = new UTOperation1() ;

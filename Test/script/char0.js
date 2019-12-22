let left1 = EscapeCode.cursorBackward(1) ;

console.log("--- Test: Left") ;
console.log("ABC" + left1			) ;
console.log("ABC" + left1 + " "			) ;
console.log("ABC" + left1 + left1		) ;
console.log("ABC" + left1 + left1 + " "		) ;

console.log("--- Test: BS") ;
console.log("ABC" + Char.BS			) ;
console.log("ABC" + Char.BS + " "		) ;
console.log("ABC" + left1 + Char.BS		) ;
console.log("ABC" + left1 + Char.BS + " "	) ;

console.log("--- Test: DEL") ;
console.log("ABC" + Char.DEL			) ;
console.log("ABC" + Char.DEL + " "		) ;
console.log("ABC" + left1 + Char.DEL		) ;
console.log("ABC" + left1 + Char.DEL + " "	) ;


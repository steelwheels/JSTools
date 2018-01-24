/*
 * Graphics/Primitives.js
 */

module = {}

module.exports = {
	Point : class {
		/* x: 		Number
		 * y: 		Number
		 */
		constructor(x, y){
			this.x = x ;
			this.y = y ;
		}

		clone(){
			return Object.assign({}, this);
		}
	},

	Size : class {
		/* width: 	Number
		 * height:	Number
		 */
		constructor(width, height){
			this.width  = width ;
			this.height = height ;
		}

		clone(){
			return Object.assign({}, this);
		}
	},

	Rect : class {
		/* origin:	Point
		 * size:	Size
		 */
		constructor(origin, size){
			this.origin = origin ;
			this.size   = size ;
		}

		clone(){
			const newobj = Object.assign({}, this);
			newobj.origin = this.origin.clone() ;
			newobj.size   = this.size.clone() ;
			return newobj
		}
	},

	View : class {
		/* frame:	    Rect
		 * foregroundColor: Int32 (See Color built-in class)
		 * backgroundColor: Int32 (See Color built-in class)
		 */
		constructor(frame){
			this.frame	      = frame ;
			this.foregroundColor  = Color.White ;
			this.backgroundColor  = Color.Black ;
		}

		clone(){
			const newobj = Object.assign({}, this);
			newobj.frame = this.frame.clone() ;
			return newobj ;
		}
	}
} ;


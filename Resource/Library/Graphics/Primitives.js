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

		alignStringToLeft(width, label){
			var result = "" ;
			if(label != null){
				result = label ;
				const len = label.length ;
				if(len < width){
					let right = width - len ;
					for(let i=0 ; i<right ; i++){
						result = result + " " ;
					}
				}
			} else {
				for(let i=0 ; i<width ; i++){
					result = result + " " ;
				}
			}
			return result ;
		}

		alignStringToRight(width, label){
			var result = "" ;
			if(label != null){
				result = label ;
				const len = label.length ;
				if(len < width){
					let left = width - len ;
					for(let i=0 ; i<left ; i++){
						result = " " + result ;
					}
				}
			} else {
				for(let i=0 ; i<width ; i++){
					result = result + " " ;
				}
			}
			return result ;
		}

		alignStringToCenter(width, label){
			var result = "" ;
			if(label != null){
				result = label ;
				const len = label.length ;
				if(len < width){
					const left  = Math.floor((width - len) / 2) ;
					const right = width - len - left ;
					for(let i=0 ; i<left ; i++){
						result = " " + result ;
					}
					for(let i=0 ; i<right ; i++){
						result = result + " " ;
					}
				}
			} else {
				for(let i=0 ; i<width ; i++){
					result = result + " " ;
				}
			}
			return result ;
		}

		alignString(width, label, align){
			var result = "" ;
			switch(align){
				case Align.Center:
					result = alignStringCenter(width, label) ;
				break ;
				case Align.Left:
					result = alignStringLeft(width, label) ;
				break ;
				case Align.Right:
					result = alignStringLeft(width, label) ;
				break ;
			}
			return result
		}

		drawLine(x, y, width, align, label){
			console.moveTo(x, y) ;
		}
	}
} ;

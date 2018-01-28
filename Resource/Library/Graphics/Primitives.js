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
				const len = label.length ;
				if(len <= width){
					result = label ;
					let right = width - len ;
					for(let i=0 ; i<right ; i++){
						result = result + " " ;
					}
				} else {
					result = label.substr(0, width) ;
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
				const len = label.length ;
				if(len <= width){
					result = label ;
					let left = width - len ;
					for(let i=0 ; i<left ; i++){
						result = " " + result ;
					}
				} else {
					result = label.substr(0, width) ;
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
				const len = label.length ;
				if(len <= width){
					result = label ;
					const left  = Math.floor((width - len) / 2) ;
					const right = width - len - left ;
					for(let i=0 ; i<left ; i++){
						result = " " + result ;
					}
					for(let i=0 ; i<right ; i++){
						result = result + " " ;
					}
				} else {
					result = label.substr(0, width) ;
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
					result = this.alignStringToCenter(width, label) ;
				break ;
				case Align.Left:
					result = this.alignStringToLeft(width, label) ;
				break ;
				case Align.Right:
					result = this.alignStringToLeft(width, label) ;
				break ;
			}
			return result
		}

		drawLine(x, y, width, label, align){
			/* get and adjust: x and width */
			const xabs     = this.frame.origin.x + x ;
			const maxwidth = console.screenWidth ;
			if(xabs < maxwidth){
				const xdiff = maxwidth - xabs ;
				width       = Math.min(width, xdiff) ;
			} else {
				return ; // can not draw
			}

			/* get and adjust: y */
			const yabs      = this.frame.origin.y + y ;
			const maxheight = console.screenHeight
			if(yabs >= maxheight){
				return ; // can not draw
			}

			/* draw label */
			console.moveTo(xabs, yabs) ;
			console.setColor(this.foregroundColor, this.backgroundColor) ;
			const labstr = this.alignString(width, label, align) ;
			console.log(labstr) ;
		}

		drawRect(x, y, width, height, label, align){
			const middle = Math.floor(height / 2) ;
			for(let h=0 ; h<middle ; h++){
				this.drawLine(x, y+h, width, null, align) ;
			}
			this.drawLine(x, y+middle, width, label, align) ;
			for(let h=middle+1 ; h<height ; h++){
				this.drawLine(x, y+h, width, null, align) ;
			}
		}
	}
} ;

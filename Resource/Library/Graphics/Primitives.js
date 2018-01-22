/*
 * Graphics/Primitives.js
 */

module = {}

module.exports = {
	Point : class {
		constructor(x, y){
			this.x = x ;
			this.y = y ;
		}
	},

	Size : class {
		constructor(width, height){
			this.width  = width ;
			this.height = height ;
		}
	},

	Rect : class {
		constructor(point, size){
			this.point = point ;
			this.size  = size ;
		}
	}
} ;



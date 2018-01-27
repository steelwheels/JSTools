/*
 * Graphics/Console.js
 */

/* global resources */
module = {} ;
tmp    = {} ;

/* allocate temporary resource */
tmp.gr = require('Graphics/Primitives') ;

module.exports = {
	Label: class extends tmp.gr.View {
		/* title: 	String
		 * align:	Align
		 */
		constructor(frame){
			super(frame) ;
			this.title = null ;
			this.align = Align.Center ;
		}

		draw(){
			if(this.title != null){
				let height = this.frame.size.height ;
			} else {

			}
		}
	}
}

/* release temporary resource */
tmp   = {} ;

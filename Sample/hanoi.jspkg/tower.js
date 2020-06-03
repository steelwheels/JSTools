/**
 * tower.js
 */

class Tower {
	constructor(towernum, disknum, toweridx){
		this.tower_num		= towernum ;
		this.tower_index	= toweridx ;
		this.disk_num		= disknum ;
		this.tower_width	= int(Curses.width / towernum) ;

		/* Init disk state */
		this.disk_status = Array(disknum) ;
		for(let i=0 ; i<disknum ; i++){
			this.disk_status[i] = false ;
		}

		/* Calc disk width */
		this.disk_width = Array(disknum) ;
		let width = this.tower_width ;
		for(let i=disknum-1 ; i>=0 ; i--){
			width = int(width * 2 / 3) ;
			this.disk_width[i] = width ;
		}
	}

	get_status(level) { // -> Bool
		return this.disk_status[level] ;
	}

	set_status(level, status) {
		this.disk_status[level] = status ;
	}

	draw(){
		let width = this.tower_width ;
		let left  = width * this.tower_index ;
		let y     = 0 ;
		for(let i=0 ; i<this.disk_num ; i++){
			let col = this.disk_color(i) ;
			Curses.foregroundColor = col ;
			Curses.backgroundColor = col ;

			let w = this.disk_width[i] ;
			let x = left + int((width - w) / 2) ;
			Curses.fill(x, y, w, 4, "*") ;
			y += 4 ;
		}
	}

	disk_color(lvl){
		let result = Color.white ;
		switch(lvl){
		  case 0:	result = Color.red ;		break ;
		  case 1:	result = Color.green ;		break ;
		  case 2:	result = Color.blue ;		break ;
		  case 3:	result = Color.yellow ;		break ;
		  case 4:	result = Color.cyan ;		break ;
		  case 5:	result = Color.magenta ;	break ;
		}
		return result ;
	}
}


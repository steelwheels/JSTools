/**
 * disk.js
 */

class Disk {
	constructor(disksize, disknum, backcol){
		this.disk_size	= disksize ;
		this.disk_num	= disknum ;

		/* Get width */
		let width = int(Curses.width / 3) ;
		this.max_width	= width ;
		for(let i=disknum ; i>disksize ; i--){
			width = int(width * 2 / 3) ;
		}
		this.disk_width = width ;

		/* Keep background color */
		this.background_color = backcol ;
	}

	static get height()	{ return 3 ;			}

	draw(x, y) {
		x += int((this.max_width - this.disk_width) / 2) ;
		let color = this.disk_color(this.disk_size) ;
		Curses.backgroundColor = color ;
		Curses.fill(x, y, this.disk_width, Disk.height, " ") ;
	}

	erace(x, y) {
		x += int((this.max_width - this.disk_width) / 2) ;
		let color = this.disk_color(this.disk_size) ;
		Curses.backgroundColor = this.background_color ;
		Curses.fill(x, y, this.disk_width, Disk.height, " ") ;
	}

	disk_color(lvl){
		let result = Curses.white ;
		switch(lvl){
		  case 0:	result = Curses.black ;		break ;
		  case 1:	result = Curses.red ;		break ;
		  case 2:	result = Curses.green ;		break ;
		  case 3:	result = Curses.blue ;		break ;
		  case 4:	result = Curses.yellow ;	break ;
		  case 5:	result = Curses.cyan ;		break ;
		  case 6:	result = Curses.magenta ;	break ;
		}
		return result ;
	}
}


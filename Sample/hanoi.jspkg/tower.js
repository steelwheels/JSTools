/**
 * tower.js
 */

class Tower {
	constructor(toweridx, towernum, disknum){
		this.disks		= [null, null, null, null] ;
		this.tower_index	= toweridx ;
		this.tower_num		= towernum ;
		this.disk_num		= disknum ;
	}

	set_disk(idx, disk){
		this.disks[idx] = disk ;
		if(disk != null){
			let diff = int(Curses.width / this.tower_num) ;
			let x    = diff * this.tower_index ;
			let y    = idx * Disk.height ;
			disk.draw(x, y) ;
		}
	}

	get_disk(idx){
		let result = this.disks[idx] ;
		if(result != null){
			let diff = int(Curses.width / this.tower_num) ;
			let x    = diff * this.tower_index ;
			let y    = idx * Disk.height ;
			result.erace(x, y) ;
			this.disks[idx] = null ;
		}
		return result ;
	}

	push_disk(disk){
		for(let i=this.disk_num-1 ; i>=0 ; i--){
			if(this.disks[i] == null){
				this.set_disk(i, disk) ;
				break ;
			}
		}
	}

	pop_disk(){
		for(let i=0 ; i<this.disk_num ; i++){
			if(this.disks[i] != null){
				return this.get_disk(i) ;
			}
		}
		return null ;
	}

	draw(){
		let diff = int(Curses.width / this.tower_num) ;
		let x    = diff * this.tower_index ;
		let y    = 0 ;
		for(let i=0 ; i<this.disk_num ; i++){
			let disk = this.disks[i] ;
			if(disk != null){
				disk.draw(x, y) ;
			}
			y += Disk.height ;
		}
	}
}


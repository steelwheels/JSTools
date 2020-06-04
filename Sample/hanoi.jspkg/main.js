
function main(args)
{
	const TOWER_NUM = 3 ;
	const DISK_NUM  = 4 ;

	console.print("Hello, world !!\n") ;

	Curses.start() ;
		/* Keep color */
		let backcol = Curses.backgroundColor ;

		/* Fill background */
		let width  = Curses.width ;
		let height = Curses.height ;
		Curses.foregroundColor = Curses.backgroundColor ;
		Curses.fill(0, 0, width, height, " ") ;

		/* Setup towers */
		let towers = [null, null, null] ;
		for(let i=0 ; i<TOWER_NUM ; i++){
			towers[i] = new Tower(i, TOWER_NUM, DISK_NUM) ;
		}

		/* Set disks */
		towers[0].push_disk(new Disk(4, DISK_NUM, backcol)) ;
		towers[0].push_disk(new Disk(3, DISK_NUM, backcol)) ;
		towers[0].push_disk(new Disk(2, DISK_NUM, backcol)) ;
		towers[0].push_disk(new Disk(1, DISK_NUM, backcol)) ;

		/* Move disks */
		hanoi(towers, DISK_NUM, 0, 2, 1) ;

		sleep(3) ;
	Curses.end() ;
}

function draw_towers(towers, towernum)
{
	for(let i=0 ; i<towernum ; i++){
		towers[i].draw() ;
	}
}

function hanoi(towers, movnum, from, to, work)
{
	if(movnum > 0){
		hanoi(towers, movnum-1, from, work, to) ;

		let disk = towers[from].pop_disk() ;
		towers[to].push_disk(disk) ;
		sleep(1.0) ;

		hanoi(towers, movnum-1, work, to, from) ;
	}
}


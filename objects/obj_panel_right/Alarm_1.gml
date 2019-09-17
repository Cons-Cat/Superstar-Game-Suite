/// @description Slide back in
if instance_exists(obj_tiles_grid) {
	with obj_tiles_grid {
		instance_destroy();
	}
}

if instance_exists(obj_tiles_sheet) {
	with obj_tiles_sheet {
		instance_destroy();
	}
}

moveToX = global.tempXRight;
moveToSpd = (room_width + view_wport[1] - global.tempXRight) / 6;
moveDirection = -1;
scrollHorPartition = 0;
scrollVerPartition = 0;

/// @description Slide panels in / generate tiles
if instance_exists(obj_tiles_grid) {
	with obj_tiles_grid {
		instance_destroy();
	}
}
if instance_exists(obj_tiles_layers) {
	with obj_tiles_layers {
		instance_destroy();
	}
}
if instance_exists(obj_tiles_sheet) {
	with obj_tiles_sheet {
		instance_destroy();
	}
}

obj_panel_left.moveToX = global.tempXLeft;
obj_panel_left.moveToSpd = (global.tempXLeft - room_width) / 6;
obj_panel_left.moveDirection = 1;
obj_panel_left.scrollHorPartition = 0;
obj_panel_left.scrollVerPartition = 0;

obj_panel_right.moveToX = global.tempXRight;
obj_panel_right.moveToSpd = (room_width + view_wport[1] - global.tempXRight) / 6;
obj_panel_right.moveDirection = -1;
obj_panel_right.scrollHorPartition = 0;
obj_panel_right.scrollVerPartition = 0;

canSpawnButtons = true;
spawnTiles = true;

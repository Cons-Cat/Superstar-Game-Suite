/// @description Slide side panels in
if instance_exists(obj_editor_terrain_par) && !isPlayButton {
	with obj_big_button_right {
		instance_destroy();
	}
}

obj_panel_left.moveToX = global.tempXLeft;
obj_panel_left.moveToSpd = global.tempXLeft / 6;
obj_panel_left.moveDirection = 1;
obj_panel_left.panelWidth = 0;
obj_panel_left.scrollPanelHorDefined = false;

obj_panel_right.moveToX = global.tempXRight;
obj_panel_right.moveToSpd = (1024 - global.tempXRight) / 6;
obj_panel_right.moveDirection = -1;
obj_panel_right.panelWidth = 0;
obj_panel_right.scrollPanelHorDefined = false;

spawnButtons = true;

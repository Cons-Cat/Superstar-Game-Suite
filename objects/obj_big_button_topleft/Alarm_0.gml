/// @description Slide side panels in
with obj_panel_button {
	instance_destroy();
}

obj_panel_left.moveToX = global.tempXLeft;
obj_panel_left.moveToSpd = (global.tempXLeft - room_width - view_wport[1]) / 6;
obj_panel_left.moveDirection = 1;

obj_panel_right.moveToX = global.tempXRight;
obj_panel_right.moveToSpd = (global.tempXRight - room_width - view_wport[1]) / 6;
obj_panel_right.moveDirection = -1;

spawnButtons = true;

/// @description Insert description here
event_inherited();

y = obj_panel_top.y - 57;

if !mouse_check_button(mb_left) {
	imgIndex = 0;
}

if select {
	// Slide side panels out
	if obj_panel_left.moveToSpd = 0 && obj_panel_right.moveToSpd = 0 {
		global.tempXLeft = obj_panel_left.x;
		global.tempXRight = obj_panel_right.x;
	}
	
	obj_panel_left.moveToX = 0;
	obj_panel_left.moveToSpd = global.tempXLeft/4;
	obj_panel_left.moveDirection = -1;
				
	obj_panel_right.moveToX = 1024;
	obj_panel_right.moveToSpd = (1024 - global.tempXRight)/4;
	obj_panel_right.moveDirection = 1;
	
	select = false;
	changeMode = true;
	
	if instance_exists(obj_editor_terrain_par) {
		obj_editor_terrain_par.select = false; // De-select all terrain instances
	}
	with obj_editor_button_parent {
		instance_destroy(); // Destroy any terrain interface remnants
	}
	
	obj_editor_gui.selectInstance = -1; // Reset the selected instance
	
	alarm[0] = 17;
}

if changeMode {
	obj_editor_gui.mode = self.mode;
	changeMode = false;
}

/// @description Insert description here
event_inherited();

y = round(obj_panel_top.y - 3 - ( (obj_panel_top.y - 5) / 55) * 2 );
x = obj_panel_left.baseX + 2 + (sprite_width * scale / 2) + (sortX * sprite_width * scale) + (6/50 * sprite_width * scale * (sortX + 1) );

if select {
	select = false;
	changeMode = true;
	
	// Slide side panels out
	if obj_panel_left.moveToSpd = 0 && obj_panel_right.moveToSpd = 0 {
		global.tempXLeft = obj_panel_left.x;
		global.tempXRight = obj_panel_right.x;
	}
	
	obj_panel_right.exitInterface = true;
	obj_panel_left.exitInterface = true;
	
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

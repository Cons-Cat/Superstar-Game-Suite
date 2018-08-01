/// @description Placing terrain
if select = 1 {
	if !(mouse_x < self.x && mouse_x > self.x - sprite_width && mouse_y > self.y && mouse_y < self.y + sprite_height) {
		if mouse_check_button_pressed(mb_left) {
			// Change z level without deselecting
			if !((mouse_x >= obj_tile_z.x + 15 && mouse_x <= obj_tile_z.x + 35) && ((mouse_y >= obj_tile_z.y - 22 && mouse_y <= obj_tile_z.y - 2) || (mouse_y >= obj_tile_z.y + 22 && mouse_y <= obj_tile_z.y + 42))) {
				select = 0;
				col = c_white;
			}
		
			// Place tile in grid area
			if mouse_x < camera_get_view_x(obj_editor_gui.camera) + 342 {
				if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 {
					instance_create_layer(mouse_x,mouse_y,"Instances",obj_editor_terrain);
				}
				if obj_editor_gui.mode = 4 {
					//
				}
			}
		}
	}
}

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 {
	sprite_index = spr_slope2_editor;
}
if obj_editor_gui.mode = 4 {
	sprite_index = spr_cutscene_trigger;
}

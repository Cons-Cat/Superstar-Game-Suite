/// @description Placing instances.
if select {
	if objIndex != -1 {
		if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
			if mouse_y > obj_panel_top.y {
				if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
					if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
						if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
							if mouse_check_button_pressed(mb_left) {
								with instance_create_layer(0, 0, "Instances", objIndex) {
									x = ( obj_editor_gui.mouseCheckX div 20 ) * 20;
									y = ( obj_editor_gui.mouseCheckY div 20 ) * 20;
									
									zfloor = obj_z_max.z;
									zcieling = obj_z_min.z;
								}
								
								obj_editor_gui.canChangeSelect = false;
								canRelease = true;
							}
						}
					}
				}
			}
		}
	}
}

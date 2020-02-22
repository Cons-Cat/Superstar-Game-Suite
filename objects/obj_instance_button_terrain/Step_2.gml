/// @description Painting terrain
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

if select {
	// Deselect terrain
	if instance_exists(obj_editor_terrain_par) {
		obj_editor_terrain_par.canSelect = false;
	}
	
	// Painting mode
	if keyboard_check(vk_alt) {
		objIndex = -1;
	} else {
		if !mouse_check_button(mb_left) {
			objIndex = obj_editor_terrain;
		}
	}
	
	// Paint
	if objIndex = -1 {
		placeEmpty = true;
		
		for (i = 0; i < instance_number(obj_editor_terrain_par); i++) {
			tempInst = instance_find(obj_editor_terrain_par,i);
			
			if
			// If tempInst occupies the Z space
			(tempInst.zfloor > obj_z_min.z && tempInst.zcieling <= obj_z_min.z)
			|| (tempInst.zfloor >= obj_z_max.z && tempInst.zcieling < obj_z_max.z)
			|| (tempInst.zfloor <= obj_z_max.z && tempInst.zcieling >= obj_z_min.z)
			{
				if
				// If tempInst occupies the X space
				tempInst.x <= mouseCheckX
				&& tempInst.x + tempInst.width*20 >= mouseCheckX
				// If tempInst occupies the Y space
				&& tempInst.y + tempInst.zfloor*20 <= mouseCheckY + obj_z_max.z*20
				&& tempInst.y + tempInst.zfloor*20 + tempInst.height*20 >= mouseCheckY + obj_z_max.z*20
				{
					placeEmpty = false;
					
					break;
				}
			}
		}
		show_debug_message(string(mouseCheckX) + ", " + string(mouseCheckY));
		if placeEmpty {
			if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
				if mouse_y > obj_panel_top.y {
					if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
						if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
							if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
								if mouse_check_button(mb_left) {
									//show_debug_message("TEMPX: " + string(tempInst.x) + ", " + string(tempInst.x + tempInst.width*20) + ", CHECKX: " + string(mouseCheckX));
									with instance_create_layer(0, 0, "Instances", obj_editor_terrain) {
										canPlace = false;
										canDrag = false;
										select = false;
										placed = 1;
										
										x = floor(other.mouseCheckX/20)*20;
										y = floor((obj_editor_gui.mouseCheckY)/20)*20;
										
										zfloor = obj_z_max.z;
										zcieling = obj_z_min.z;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	// Stop painting
	if (keyboard_check_released(vk_alt) && !mouse_check_button(mb_left)) || (!keyboard_check(vk_alt) && mouse_check_button_released(mb_left) && objIndex = -1) {
		obj_editor_gui.canChangeSelect = true; // Override obj_editor_terrain_par's Create event
		select = false; // Deselect button
		objIndex = obj_editor_terrain;
	}
}

event_inherited();

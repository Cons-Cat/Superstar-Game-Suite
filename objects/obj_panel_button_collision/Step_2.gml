/// @description Painting terrain
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

var painting = false;

if select {
	// De-select terrain
	if instance_exists(obj_editor_terrain_par) {
		obj_editor_terrain_par.canSelect = false;
	}
	
	// Painting mode
	if keyboard_check(vk_alt) {
		painting = true;
	} else {
		if !mouse_check_button(mb_left) {
			painting = false;
		}
	}
	
	// Paint
	if painting {
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
				tempInst.x - ( sprite_get_width(object_get_sprite(objIndex)) - 20 ) <= mouseCheckX
				&& tempInst.x + tempInst.width*20 >= mouseCheckX
				// If tempInst occupies the Y space
				&& tempInst.y + tempInst.zfloor*20 - ( sprite_get_height(object_get_sprite(objIndex)) - 20 ) <= mouseCheckY + obj_z_max.z*20
				&& tempInst.y + tempInst.zfloor*20 + tempInst.height*20 >= mouseCheckY + obj_z_max.z*20
				{
					placeEmpty = false;
					
					break;
				}
			}
		}
		
		if placeEmpty {
			if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
				if mouse_y > obj_panel_top.y {
					if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
						if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
							if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
								if mouse_check_button(mb_left) {
									with instance_create_layer(0, 0, "Instances", objIndex) {
										canPlace = false;
										canDrag = false;
										select = false;
										placed = 1;
										
										x = (other.mouseCheckX div 20)*20;
										y = (other.mouseCheckY div 20)*20;
										
										zfloor = obj_z_max.z;
										zcieling = obj_z_min.z;
									}
									
									painted = true;
								}
							}
						}
					}
				}
			}
		}
	}
	
	// De-select
	if painted && !keyboard_check(vk_alt) && !mouse_check_button(mb_left) {
		obj_editor_gui.canChangeSelect = true;
		
		canRelease = false;
		select = false;
		painted = false;
	}
}

event_inherited();

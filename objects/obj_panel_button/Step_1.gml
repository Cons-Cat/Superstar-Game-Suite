/// @description 

// Button behavior types
if select {
	// Placing instances
	if buttonType = 0 {
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
	} else
	
	// Wheel behavior
	if buttonType = 1 {
		relativeMouseX = window_mouse_get_x();
		relativeMouseY = window_mouse_get_y();
		angle = floor(point_direction(x+sprWidth+2+sprite_width/2 - camera_get_view_x(view_camera[viewOn]) + view_xport[viewOn], y-1+sprite_height/2 + view_yport[viewOn],relativeMouseX,relativeMouseY) / 22.5) * 22.5;
		
		// Snap to nothing if in its center
		if point_in_rectangle(mouse_x,mouse_y,x+sprWidth+2+sprite_width/2-5,y-5-1+sprite_height/2,x+sprWidth+2+sprite_width/2+5,y+5-1+sprite_height/2) {
			angle = -1;
		}
		
		trg.angle = self.angle;
		canSelect = true;
	} else
	
	// Value input behavior
	if buttonType = 2 {
		if keyboard_check_pressed(vk_anykey) {
			if !keyboard_check_direct(20) { // Caps Lock
				if keyboard_check_pressed(vk_decimal) || keyboard_check_pressed(190) {
					// Add a decimal
					arbitraryVal = arbitraryVal + ".";
					decimalPlace = string_length(arbitraryVal);
				} else {
					// Add an integer
					arbitraryVal = string_digits(typeText(arbitraryVal,true));
					
					if decimalPlace != -1 {
						arbitraryVal = string_insert(".",arbitraryVal,decimalPlace);
					}
					
					// Delete decimal
					if keyboard_check_pressed(vk_backspace) {
						if string_length(arbitraryVal) = decimalPlace {
							decimalPlace = -1;
						}
					}
				}
				
				valueLength = string_width(arbitraryVal)*2 + 4;
			}
		}
	} else
	
	// String input behavior
	if buttonType = 3 {
		if keyboard_check_pressed(vk_anykey) {
			arbitraryVal = typeText(arbitraryVal, true);
		}
		
		valueLength = string_width(arbitraryVal)*2 + 4;
	}
}

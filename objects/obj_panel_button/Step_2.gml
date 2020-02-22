/// @description Insert description here
if ((mouse_x >= x && mouse_x <= x + sprWidth) || (mouse_x >= x + sprWidth + 3 && mouse_x <= x + sprWidth + 34))
&& mouse_y >= y - 1 && mouse_y <= y + sprHeight + 1 {
	canSelect = true;
} else {
	canSelect = false;
}

// Placing instances
if select {
	// Generic button behavior
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
								}
							}
						}
					}
				}
			}
		}
	}
	
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
	}
	
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
	}
	
	// String input behavior
	if buttonType = 3 {
		if keyboard_check_pressed(vk_anykey) {
			arbitraryVal = typeText(arbitraryVal, true);
		}
		
		valueLength = string_width(arbitraryVal)*2 + 4;
	}
}

// Selecting / de-selecting
if mouse_check_button_pressed(mb_left) {
	if canSelect {
		if !select {
			obj_panel_button.select = false;
			obj_editor_gui.canChangeSelect = false;
			select = true;
		} else {
			select = false;
		}
	} else {
		if objIndex != -1 {
			canRelease = true;
		}
	}
}

if mouse_check_button_released(mb_left) {
	if canRelease {
		select = false;
		canRelease = false;
	}
}

// Colors
if select {
	selectState = 2;
	
	col[3] = obj_editor_gui.colOrange;
	font = obj_editor_gui.fontDark;
} else if canSelect {
	selectState = 1;
	
	col[3] = obj_editor_gui.colOrange;
	font = obj_editor_gui.fontDark;
} else {
	selectState = 0;
	
	col[3] = obj_editor_gui.colOffWhite;
	font = obj_editor_gui.font;
}

// Sorting
fillHor = abs(panelId.scrollHorRightBound - panelId.scrollHorLeftBound + 1) div (longestSprWidth);

if fillHor > 0 {
	sortX = (sortIndex % fillHor) * longestSprWidth;
	sortY = (sortIndex div fillHor) * 45;
} else {
	sortX = 0;
	sortY = sortIndex * 45;
}

x = camera_get_view_x(view_camera[viewOn]) + 2 + sortX;
y = camera_get_view_y(view_camera[viewOn]) + 3 + sortY - (panelId.panelHeight - (panelId.scrollVerBotBound - panelId.scrollVerTopBound + 9)) * panelId.scrollVerPartition / 100;

gone = true;

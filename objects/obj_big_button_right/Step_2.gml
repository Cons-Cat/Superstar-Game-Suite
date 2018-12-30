/// @description Insert description here
if mouse_check_button_pressed(mb_left) {
	if obj_panel_left.select = 0 && obj_panel_right.select = 0 && obj_panel_top.select = 0 {
		imgIndex = 0;
	}
}

// Placing instances
if select {
	if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
		if mouse_y > obj_panel_top.y {
			if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
				if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
					if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
						if mouse_check_button_pressed(mb_left) {
							instance_create_layer(floor(mouse_x / 20) * 40 + camera_get_view_x(obj_editor_gui.cameraRealGame), floor(mouse_y / 20) * 40 + camera_get_view_y(obj_editor_gui.cameraRealGame), "Instances",objIndex);
						}
					}
				}
			}
		}
	}
}

event_inherited();

if imgIndex = 0 {
	select = false;
}

if obj_panel_right.select = 1 || obj_panel_left.select = 1 {
	panelXPosition = obj_panel_right.x;
} else {
	panelXPosition = obj_panel_right.moveToX;
}

// Sorting
if 1024 - panelXPosition <= 340 {
	obj_panel_right.panelHeight = 291;
	sortX = 0;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortY = i * 57;
		}
	}
} else if 1024 - panelXPosition <= 500 {
	obj_panel_right.panelHeight = 184;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			if i % 2 = 0 {
				// Even
				sortX = 0;
			} else {
				// Odd
				sortX = 162;
			}
			
			sortY = floor(i/2) * 57;
		}
	}
} else if 1024 - panelXPosition <= 662 {
	obj_panel_right.panelHeight = 177;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortX = (i % 3) * 162;
			sortY = floor(i/3) * 57;
		}
	}
} else {
	obj_panel_right.panelHeight = 120;
	sortY = 0;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortX = (i % 4) * 162;
			sortY = floor(i/4) * 57;
		}
	}
}

x = 1030 + sortX;
y = 93 + sortY;

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

// Colors
if imgIndex = 0 {
	select = false;
	
	col[0] = make_color_rgb(46,60,109); // Light blue
	col[1] = make_color_rgb(63,70,87); // Dark gray
	col[2] = make_color_rgb(28,30,36); // Dark blue
	col[3] = make_color_rgb(200,210,243); // Off white
}

if imgIndex = 1 {
	col[0] = make_color_rgb(58,41,25); // Dark orange
	col[1] = make_color_rgb(196,196,196); // Light gray
	col[2] = make_color_rgb(38,15,14); // Darker orange
	col[3] = make_color_rgb(255,160,64); // Light orange
}

if obj_panel_right.select = 1 || obj_panel_left.select = 1 {
	panelXPosition = obj_panel_right.x;
} else {
	panelXPosition = obj_panel_right.moveToX;
}

// Sorting
if 1024 - panelXPosition <= 320 {
	obj_panel_right.panelHeight = 291;
	sortX = 0;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortY = i * 44;
		}
	}
} else if 1024 - panelXPosition <= 480 {
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
			
			sortY = floor(i/2) * 44;
		}
	}
} else if 1024 - panelXPosition <= 642 {
	obj_panel_right.panelHeight = 177;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortX = (i % 3) * 162;
			sortY = floor(i/3) * 44;
		}
	}
} else {
	obj_panel_right.panelHeight = 120;
	sortY = 0;
	
	for(i = 0; i <= 4; i += 1) {
		if sortIndex = i {
			sortX = (i % 4) * 162;
			sortY = floor(i/4) * 44;
		}
	}
}

x = 1027 + sortX;
y = 89 + sortY;

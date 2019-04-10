/// @description Insert description here

// Placing instances
if select {
	if objIndex != -1 {
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
}

// Selecting / de-selecting
if mouse_check_button_pressed(mb_left) {
	if ((mouse_x >= x && mouse_x <= x + sprWidth) || (mouse_x >= x + sprWidth + 3 && mouse_x <= x + sprWidth + 34))
	&& mouse_y >= y - 1 && mouse_y <= y + sprHeight + 1 {
		if !select {
			obj_panel_button.select = false;
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
	imgIndex = 1;
	
	col[0] = make_color_rgb(58,41,25); // Dark orange
	col[1] = make_color_rgb(196,196,196); // Light gray
	col[2] = make_color_rgb(38,15,14); // Darker orange
	col[3] = make_color_rgb(255,160,64); // Light orange
} else {
	imgIndex = 0;
	
	col[0] = make_color_rgb(46,60,109); // Light blue
	col[1] = make_color_rgb(63,70,87); // Dark gray
	col[2] = make_color_rgb(28,30,36); // Dark blue
	col[3] = make_color_rgb(200,210,243); // Off white
}

// Sorting
fillHor = abs(panelId.scrollHorRightBound - panelId.scrollHorLeftBound + 1) div (145);

if fillHor > 0 {
	sortX = (sortIndex % fillHor) * 145;
	sortY = (sortIndex div fillHor) * 45;
} else {
	sortX = 0;
	sortY = sortIndex * 45;
}

x = camera_get_view_x(view_camera[viewOn]) + 2 + sortX;
y = camera_get_view_y(view_camera[viewOn]) + 3 + sortY;

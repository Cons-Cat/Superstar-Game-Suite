/// @description Insert description here
if mouse_check_button_pressed(mb_left) {
	if obj_panel_left.select = 0 && obj_panel_right.select = 0 && obj_panel_top.select = 0 {
		imgIndex = 0;
	}
}

event_inherited();

if imgIndex = 0 {
	select = false;
}

x = obj_panel_right.x + 6 + sortX;
y = 78 + sortY;

// Placing instances
if select {
	if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
		if mouse_y > obj_panel_top.y {
			if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
				if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
					if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
						placing = true;
						show_debug_message(floor((mouse_x + 192 - 20) / 40) * 20 - 180);
						show_debug_message(floor((mouse_y + 576) / 40) * 20 - 320);
						show_debug_message("-");
					}
				}
			}
		}
	}
}

if obj_panel_right.select = 1 || obj_panel_left.select = 1 {
	panelXPosition = obj_panel_right.x;
} else {
	panelXPosition = obj_panel_right.moveToX;
}

// Sorting
if 1024 - panelXPosition <= 340 {
	sortX = 0;
	
	for(i = 0; i < 4; i += 1) {
		if sortIndex = i {
			sortY = i * 57;
		}
	}
} else if 1024 - panelXPosition <= 500 {
	for(i = 0; i < 4; i += 1) {
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
	for(i = 0; i < 4; i += 1) {
		if sortIndex = i {
			if i < 3 {
				sortX = i * 162;
			} else {
				sortX = 0;
			}
			
			sortY = floor(i/3) * 57;
		}
	}
} else {
	sortY = 0;
	
	for(i = 0; i < 4; i += 1) {
		if sortIndex = i {
			sortX = i * 162;
		}
	}
}

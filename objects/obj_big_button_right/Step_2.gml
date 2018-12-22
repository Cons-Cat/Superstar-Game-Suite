/// @description Insert description here
event_inherited();

x = obj_panel_right.x + 6 + sortX;
y = 78 + sortY;

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

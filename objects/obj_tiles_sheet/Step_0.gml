/// @description 
if mouse_y >= self.y && mouse_y <= sprite_get_height(global.sprMaterial) + self.y {
	if mouse_x >= self.x && mouse_x <= sprite_get_width(global.sprMaterial) + self.x {
		selectWidthScale = selectWidthOffset/2;
		selectHeightScale = selectHeightOffset/2;
		
		// Select tile
		if mouse_check_button_pressed(mb_left) {
			selecting = true;
			draggingSelection = true;
			xInit = floor(mouse_x/20)*20;
			yInit = floor((mouse_y-6)/20)*20;
			selectWidthOffset = 20;
			selectHeightOffset = 20;
		}
		
		if selecting = true {
			for (i = 0; i < selectWidthOffset; i += 20) {
				for (j = 0; j < selectHeightOffset; j += 20) {
					xVal[i,j] = xInit + ((xInit) % 20) + i;
					yVal[i,j] = yInit + ((yInit) % 20) + j + 6;
				}
			}
			if draggingSelection = true {
				if mouse_x > xInit {
					selectWidthOffset = floor((mouse_x+20)/20)*20 - xInit;
				}
				if mouse_y > yInit {
					selectHeightOffset = floor((mouse_y+20-6)/20)*20 - yInit;
				}
				if selectWidthOffset < 20 {
					selectWidthOffset = 20;
				}
				if selectHeightOffset < 20 {
					selectHeightOffset = 20;
				}
			}
		}
		if mouse_check_button_released(mb_left) {
			draggingSelection = false;
		}
	}
}

if mouse_check_button_released(mb_left) {
	selecting = false;
}

if !instance_exists(obj_tiles_grid) {
	// Delete object automatically when menu closes
	instance_destroy();
}

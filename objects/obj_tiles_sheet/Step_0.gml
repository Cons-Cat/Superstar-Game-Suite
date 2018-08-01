/// @description 
if mouse_y >= 600 {
	if mouse_x >= 600 {
		if !keyboard_check(vk_shift) {
			if mouse_wheel_down() {
				scrollY -= 10;
			}
			if mouse_wheel_up() {
				scrollY += 10;
			}
		} else {
			if mouse_wheel_down() {
				if scrollX > -200 {
					scrollX -= 10;
				}
			}
			if mouse_wheel_up() {
				scrollX += 10;
			}
		}
		
		selectWidthScale = selectWidthOffset/2;
		selectHeightScale = selectHeightOffset/2;
		
		// Select tile
		if mouse_check_button_pressed(mb_left) {
			selecting = true;
			draggingSelection = true;
			xInit = floor(mouse_x/20)*20;
			yInit = floor(mouse_y/20)*20;
			selectWidthOffset = 20;
			selectHeightOffset = 20;
		}
		if selecting = true {
			for (i = 0; i < selectWidthOffset; i += 20) {
				for (j = 0; j < selectHeightOffset; j += 20) {
					xVal[i,j] = xInit - scrollX + ((xInit - scrollX) % 20) + i;
					yVal[i,j] = yInit - scrollY + ((yInit - scrollY) % 20) + j;
				}
			}
			if draggingSelection = true {
				if mouse_x > xInit {
					selectWidthOffset = floor((mouse_x+15)/20)*20 - xInit;
				}
				if mouse_y > yInit {
					selectHeightOffset = floor((mouse_y+15)/20)*20 - yInit;
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

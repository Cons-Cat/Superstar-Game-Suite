/// @description 
x = camera_get_view_x(obj_editor_gui.cameraRightPanel);
relativeMouseX = (mouse_x - self.x);
relativeMouseY = (mouse_y - self.y);

obj_panel_right.panelWidth = sprite_get_width(tileDefaultSpr);
obj_panel_right.panelHeight = sprite_get_height(tileDefaultSpr);

if relativeMouseY >= 0 && relativeMouseY <= sprite_get_height(tileDefaultSpr) {
	if relativeMouseX >= 0 && relativeMouseX <= sprite_get_width(tileDefaultSpr) {
		selectWidthScale = selectWidthOffset/2;
		selectHeightScale = selectHeightOffset/2;
		
		// Select tile
		if mouse_check_button_pressed(mb_left) {
			selecting = true;
			draggingSelection = true;
			xInit = floor(relativeMouseX/20)*20;
			yInit = floor(relativeMouseY/20)*20;
			selectWidthOffset = 20;
			selectHeightOffset = 20;
		}
		
		if selecting = true {
			for (i = 0; i < selectWidthOffset; i += 20) {
				for (j = 0; j < selectHeightOffset; j += 20) {
					xVal[i,j] = xInit + ((xInit) % 20) + i + x;
					yVal[i,j] = yInit + ((yInit) % 20) + j + y;
				}
			}
			if draggingSelection = true {
				if relativeMouseX > xInit {
					selectWidthOffset = floor((relativeMouseX+20)/20)*20 - xInit;
				}
				if relativeMouseY > yInit {
					selectHeightOffset = floor((relativeMouseY+20)/20)*20 - yInit;
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

/// @description 
x = camera_get_view_x(obj_editor_gui.cameraRightPanel);
relativeMouseX = (mouse_x - self.x);
relativeMouseY = (mouse_y - self.y);

xOff = camera_get_view_x(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelWidth - (obj_panel_right.scrollHorRightBound - obj_panel_right.scrollHorLeftBound)) * obj_panel_right.scrollHorPartition / 100;
yOff = camera_get_view_y(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelHeight - (obj_panel_right.scrollVerBotBound - obj_panel_right.scrollVerTopBound)) * obj_panel_right.scrollVerPartition / 100;

if relativeMouseY >= 0 && relativeMouseY <= sprite_get_height(tileDefaultSpr) {
	if relativeMouseX >= 0 && relativeMouseX <= sprite_get_width(tileDefaultSpr) {
		selectWidthScale = selectWidthOffset/2;
		selectHeightScale = selectHeightOffset/2;
		
		// Select tile
		if mouse_check_button_pressed(mb_left) {
			selecting = true;
			draggingSelection = true;
			xInit = relativeMouseX div 20 * 20;
			yInit = relativeMouseY div 20 * 20;
			selectWidthOffset = 20;
			selectHeightOffset = 20;
		}
		
		if selecting {
			for (i = 0; i < selectWidthOffset; i += 20) {
				for (j = 0; j < selectHeightOffset; j += 20) {
					xVal[i,j] = xInit + ((xInit) % 20) + i + ( (x - xOff) div 20 ) * 20;
					yVal[i,j] = yInit + ((yInit) % 20) + j + ( (y - yOff) div 20 ) * 20;
				}
			}
			
			if draggingSelection {
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

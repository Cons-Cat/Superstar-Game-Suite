/// @description 
x = camera_get_view_x(obj_editor_gui.cameraRightPanel);
relativeMouseX = (mouse_x - self.x);
relativeMouseY = (mouse_y - self.y);

// Scrolling
xOff = camera_get_view_x(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelWidth - (obj_panel_right.scrollHorRightBound - obj_panel_right.scrollHorLeftBound)) * obj_panel_right.scrollHorPartition / 100;
yOff = camera_get_view_y(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelHeight - (obj_panel_right.scrollVerBotBound - obj_panel_right.scrollVerTopBound)) * obj_panel_right.scrollVerPartition / 100;

// Selecting tiles
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
			xInitTemp = xInit;
			yInitTemp = yInit;
			
			selectWidthOffset = 20;
			selectHeightOffset = 20;
		}
		
		if selecting {
			if draggingSelection {
				if relativeMouseX > xInitTemp {
					xInit = xInitTemp;
					selectWidthOffset = floor((relativeMouseX+20)/20)*20 - xInit;
				}
				if relativeMouseX < xInitTemp + 20 {
					xInit = floor((relativeMouseX)/20)*20;
					selectWidthOffset = floor((xInitTemp+20)/20)*20 - xInit;
				}
				
				if relativeMouseY > yInitTemp {
					yInit = yInitTemp;
					selectHeightOffset = floor((relativeMouseY+20)/20)*20 - yInit;
				}
				if relativeMouseY < yInitTemp + 20 {
					yInit = floor((relativeMouseY)/20)*20;
					selectHeightOffset = floor((yInitTemp+20)/20)*20 - yInit;
				}
				
				if selectWidthOffset < 20 {
					selectWidthOffset = 20;
				}
				if selectHeightOffset < 20 {
					selectHeightOffset = 20;
				}
			}
			
			for (i = 0; i <= selectWidthOffset/20; i += 1) {
				for (j = 0; j <= selectHeightOffset/20; j += 1) {
					xVal[i,j] = xInit + ((xInit) % 20) + i*20 + ( (x - xOff) div 20 ) * 20;
					yVal[i,j] = yInit + ((yInit) % 20) + j*20 + ( (y - yOff) div 20 ) * 20;
				}
			}
		}
	}
}

if mouse_check_button_released(mb_left) {
	draggingSelection = false;
	selecting = false;
}

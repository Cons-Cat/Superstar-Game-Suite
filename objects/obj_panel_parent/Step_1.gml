/// @description 
relativeMouseX = window_mouse_get_x() + room_width;
relativeMouseY = window_mouse_get_y();

if calculateHeight {
	#region
	
	calculateHeight = false;
	var tempHeight = 3;
	var panelButtonCount = 0;
	
	for (i = 0; i < instance_number(obj_panel_button); i += 1) {
		tempTrg = instance_find(obj_panel_button, i);
		
		if tempTrg.viewOn = self.cameraViewOn { // If this button draws to the sub-left panel
			tempHeight += 45;
			panelButtonCount++;
		}
	}
	
	if panelButtonCount > 0 {
		panelHeight = tempHeight - 4;
	} else {
		panelHeight = 0;
	}
	
	scr_panel_calc(self.id);
	
	#endregion
}
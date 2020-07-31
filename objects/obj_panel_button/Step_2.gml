/// @description 
if trg != -1 {
	if !instance_exists(trg) {
		scr_panel_calc(self.id);
		
		instance_destroy();
	}
}

// Selecting / de-selecting
#region

if ((mouse_x >= x && mouse_x <= x + sprWidth) || (mouse_x >= x + sprWidth + 3 && mouse_x <= x + sprWidth + 34))
&& mouse_y >= y - 1 && mouse_y <= y + sprHeight + 1 {
	canSelect = true;
} else {
	canSelect = false;
}

if mouse_check_button_pressed(mb_left) {
	if !select {
		if canSelect {
			obj_panel_button.select = false;
			obj_editor_gui.canChangeSelect = false;
			select = true;
		}
	} else {
		if !( !canSelect && (object_index = obj_region_button_edge || object_index = obj_region_button_threshold) ) {
			select = false;
			obj_editor_gui.canChangeSelect = true;
		}
	}
}

if mouse_check_button_released(mb_left) {
	if canRelease {
		select = false;
		canRelease = false;
	}
}

#endregion

// Colors
#region

if select {
	selectState = 2;
	
	col[3] = obj_editor_gui.colOrange;
	font = obj_editor_gui.fontDark;
} else if canSelect {
	selectState = 1;
	
	col[3] = obj_editor_gui.colOrange;
	font = obj_editor_gui.fontDark;
} else {
	selectState = 0;
	
	col[3] = obj_editor_gui.colOffWhite;
	font = obj_editor_gui.font;
}

#endregion

// Sorting
#region

fillHor = abs(panelId.scrollHorRightBound - panelId.scrollHorLeftBound + 1) div (longestSprWidth);

if fillHor > 0 {
	sortX = (sortIndex % fillHor) * longestSprWidth;
	sortY = (sortIndex div fillHor) * 45;
} else {
	sortX = 0;
	sortY = sortIndex * 45;
}

x = camera_get_view_x(view_camera[viewOn]) + 2 + sortX;
y = camera_get_view_y(view_camera[viewOn]) + 3 + sortY - (panelId.panelHeight - (panelId.scrollVerBotBound - panelId.scrollVerTopBound + 9)) * panelId.scrollVerPartition / 100;

#endregion

gone = true;

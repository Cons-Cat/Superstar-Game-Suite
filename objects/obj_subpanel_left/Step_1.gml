/// @description 
relativeMouseX = window_view_mouse_get_x(1);
relativeMouseY = window_view_mouse_get_y(1);

if relativeMouseX <= x + 60 && relativeMouseX >= x - 60 {
	if relativeMouseY >= y - 21 && relativeMouseY <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = relativeMouseY - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToY = round((relativeMouseY - mouseClickOff + 1) / 5) * 5 + 1;
		
		if moveToY >= obj_panel_bot.y - 20 {
			moveToY = obj_panel_bot.y + 6;
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToY - y) / 2;
		
		image_index = 0;
	}
}

if !select {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if y != obj_panel_bot.y + 6 {
			baseY = y;
			moveToY = obj_panel_bot.y + 6;
		} else {
			moveToY = baseY;
		}
		
		moveToSpd = abs(y - baseY) / 7;
		
		// Minimum speed
		if moveToSpd < 13 {
			moveToSpd = 13;
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
	}
	
	if y != moveToY {
		if abs(moveToY - y) < moveToSpd * 1.8 {
			if moveToSpd > moveToSpdMin {
				moveToSpd /= moveToDeccel;
			} else {
				moveToSpd = moveToSpdMin;
			}
		}
		
		if moveDirection = -1 {
			if y > moveToY + moveToSpd {
				y -= moveToSpd;
			} else {
				y = moveToY;
				moveToSpd = 0;
			}
		} else {
			if y < moveToY - moveToSpd  {
				y += moveToSpd * 1.45;
			} else {
				y = moveToY;
				moveToSpd = 0;
			}
		}
	}
}

if select {
	dragY = relativeMouseY - mouseClickOff;
	dragYTemp = dragY;
	
	y = dragY;
}

// Dragging boundaries
if y > obj_panel_bot.y + 6 {
	y = obj_panel_bot.y + 6;
}
if y < obj_panel_left.scrollHorBotBound + 22 {
	y = obj_panel_left.scrollHorBotBound + 22;
}

scrollVerTopBound = y + 5;
scrollVerBotBound = obj_panel_bot.y - 1;
obj_panel_left.scrollVerBotBound = self.y - 2;

// Scrollbars
event_inherited();

if scrollHorRightBound > 136 {
	x = (scrollHorRightBound + scrollVerRightBound) / 2;
} else {
	x = scrollHorRightBound - 60;
}

scrollHorWidth = obj_panel_left.scrollHorWidth;
scrollVerHeight = (scrollVerFactor) * scrollVerBotBound;

// Viewports
if scrollVerBotBound - scrollVerTopBound > 0 && obj_panel_left.x > 16 {
	visible = true;
} else {
	visible = false;
}

if visible {
	view_set_visible(5,true);
	
	camera_set_view_pos(obj_editor_gui.cameraLeftSubPanel,1025 + camera_get_view_width(obj_editor_gui.cameraRightPanel) + camera_get_view_width(obj_editor_gui.cameraLeftPanel),0);
	camera_set_view_size(view_camera[5], obj_panel_left.x - 15,scrollVerBotBound - y - 5);
	
	view_set_wport(5,obj_panel_left.x - 15);
	view_set_hport(5,scrollVerBotBound - y - 5);
	view_set_yport(5,y + 5);
} else {
	view_set_visible(5,false);
}

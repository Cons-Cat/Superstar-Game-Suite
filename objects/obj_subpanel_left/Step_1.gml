/// @description 
event_inherited();
relativeX = x - room_width;
//relativeMouseX = window_mouse_get_x();

if window_mouse_get_x() <= relativeX + 60 && window_mouse_get_x() >= relativeX - 60 {
	if relativeMouseY >= y - 21 && relativeMouseY <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = true;
			mouseClickOff = relativeMouseY - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if select {
	if !mouse_check_button(mb_left) {
		select = false;
		
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
} else {
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
		
		moveToSpd = abs(moveToY - y) / 11.5;
		
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
				calculateHeight = true;
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

if calculateHeight {
	tempHeight = 3;
	
	for (i = 0; i < instance_number(obj_panel_button); i += 1) {
		tempTrg = instance_find(obj_panel_button,i);
		
		if tempTrg.viewOn = 5 { // If this button draws to the sub-left panel
			tempHeight += 45;
		}
	}
	
	panelHeight = tempHeight - 4;
	calculateHeight = false;
}

// Dragging boundaries
if y > obj_panel_bot.y + 6 {
	y = obj_panel_bot.y + 6;
}
if y < obj_panel_left.scrollHorBotBound + 22 {
	y = obj_panel_left.scrollHorBotBound + 22;
}

obj_panel_left.scrollVerBotBound = y - 2;

if obj_panel_left.scrollVerBotBound > window_get_height() - 1 {
	obj_panel_left.scrollVerBotBound = window_get_height() - 1;
}

// Hide slider when the panel is folded
if !obj_panel_bot.select && !self.select {
	if tempY = -1 { // If the panel will not slide back up automatically
		if scrollVerBotBound - scrollVerTopBound <= 0 {
			if obj_panel_left.x - room_width > 16 {
				if relativeMouseX >= relativeX - sprite_height/2 && relativeMouseX <= relativeX + sprite_height/2 && relativeMouseY >= self.y - sprite_width && relativeMouseY <= self.y {
					if mousePeek > 0 {
						mousePeek -= 2.75;
						
						visible = true;
					} else {
						mousePeek = 0;
					}
				} else {
					if mousePeek < sprite_width {
						mousePeek += 2.25;
					} else {
						mousePeek = sprite_width;
						
						visible = false;
					}
				}
			} else {
				visible = false;
			}
		}
	}
}

// Viewports
if visible && tempY = -1 {
	view_set_visible(5,true);
	view_set_yport(5,y + 5);
	
	camera_set_view_pos(obj_editor_gui.cameraLeftSubPanel,longestPanelRightButton + room_width + view_wport[1] + 1 + view_wport[2] + view_wport[3],0);
	camera_set_view_size(view_camera[5], obj_panel_left.x - 15 - room_width,scrollVerBotBound - y - 5);
	
	view_set_wport(5,obj_panel_left.x - 15 - room_width);
	
	if view_wport[5] < 0 {
		view_set_wport(5,0);
	}
	
	view_set_hport(5,scrollVerBotBound - y - 5);
} else {
	// Save expense when not needed
	view_set_visible(5,false);
}

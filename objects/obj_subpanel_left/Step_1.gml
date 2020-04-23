/// @description 
event_inherited();
relativeX = x - room_width;
relativeMouseX2 = window_mouse_get_x();

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
	dragY = relativeMouseY - mouseClickOff;
	dragYTemp = dragY;
	
	y = dragY;
	anchored = false;
	
	if !mouse_check_button(mb_left) {
		#region
		
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
		
		#endregion
	}
} else {
	#region
	
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if y != obj_panel_bot.y + 5 {
			baseY = y;
			moveToY = obj_panel_bot.y + 5;
		} else {
			moveToY = baseY;
			anchored = false;
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
	
	#endregion
}

if calculateHeight {
	#region
	
	calculateHeight = false;
	tempHeight = 3;
	
	for (i = 0; i < instance_number(obj_subpanel_button); i += 1) {
		tempTrg = instance_find(obj_subpanel_button,i);
		
		if tempTrg.viewOn = 5 { // If this button draws to the sub-left panel
			tempHeight += 45;
		}
	}
	
	panelHeight = tempHeight - 4;
	
	#endregion
}

if !mouse_check_button(mb_left) {
	if y >= obj_panel_bot.y {
		if moveToSpd = 0 {
			anchored = true;
		}
	}
}

if anchored {
	// Anchor Y
	y = obj_panel_bot.y + 5;
} else {
	// Dragging boundaries
	if moveToSpd = 0 {
		if y >= obj_panel_bot.y + 5 {
			y = obj_panel_bot.y + 5;
		}
	}
	
	if y < obj_panel_left.scrollHorBotBound + 22 {
		y = obj_panel_left.scrollHorBotBound + 22;
	}
	
	if obj_panel_left.scrollVerBotBound > obj_editor_gui.calcWindowHeight - 1 {
		obj_panel_left.scrollVerBotBound = obj_editor_gui.calcWindowHeight - 1;
	}
}

obj_panel_left.scrollVerBotBound = y - 2;

// Hide slider when the panel is folded
if !obj_panel_bot.select && !self.select {
	if tempY = -1 { // If the panel will not slide back up automatically
		if anchored {
			if obj_panel_left.x - room_width > 16 {
				if relativeMouseX2 >= relativeX - sprite_height/2 && relativeMouseX2 <= relativeX + sprite_height/2 && relativeMouseY >= self.y - sprite_width && relativeMouseY <= self.y {
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
					}
				}
			}
		} else {
			if mousePeek > 0 {
				mousePeek -= 2.25;
			} else {
				mousePeek = 0;
			}
		}
	}
}

// Viewports

// Prevent left panel buttons from ever clipping into the sub-left panel
panelOffset = obj_panel_left.longestSprWidth

if panelOffset < obj_panel_left.panelWidth {
	panelOffset = obj_panel_left.panelWidth;
}

if updateView {
	if visible && tempY = -1 {
		view_set_visible(5,true);
		view_set_yport(5,y + 5);
		
		camera_set_view_pos(obj_editor_gui.cameraLeftSubPanel,camera_get_view_x(obj_editor_gui.cameraLeftPanel) + camera_get_view_width(obj_editor_gui.cameraLeftPanel) + panelOffset + 1,0);
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
}

/// @description 
relativeMouseX = window_view_mouse_get_x(1);

if relativeMouseX <= x + 60 && relativeMouseX >= x - 60 {
	if mouse_y >= y - 21 && mouse_y <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = mouse_y - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToY = round((mouse_y - mouseClickOff + 1) / 5) * 5 + 1;
		
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
	dragY = mouse_y - mouseClickOff;
	dragYTemp = dragY;
	
	y = dragY;
}

if y > obj_panel_bot.y + 6 {
	y = obj_panel_bot.y + 6;
}

scrollVerTopBound = y+5;
scrollVerBotBound = obj_panel_bot.y;
obj_panel_left.scrollVerBotBound = self.y - 88;

// Scrollbars

if scrollHorRightBound > 136 {
	x = (scrollHorRightBound + scrollVerRightBound) / 2;
} else {
	x = scrollHorRightBound - 60;
}

scrollHorFactor = obj_panel_left.scrollHorFactor;
scrollVerFactor = scrollVerBotBound / panelHeight;

if scrollVerFactor > 1 {
	scrollVerFactor = 1;
}

// Scrolling

if relativeMouseX <= scrollHorRightBound && relativeMouseX >= scrollHorLeftBound {
	if mouse_y >= scrollHorTopBound && mouse_y <= scrollVerBotBound {
		if mouse_wheel_up() {
			if keyboard_check(vk_shift) {
				if scrollHorPartition < 100 - 100 / (panelWidth / (x - 16) * 2) {
					scrollHorPartition += 100 / (panelWidth / (x - 16) * 2);
				} else {
					scrollHorPartition = 100;
				}
			} else {
				if scrollVerPartition > 100 / (panelHeight / scrollVerBotBound) {
					scrollVerPartition -= 100 / (panelHeight / scrollVerBotBound);
				} else {
					scrollVerPartition = 0;
				}
			}
		}
		
		if mouse_wheel_down() {
			if keyboard_check(vk_shift) {
				if scrollHorPartition > 100 / (panelWidth / (x - 16) * 2) {
					scrollHorPartition -= 100 / (panelWidth / (x - 16) * 2);
				} else {
					scrollHorPartition = 0;
				}
			} else {
				if scrollVerPartition < 100 - 100 / (panelHeight / scrollVerBotBound) {
					scrollVerPartition += 100 / (panelHeight / scrollVerBotBound);
				} else {
					scrollVerPartition = 100;
				}
			}
		}
	}
}

// Select scroll bars
if mouse_check_button_pressed(mb_left) && !select {
	if mouse_x >= scrollHorX && mouse_x <= scrollHorX + scrollHorWidth {
		if mouse_y >= scrollHorTopBound && mouse_y <= scrollHorBotBound {
			scrollHorSelect = true;
			scrollHorSelectOff = relativeMouseX - scrollHorX;
		}
	}
	
	if mouse_x >= scrollVerLeftBound && mouse_x <= scrollVerRightBound {
		if mouse_y >= scrollVerY && mouse_y <= scrollVerY + scrollVerHeight {
			scrollVerSelect = true;
			scrollVerSelectOff = mouse_y - scrollVerY
		}
	}
}

if scrollHorSelect {
	if scrollPanelHorDefined {
		// Drag horizontal scroll bar
		scrollHorX = relativeMouseX - scrollHorSelectOff;
		scrollHorPartition = (scrollHorX - 16) / ((x - 16) - scrollHorWidth) * 100;
		
		if scrollHorX < 16 {
			scrollHorX = 16;
			scrollHorPartition = 0;
		}
		
		if scrollHorX + scrollHorWidth > x {
			scrollHorX = x - scrollHorWidth;
			scrollHorPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollHorX = 16 + (scrollHorPartition/100) * ((x - 16) - scrollHorWidth);
}

if scrollVerSelect {
	if scrollPanelVerDefined {
		// Drag vertical scroll bar
		scrollVerY = mouse_y - scrollVerSelectOff;
		scrollVerPartition = (scrollVerY - scrollVerTopBound) / ((scrollVerBotBound) - scrollVerHeight) * 100;
		
		if scrollVerY < scrollVerTopBound {
			scrollVerY = scrollVerTopBound;
			scrollVerPartition = 0;
		}
		
		if scrollVerY + scrollVerHeight > scrollVerBotBound + scrollVerTopBound {
			scrollVerY = scrollVerBotBound + scrollVerTopBound - scrollVerHeight;
			scrollVerPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollVerY = scrollVerTopBound + (scrollVerPartition/100) * (scrollVerBotBound-scrollVerHeight);
}

// Deselect scroll bars
if mouse_check_button_released(mb_left) {
	scrollHorSelect = false;
	scrollVerSelect = false;
}

scrollHorWidth = obj_panel_left.scrollHorWidth;
scrollVerHeight = (scrollVerFactor) * scrollVerBotBound;

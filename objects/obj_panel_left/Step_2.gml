/// @description Insert description here
baseX = 191;
scrollHorRightBound = x;
y = 242;

relativeMouseX = mouse_x % 1024;

if relativeMouseX >= x && relativeMouseX <= x + 21 {
	if mouse_y >= y - 60 && mouse_y <= y + 60 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = relativeMouseX - x;
			
			// Double clicking
			doubleClickCounter += 1;
			
			scrollHorXTemp = scrollHorX;
			scrollHorFactorTemp = scrollHorFactor;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToX = round((relativeMouseX - mouseClickOff - 1) / 10) * 10 - 1;
		if moveToX <= 0 + 221 && moveToX > 0 + 131 {
			moveToX = 0 + 191;
		}
		if moveToX <= 0 + 131 {
			moveToX = 0;
		}
		
		if x > moveToX {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToX - x) / 2;
		
		image_index = 0;
	}
}

if select = 0 {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if x != baseX {
			moveToX = baseX;
			moveToSpd = abs(x - baseX) / 7;
		} else {
			moveToX = 0;
			moveToSpd = 26;
		}

		
		// Minimum speed
		if moveToSpd < 13 {
			moveToSpd = 13;
		}
		
		if x > moveToX {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
	}
	
	if x != moveToX {
		if abs(moveToX - x) < moveToSpd * 1.8 {
			if moveToSpd > moveToSpdMin {
				moveToSpd /= moveToDeccel;
			} else {
				moveToSpd = moveToSpdMin;
			}
		}
		
		if moveDirection = -1 {
			if x > moveToX + moveToSpd {
				x -= moveToSpd;
			} else {
				x = moveToX;
				moveToSpd = 0;
			}
		} else {
			if x < moveToX - moveToSpd  {
				x += moveToSpd;
			} else {
				x = moveToX;
				moveToSpd = 0;
			}
		}
	}
}

if select = 1 {
	dragX = relativeMouseX - mouseClickOff - 0;
	dragXTemp = dragX;
	x = 0 + dragX;
}

// Boundaries
if x < 0 {
	x = 0;
}
if x > 0 + 790 {
	x = 0 + 790;
}

// Pushing other panel
if x + 25 > obj_panel_right.x - 20 && select = 1 {
	if obj_editor_gui.sidePanelCtrl = -1 {
		obj_editor_gui.sidePanelCtrl = 0;
		trgXOrigin = obj_panel_right.x;
	}
}
if obj_editor_gui.sidePanelCtrl = 0 {
	obj_panel_right.x = self.x + 41;
	
	if obj_panel_right.x < trgXOrigin {
		obj_panel_right.x = trgXOrigin;
	}
}
if mouse_check_button_released(mb_left) {
	if obj_editor_gui.sidePanelCtrl = 0 {
		with obj_panel_right {
			moveToSpd = abs(moveToX - x) / 2;
			moveToX = round((x + 2) / 10) * 10 + 2;
		}
	}
}

// Scrollbars
scrollHorFactor = (x - 16) / panelWidth;
scrollVerFactor = botPanelY / panelHeight;

if scrollHorFactor > 1 {
	scrollHorFactor = 1;
}
if scrollVerFactor > 1 {
	scrollVerFactor = 1;
}

// Squish when panel offers less space than needed
if x <= 16 {
	scrollPanelSquish = -(16 - x) * (2);
} else {
	scrollPanelSquish = 0;
}

// Scrolling
botPanelY = obj_panel_bot.y - 86;

if relativeMouseX <= self.x && relativeMouseX >= 16 {
	if mouse_y >= 70 && mouse_y <= 419 {
		if mouse_wheel_up() {
			if keyboard_check(vk_shift) {
				if scrollHorPartition < 100 - 100 / (panelWidth / (x - 16) * 2) {
					scrollHorPartition += 100 / (panelWidth / (x - 16) * 2);
				} else {
					scrollHorPartition = 100;
				}
			} else {
				if scrollVerPartition > 0 + 100 / (panelHeight / botPanelY) {
					scrollVerPartition -= 100 / (panelHeight / botPanelY);
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
				if scrollVerPartition < 100 - 100 / (panelHeight / botPanelY) {
					scrollVerPartition += 100 / (panelHeight / botPanelY);
				} else {
					scrollVerPartition = 100;
				}
			}
		}
	}
}

// Select scroll bars
if relativeMouseX >= scrollHorX && relativeMouseX <= scrollHorX + scrollHorWidth {
	if mouse_y >= 69 && mouse_y <= 84 {
		if mouse_check_button_pressed(mb_left) && !select {
			scrollHorSelect = true;
			scrollHorSelectOff = relativeMouseX - scrollHorX;
		}
	}
}
if relativeMouseX >= 0 && relativeMouseX <= 15 {
	if mouse_y >= scrollVerY && mouse_y <= scrollVerY + scrollVerHeight {
		if mouse_check_button_pressed(mb_left) && !select {
			scrollVerSelect = true;
			scrollVerSelectOff = mouse_y - scrollVerY;
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
		scrollVerPartition = (scrollVerY - scrollVerTopBound) / ((botPanelY) - scrollVerHeight) * 100;
		
		if scrollVerY < scrollVerTopBound {
			scrollVerY = scrollVerTopBound;
			scrollVerPartition = 0;
		}
		if scrollVerY + scrollVerHeight > botPanelY + scrollVerTopBound {
			scrollVerY = botPanelY + scrollVerTopBound - scrollVerHeight;
			scrollVerPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollVerY = scrollVerTopBound + (scrollVerPartition/100) * (botPanelY-scrollVerHeight);
}

// Deselect scroll bars
if mouse_check_button_released(mb_left) {
	scrollHorSelect = false;
	scrollVerSelect = false;
}

scrollHorWidth = (scrollHorFactor) * (x - 16);
scrollVerHeight = (scrollVerFactor) * botPanelY;

// Tiling mode
if obj_editor_gui.mode = 3 {
	if x > 16 && obj_big_button_tiling.spawnButtons {
		view_set_visible(2,true);
		
		camera_set_view_pos(obj_editor_gui.cameraLeftPanel,1024+(scrollHorX-16)/scrollHorFactor,0+(scrollVerY));
		camera_set_view_size(view_camera[2], x-15, botPanelY);
		
		view_set_wport(2,x-15)
		view_set_hport(2,botPanelY)
	} else {
		view_set_visible(2,false);
	}
} else {
	view_set_visible(2,false);
	
	with obj_tiles_grid {
		instance_destroy();
	}
}

scrollHorRightBound = x;

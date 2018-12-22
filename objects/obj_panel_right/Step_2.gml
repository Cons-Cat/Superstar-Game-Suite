/// @description Insert description here
baseX = 0 + 833;
y = 242;

if mouse_x <= x && mouse_x >= x - 21 {
	if mouse_y >= y - 60 && mouse_y <= y + 60 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = mouse_x - x;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToX = round((mouse_x - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToX < 0 + 893 && moveToX >= 0 + 803 {
			moveToX = 0 + 833;
		}
		if moveToX >= 0 + 893 {
			moveToX = 0 + 1024;
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
			moveToX = 1024;
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
	dragX = mouse_x - mouseClickOff - 0;
	dragXTemp = dragX;
	x = 0 + dragX;
}

// Boundaries
if x < 0 + 235 {
	x = 0 + 235;
}
if x > 0 + 1024 {
	x = 0 + 1024;
}

// Pushing other panel
if x - 23 < obj_panel_left.x + 20 && select = 1 {
	if obj_editor_gui.sidePanelCtrl = -1 {
		obj_editor_gui.sidePanelCtrl = 1;
		trgXOrigin = obj_panel_left.x;
		show_debug_message(choose("B","A"));
		show_debug_message(obj_editor_gui.sidePanelCtrl);
	}
}
if obj_editor_gui.sidePanelCtrl = 1 {
	obj_panel_left.x = self.x - 40;
	
	if obj_panel_left.x > trgXOrigin {
		obj_panel_left.x = trgXOrigin;
	}
}
if mouse_check_button_released(mb_left) {
	if obj_editor_gui.sidePanelCtrl = 1 {
		with obj_panel_left {
			moveToSpd = abs(moveToX - x) / 2;
			moveToX = round((x - 1) / 10) * 10 - 1;
		}
	}
}

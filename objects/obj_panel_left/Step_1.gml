/// @description Insert description here
baseX = 191;
relativeMouseX = window_view_mouse_get_x(1);
relativeMouseY = window_view_mouse_get_y(1);
y = 242;

if mouse_x >= x && mouse_x <= x + 21 {
	if mouse_y >= y - 62 && mouse_y <= y + 58 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = true;
			mouseClickOff = mouse_x - x;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = true {
		select = false;
		
		moveToX = round((relativeMouseX - mouseClickOff - 1) / 10) * 10 - 1;
		if moveToX <=  221 && moveToX > 131 {
			moveToX = 191;
		}
		if moveToX <= 131 {
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

if !select  {
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

if select {
	dragX = relativeMouseX - mouseClickOff - 0;
	dragXTemp = dragX;
	x = dragX;
}

// Boundaries
if x < 0 {
	x = 0;
}
if x > 790 {
	x = 790;
}

// Pushing other panel
if x + 25 > obj_panel_right.x - 20 && select {
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

scrollHorRightBound = x - 1;
obj_subpanel_left.scrollHorRightBound = self.scrollHorRightBound;

event_inherited();

// Squish when panel offers less space than needed
if x <= 16 {
	scrollPanelSquish = -(16 - x) * (2);
} else {
	scrollPanelSquish = 0;
}

// Viewports
switch obj_editor_gui.mode {
	// Tiling mode
	case 3:
		if x > 16 && obj_big_button_tiling.spawnButtons {
			view_set_visible(2,true);
			
			camera_set_view_pos(obj_editor_gui.cameraLeftPanel,camera_get_view_x(obj_editor_gui.cameraRightPanel) + camera_get_view_width(obj_editor_gui.cameraRightPanel) + (scrollHorX-16)/scrollHorFactor,scrollVerY);
			camera_set_view_size(view_camera[2], x - 15, scrollVerBotBound);
			
			view_set_wport(2,x - 15)
			view_set_hport(2,scrollVerBotBound)
		} else {
			view_set_visible(2,false);
		}
		
		break;
	
	// Other mode
	default:
		view_set_visible(2,false);
		
		with obj_tiles_grid {
			instance_destroy();
		}
		
		break;
}

/// @description Insert description here
baseX = 833;
scrollHorLeftBound = x;
scrollVerBotBound = obj_panel_bot.y - 1;
relativeMouseX = window_view_mouse_get_x(1);
relativeMouseY = window_view_mouse_get_y(1);
y = 242;

if mouse_x <= x && mouse_x >= x - 21 {
	if mouse_y >= y - 62 && mouse_y <= y + 58 {
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
		
		moveToX = round((relativeMouseX - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToX < 893 && moveToX >= 803 {
			moveToX = 833;
		}
		if moveToX >= 893 {
			moveToX = 1024;
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
	dragX = relativeMouseX - mouseClickOff;
	dragXTemp = dragX;
	x = dragX;
}

// Boundaries
if x < 235 {
	x = 235;
}
if x > 1024 {
	x = 1024;
}

// Pushing other panel
if x - 23 < obj_panel_left.x + 20 && select = 1 {
	if obj_editor_gui.sidePanelCtrl = -1 {
		obj_editor_gui.sidePanelCtrl = 1;
		trgXOrigin = obj_panel_left.x;
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

event_inherited();

// Squish when panel offers less space than needed
if x >= 1008 {
	scrollPanelSquish = (x - 1008) * 2;
} else {
	scrollPanelSquish = 0;
}

switch obj_editor_gui.mode {
	// Collision mode
	case 0:
		if x < 1008 {
			view_set_visible(3,true);
			
			camera_set_view_pos(obj_editor_gui.cameraRightPanel,1026,scrollVerTopBound - (scrollVerTopBound - scrollVerY) / scrollVerFactor);
			camera_set_view_size(view_camera[3], 1009 - x, scrollVerBotBound - scrollVerTopBound);
			
			view_set_wport(3,1009 - x);
			view_set_hport(3,scrollVerBotBound - scrollVerTopBound);
			view_set_xport(3,x);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Wireframe mode
	case 1:
		if x < 1008 {
			view_set_visible(3,true);
			
			camera_set_view_pos(obj_editor_gui.cameraRightPanel,1024,86+(scrollVerY-86)/scrollVerFactor);
			camera_set_view_size(view_camera[3], 1009-x, scrollVerBotBound);
			
			view_set_wport(3,1009-x)
			view_set_hport(3,scrollVerBotBound)
			view_set_xport(3,x);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Tiling mode
	case 3:
		if x < 1008 && obj_big_button_tiling.spawnButtons {
			view_set_visible(3,true);
			
			camera_set_view_pos(obj_editor_gui.cameraRightPanel,tilesSheetPlacement+(scrollHorX-x)/scrollHorFactor,86+(scrollVerY-86)/scrollVerFactor);
			camera_set_view_size(view_camera[3], 1009-x, scrollVerBotBound);
			
			view_set_wport(3,1009-x)
			view_set_hport(3,scrollVerBotBound)
			view_set_xport(3,x);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Trigger mode
	case 4:
		if x < 1008 {
			view_set_visible(3,true);
			
			camera_set_view_pos(obj_editor_gui.cameraRightPanel,1024,86+(scrollVerY-86)/scrollVerFactor);
			camera_set_view_size(view_camera[3], 1009-x, scrollVerBotBound);
			
			view_set_wport(3,1009-x)
			view_set_hport(3,scrollVerBotBound)
			view_set_xport(3,x);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Other mode
	default:
		view_set_visible(3,false);
		
		break;
}

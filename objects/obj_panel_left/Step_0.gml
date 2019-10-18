/// @description Insert description here
event_inherited();

relativeX = x - room_width;
baseX = (window_get_width() - (16 * 20 * obj_editor_gui.realPortScaleHor)) / 2 + room_width;
y = 242/576 * view_hport[1];

if exitInterface {
	exitInterface = false;
	
	moveToX = 0;
	moveToSpd = (global.tempXLeft - room_width) / 4;
	moveDirection = -1;
	
	alarm[1] = 18;
}

if relativeMouseX >= relativeX && relativeMouseX <= relativeX + 21 {
	if relativeMouseY >= y - 62 && relativeMouseY <= y + 58 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = true;
			mouseClickOff = relativeMouseX - relativeX;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if select {
	if !mouse_check_button(mb_left) {
		select = false;
		
		moveToX = round((relativeMouseX - mouseClickOff - 1) / 10) * 10 - 1 + room_width;
		if moveToX <=  baseX + 30 && moveToX > baseX - 30 {
			moveToX = baseX;
		}
		if moveToX <= baseX - 30 {
			moveToX = room_width;
		}
		
		if x > moveToX {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToX - x) / 2;
		
		image_index = 0;
	}
} else {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if x != baseX {
			moveToX = baseX;
			moveToSpd = abs(x - baseX) / 7;
		} else {
			moveToX = room_width;
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
	dragX = relativeMouseX - mouseClickOff + room_width;
	dragXTemp = dragX;
	
	x = dragX;
}

relativeX = x - room_width;

// On base
if x = baseX {
	onBase = 1;
} else {
	onBase = 0;
}
if x = 0 {
	onBase = 2;
}

// Boundaries
if x < room_width {
	x = room_width;
}
if x > obj_panel_right.x {
	x = obj_panel_right.x;
}

// Pushing other panel
/*if x + 25 > obj_panel_right.x - 20 && select {
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
}*/

scrollHorRightBound = x - 1;
scrollHorLeftBound = room_width + 16;
obj_subpanel_left.scrollHorRightBound = self.scrollHorRightBound;
scrollHorTopBound = obj_panel_top.y + 11;
scrollHorBotBound = obj_panel_top.y + 26;

scrollVerLeftBound = room_width;
scrollVerRightBound = room_width + 15;
scrollVerTopBound = obj_panel_top.y + 27;

// Squish when panel offers less space than needed
/*if x <= 16 {
	scrollPanelSquish = -(16 - x) * (2);
} else {
	scrollPanelSquish = 0;
}*/

// Viewports
panelOffset = camera_get_view_width(obj_editor_gui.cameraRightPanel);

if panelOffset < obj_panel_right.panelWidth {
	panelOffset = obj_panel_right.panelWidth;
}

camera_set_view_pos(obj_editor_gui.cameraLeftPanel,camera_get_view_x(obj_editor_gui.cameraRightPanel) + longestPanelRightButton + panelOffset /*+ (scrollHorX-16)/scrollHorFactor*/,0);
camera_set_view_size(view_camera[2], relativeX - 15, scrollVerBotBound);

view_set_wport(2,relativeX - 15);
if view_wport[2] < 0 {
	view_set_wport(2,0);
}

view_set_hport(2,scrollVerBotBound)
view_set_yport(2,scrollVerTopBound);

view_set_visible(2,true);

/*switch obj_editor_gui.mode {
	// Tiling mode
	case 3:
		if x > 16 && obj_big_button_tiling.spawnButtons {
			view_set_visible(2,true);
			
			//camera_set_view_pos(obj_editor_gui.cameraLeftPanel,camera_get_view_x(obj_editor_gui.cameraRightPanel) + camera_get_view_width(obj_editor_gui.cameraRightPanel) + (scrollHorX-16)/scrollHorFactor,scrollVerY);
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
}*/

if !visible {
	view_set_visible(2,false);
}

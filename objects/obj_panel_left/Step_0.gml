/// @description Insert description here
event_inherited();

relativeX = x - room_width;
relativeMouseX2 = window_mouse_get_x();
baseX = round( (obj_editor_gui.calcWindowWidth - (16 * 20 * obj_editor_gui.realPortScaleHor) ) / 2 ) + room_width;
y = 242/576 * view_hport[1];

if exitInterface {
	exitInterface = false;
	
	moveToX = 0;
	moveToSpd = (global.tempXLeft - room_width) / 4;
	moveDirection = -1;
	
	alarm[1] = 18;
}

canSelect = false;

if relativeMouseX2 >= relativeX && relativeMouseX2 <= relativeX + 21 {
	if relativeMouseY >= y - 62 && relativeMouseY <= y + 58 {
		canSelect = true;
	}
}

if canSelect {
	if mouse_check_button_pressed(mb_left) {
		// Dragging
		select = true;
		mouseClickOff = relativeMouseX2 - relativeX;
		
		// Double clicking
		doubleClickCounter += 1;
		
		image_index = 1;
	}
}

if select {
	if !mouse_check_button(mb_left) {
		select = false;
		
		moveToX = round((relativeMouseX2 - mouseClickOff - 1) / 10) * 10 - 1 + room_width;
		
		if moveToX <= baseX - (baseX - room_width) / 3 {
			// Fold away
			moveToX = room_width;
		} else if moveToX <= baseX + (17 * obj_editor_gui.realPortScaleHor) {
			// Snap to baseX
			moveToX = baseX;
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
	dragX = relativeMouseX2 - mouseClickOff + room_width;
	dragXTemp = dragX;
	
	x = dragX;
}

// Boundaries
if x < room_width {
	x = room_width;
}
if x > obj_panel_right.x {
	x = obj_panel_right.x;
}

relativeX = x - room_width;

// On base
if x = baseX {
	onBase = 1;
} else {
	onBase = 0;
}

// Folded
if relativeX = 0 {
	onBase = 2;
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

// Viewports
panelOffset = camera_get_view_width(obj_editor_gui.cameraRightPanel);

// Prevent right panel buttons from ever clipping into the left panel
if panelOffset < obj_panel_right.panelWidth {
	panelOffset = obj_panel_right.panelWidth;
}

if updateView {
	camera_set_view_pos(obj_editor_gui.cameraLeftPanel, camera_get_view_x(obj_editor_gui.cameraRightPanel) + longestPanelRightButton + panelOffset, 0);
	camera_set_view_size(view_camera[2], relativeX - 15, scrollVerBotBound - scrollVerTopBound - 10);
	
	view_set_wport(2, relativeX - 15);
	if view_wport[2] < 0 {
		view_set_wport(2,0);
	}
	
	view_set_hport(2,scrollVerBotBound - scrollVerTopBound - 10)
	view_set_yport(2,scrollVerTopBound);
	
	view_set_visible(2,self.visible);
}

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

scrollHorRightBound = x - 1;
scrollHorLeftBound = room_width + 16;
obj_subpanel_left.scrollHorRightBound = self.scrollHorRightBound;
scrollHorTopBound = obj_panel_top.y + 11;
scrollHorBotBound = obj_panel_top.y + 26;

scrollVerLeftBound = room_width;
scrollVerRightBound = room_width + 15;
scrollVerTopBound = obj_panel_top.y + 27;

// Fold scrollbars with the panel
if relativeX <= 16 {
	scrollVerRightBound = x-1;
}

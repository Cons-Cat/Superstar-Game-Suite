/// @description Insert description here
event_inherited();

relativeX = x - room_width;
relativeMouseX2 = window_mouse_get_x();

baseX = obj_editor_gui.calcWindowWidth + room_width*2 - obj_panel_left.baseX;

y = 242/576 * view_hport[1];

canSelect = false;

if relativeMouseX2 <= relativeX  && relativeMouseX2 >= relativeX - 21 {
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
		
		moveToX = round( (relativeMouseX2 - mouseClickOff + 1) / 10) * 10 + 1 + room_width;
		
		if moveToX >= baseX + (baseX - room_width - 16*20*obj_editor_gui.realPortScaleHor) / 3 {
			// Fold away
			moveToX = view_wport[1] + room_width;
		} else if moveToX >= baseX - (17 * obj_editor_gui.realPortScaleHor) {
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
			moveToX = view_wport[1] + room_width;
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
				//scr_panel_calc(self.id);
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
	//calculateHeight = true;
	
	x = dragX;
}

/*if calculateWidth {
	tempWidth = 0;
	
	for (i = 0; i < instance_number(obj_panel_button); i += 1) {
		tempTrg = instance_find(obj_panel_button,i);
		
		if tempTrg.viewOn = 3 { // If this button draws to the right panel
			if tempTrg.sortX + tempTrg.longestSprWidth > tempWidth { // If this is the widest button yet found
				tempWidth = tempTrg.sortX + tempTrg.longestSprWidth + 14;
			}
			
			tempTrg.visible = true; // Make this button visible after it has been accounted for
		}
	}
	
	panelWidth = tempWidth;
	calculateWidth = false;
}*/

if mouse_check_button_released(mb_left) {
	if obj_editor_gui.sidePanelCtrl = 1 {
		with obj_panel_left {
			moveToSpd = abs(moveToX - x) / 2;
			moveToX = round((relativeX - 1) / 10) * 10 - 1 + room_width;
		}
	}
}

// Boundaries
if x < obj_panel_left.x {
	x = obj_panel_left.x;
}
if x > view_wport[1] + room_width {
	x = view_wport[1] + room_width;
}

relativeX = x - room_width;

// On base
if x = baseX {
	onBase = 1;
} else {
	onBase = 0;
}

// Folded
if relativeX = view_wport[1] {
	onBase = 2;
}

// Pushing other panel
/*if x - 23 < obj_panel_left.x + 20 && select {
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
}*/

// Viewports
if updateView {
	camera_set_view_pos(obj_editor_gui.cameraRightPanel,room_width + view_wport[1] + 1 + panelOffset,0);
	camera_set_view_size(view_camera[3], view_wport[1] - 16 - relativeX, scrollVerBotBound - scrollVerTopBound);
	
	view_set_wport(3,view_wport[1] - 16 - relativeX);
	if view_wport[3] < 0 {
		view_set_wport(3,0);
	}
	
	view_set_hport(3,scrollVerBotBound - scrollVerTopBound);
	view_set_xport(3,relativeX);
	view_set_yport(3,scrollVerTopBound);
}

switch obj_editor_gui.mode {
	// Collision mode
	case 0:
		if relativeX < view_wport[1] - 16 {
			view_set_visible(3,true);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Wireframe mode
	case 1:
		if relativeX < view_wport[1] - 16 {
			view_set_visible(3,true);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Tiling mode
	case 3:
		if relativeX < view_wport[1] - 16 && obj_big_button_tiling.spawnButtons {
			view_set_visible(3,true);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Trigger mode
	case 4:
		if relativeX < view_wport[1] - 16 {
			view_set_visible(3,true);
		} else {
			view_set_visible(3,false);
		}
		
		break;
	
	// Other mode
	default:
		view_set_visible(3,false);
		
		break;
}

if !visible {
	view_set_visible(3,false);
}

// Scrollbars
scrollHorLeftBound = x;
scrollHorRightBound = view_wport[1] - 17 + room_width;
scrollHorTopBound = obj_panel_top.y + 11;
scrollHorBotBound = obj_panel_top.y + 26;

scrollVerRightBound = view_wport[1] - 1 + room_width;
scrollVerLeftBound = view_wport[1] - 16 + room_width;
scrollVerTopBound = obj_panel_top.y + 27;
scrollVerBotBound = obj_panel_bot.y - 1;

// Fold scrollbars with the panel
if relativeX >= view_wport[1] - 16 {
	scrollVerLeftBound = x;
}

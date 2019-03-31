/// @description Insert description here
baseX = 833;
scrollHorLeftBound = x;
scrollVerBotBound = obj_panel_bot.y - 87;
relativeMouseX = window_view_mouse_get_x(1);
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

// Scrollbars
scrollHorFactor = (1008 - x) / panelWidth;
scrollVerFactor = scrollVerBotBound / panelHeight;

if scrollHorFactor > 1 {
	scrollHorFactor = 1;
}
if scrollVerFactor > 1 {
	scrollVerFactor = 1;
}

// Squish when panel offers less space than needed
if x >= 1008 {
	scrollPanelSquish = (x - 1008) * 2;
} else {
	scrollPanelSquish = 0;
}

// Scrolling
if (mouse_x >= scrollHorLeftBound && mouse_x <= scrollHorRightBound) || (view_get_visible(view_camera[2]) && mouse_x >= camera_get_view_x(obj_editor_gui.cameraRightPanel) && mouse_x <= camera_get_view_x(obj_editor_gui.cameraRightPanel) + camera_get_view_width(obj_editor_gui.cameraRightPanel)) {
	if (mouse_y >= scrollHorTopBound && mouse_y <= scrollVerBotBound) || (view_get_visible(view_camera[2]) && mouse_y >= camera_get_view_y(obj_editor_gui.cameraRightPanel) && mouse_y <= camera_get_view_y(obj_editor_gui.cameraRightPanel) + camera_get_view_height(obj_editor_gui.cameraRightPanel)) {
		if mouse_wheel_up() {
			if keyboard_check(vk_shift) {
				if scrollHorPartition < 100 - 100 / (panelWidth / (x) * 2) {
					scrollHorPartition += 100 / (panelWidth / (x) * 2);
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
				if scrollHorPartition > 100 / (panelWidth / (x) * 2) {
					scrollHorPartition -= 100 / (panelWidth / (x) * 2);
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
		if mouse_y >= 69 && mouse_y <= 84 {
			scrollHorSelect = true;
			scrollHorSelectOff = mouse_x - scrollHorX;
		}
	}
	
	if mouse_x >= 1008 && mouse_x <= 1024 {
		if mouse_y >= scrollVerY && mouse_y <= scrollVerY + scrollVerHeight {
			scrollVerSelect = true;
			scrollVerSelectOff = mouse_y - scrollVerY;
		}
	}
}

if scrollHorSelect {
	// Drag horizontal scroll bar
	if scrollPanelHorDefined {
		scrollHorX = mouse_x - scrollHorSelectOff;
		scrollHorPartition = (scrollHorX - x) / ((1008 - x) - scrollHorWidth) * 100;
		
		if scrollHorX < x {
			scrollHorX = x;
			scrollHorPartition = 0;
		}
		
		if scrollHorX + scrollHorWidth > 1008 {
			scrollHorX = 1008 - scrollHorWidth;
			scrollHorPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollHorX = x + (scrollHorPartition/100) * ((1008 - x) - scrollHorWidth);
}
if scrollVerSelect {
	if scrollPanelVerDefined {
		// Drag vertical scroll bar
		scrollVerY = mouse_y - scrollVerSelectOff;
		scrollVerPartition = (scrollVerY - 86) / ((scrollVerBotBound) - scrollVerHeight) * 100;
		
		if scrollVerY < 86 {
			scrollVerY = 86;
			scrollVerPartition = 0;
		}
		
		if scrollVerY + scrollVerHeight > scrollVerBotBound + 86 {
			scrollVerY = scrollVerBotBound + 86 - scrollVerHeight;
			scrollVerPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollVerY = 86 + (scrollVerPartition/100) * (scrollVerBotBound - scrollVerHeight);
}

// Deselect scroll bars
if mouse_check_button_released(mb_left) {
	scrollHorSelect = false;
	scrollVerSelect = false;
}

scrollHorWidth = (scrollHorFactor) * (scrollHorRightBound - scrollHorLeftBound);
scrollVerHeight = (scrollVerFactor) * scrollVerBotBound;

switch obj_editor_gui.mode {
	// Collision mode
	case 0:
		if x < 1008 {
			view_set_visible(3,true);
			
			camera_set_view_pos(obj_editor_gui.cameraRightPanel,1026,86+(scrollVerY-86)/scrollVerFactor);
			camera_set_view_size(view_camera[3], 1009-x, scrollVerBotBound);
			
			view_set_wport(3,1009-x)
			view_set_hport(3,scrollVerBotBound)
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

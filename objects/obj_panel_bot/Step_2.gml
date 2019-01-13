/// @description Insert description here
baseY = 420;
relativeMouseX = mouse_x % 1024;
x = 512;

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
		
		moveToY = round((mouse_y - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToY > 400 && moveToY < 480 {
			moveToY = 420;
		}
		if moveToY >= 480 {
			moveToY = 576;
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
		
		if y != baseY {
			moveToY = baseY;
		} else {
			moveToY = 576;
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
				y += moveToSpd;
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

// Timeline view
if obj_editor_gui.mode = 4 {
	view_visible[4] = false;
}

// Cutscene editor
if instance_number(obj_npc_level) + 1 != rows {
	rows = instance_number(obj_npc_level) + 1; // Every actor, including the player character
	rowLength[rows] = 0;
	selectRow[rows] = false;
}

for (i = 0; i < rows; i += 1) {
	if i = 0 {
		actorId[i] = -1;
		actorTxt[i] = "obj_player";
	} else {
		if instance_number(obj_npc_position) = rows - 1 {
			actorId[i] = instance_find(obj_npc_position,i-1);
			actorTxt[i] = actorId[i].instId1[0];
		}
	}
	
	canSelectRow[i] = false;
	
	if mouse_check_button_pressed(mb_left) {
		if !(mouse_x >= 0 && mouse_x <= 190 && mouse_y >= y+5 && mouse_y <= y+29) {
			selectRow[i] = false;
			actorId[i].orangeAnyways = false;
			
			if mouse_x <= 189 && mouse_y >= y+5 {
				with obj_editor_button_parent {
					if fromTxt != "moveScene" {
						instance_destroy();
					}
				}
			}
		}
	}
	
	if relativeMouseX >= 21 && relativeMouseX <= 191 {
		if mouse_y >= y+35 + i*14 && mouse_y <= y+46 + i*14 {
			canSelectRow[i] = true;
			
			if mouse_check_button_pressed(mb_left) {
				selectRow[i] = !selectRow[i];
				actorId[i].orangeAnyways = true;
				
				if cutsceneInstanceId = -1 {
					actorId[i].spawnButtons = true;
				}
			}
		}
	}
}

// Adding actions to timeline
if addWalk {
	addWalk = false;
	
	totalActions += 1;
	actionInd[totalActions] = 0; // Walk action
	actionColor[totalActions] = make_color_rgb(113,45,95); // Violet
	actionSelect[totalActions] = false;
	actionDelete[totalActions] = false;
	
	for (i = 0; i < rows; i += 1) {
		if selectRow[i] {
			actionTime[totalActions] = rowLength[i]; // Number of 1/5 seconds on timeline
			actionRowInd[totalActions] = i; // Which row it's placed on
			actionRowId[totalActions] = actorTxt[i]; // The corresponding instance_id as a string
			
			break;
		}
	}
}

if addRotate {
	addRotate = false;
	
	totalActions += 1;
	actionInd[totalActions] = 1; // Rotate action
	actionColor[totalActions] = make_color_rgb(57,113,43); // Violet
	actionSelect[totalActions] = false;
	actionDelete[totalActions] = false;
	
	for (i = 0; i < rows; i += 1) {
		if selectRow[i] {
			actionTime[totalActions] = rowLength[i]; // Number of 1/5 seconds on timeline
			actionRowInd[totalActions] = i; // Which row it's placed on
			actionRowId[totalActions] = actorTxt[i]; // The corresponding instance_id as a string
			
			break;
		}
	}
}

if addDialogue {
	addDialogue = false;
	
	totalActions += 1;
	actionInd[totalActions] = 2; // Dialogue action
	actionColor[totalActions] = make_color_rgb(113,84,45); // Violet
	actionSelect[totalActions] = false;
	actionDelete[totalActions] = false;
	
	for (i = 0; i < rows; i += 1) {
		if selectRow[i] {
			actionTime[totalActions] = rowLength[i]; // Number of 1/5 seconds on timeline
			actionRowInd[totalActions] = i; // Which row it's placed on
			actionRowId[totalActions] = actorTxt[i]; // The corresponding instance_id as a string
			
			break;
		}
	}
}

// Calculating length of timeline
longestRowLength = 0;

if totalActions > 0 {
	for (i = 1; i <= rows; i += 1) {
		rowLength[i] = 0;
		
		for (j = 1; j <= totalActions; j += 1) {
			if actionRowInd[j] = i {
				if actionInd[j] != -1 {
					// Length of each row
					if actionTime[j] + 1 > rowLength[i] {
						rowLength[i] = actionTime[j] + 1;
					}
				
					// Longest row
					if rowLength[i] > longestRowLength {
						longestRowLength = rowLength[i];
					}
				}
			}
		}
	}
}

panelWidth = longestRowLength * 6 + 1;

// Minimum length
if panelWidth < 193 {
	panelWidth = 193;
	scrollPanelHorDefined = false;
} else {
	scrollPanelHorDefined = true;
}

// Drag actions
for (i = 1; i <= totalActions; i += 1) {
	for (j = 0; j < rows; j += 1) {
		if mouse_x >= actionTime[i]*6 + 193-scrollOffAction && mouse_x <= actionTime[i]*6 + 198-scrollOffAction {
			if mouse_y >= 454 + j*14 && mouse_y <= 464 + j*14 {
				if mouse_x >= 192 {
					if actionInd[i] != -1 {
						if actionRowInd[i] = j {
							if mouse_check_button_pressed(mb_left) {
								actionSelect[i] = true;
							}
							if mouse_check_button(mb_right) {
								actionDelete[i] = true;
							}
						}
					}
				}
			} else {
				if actionRowInd[i] = j {
					actionDelete[i] = false;
				}
			}
		} else { actionDelete[i] = false; }
		
		actionColorDraw[i] = actionColor[i]; // Default color
		
		if actionSelect[i] {
			actionColorDraw[i] = c_orange;
			actionTimeTemp = actionTime[i];
			
			for (a = 1; a <= totalActions; a += 1) {
				if actionRowInd[a] = actionRowInd[i] {
					if actionInd[a] != -1 {
						if actionTime[a] = floor((mouse_x-193+scrollOffAction)/6) {
							actionTime[i] = actionTimeTemp; // Prevent the actions from overlapping
							
							break;
						}
					}
				}
				
				if a = totalActions {
					actionTime[i] = floor((mouse_x-193+scrollOffAction)/6); // Drag action snapped to 1/5 second ticks
					
					if actionTime[i] < 0 {
						for (b = 1; b <= totalActions; b += 1) {
							if actionTime[b] = 0 {
								actionTime[i] = actionTimeTemp; // Dragging boundary
								
								break;
							}
							
							if b = totalActions {
								actionTime[i] = 0;
							}
						}
					}
				}
			}
		}
		
		if actionDelete[i] {
			actionColorDraw[i] = c_orange;
			
			// Delete the action
			if mouse_check_button_released(mb_right) {
				if actionDelete[i] {
					actionInd[i] = -1; // Null action
				}
			}
		}
		
		if mouse_check_button_released(mb_left) {
			actionSelect[i] = false; // Deselect
		}
	}
}

// Target cutscene
if cutsceneInstanceId != -1 {
	if instance_exists(cutsceneInstanceId) {
		if !cutsceneInstanceId.select {
			for (i = 0; i < rows; i += 1) {
				cutsceneInstanceId.rowLength[i] = self.rowLength[i];
				rowLength[i] = 0;
			}
			for (j = 1; j <= self.totalActions; j += 1) {
				cutsceneInstanceId.totalActions = self.totalActions;
				cutsceneInstanceId.actionInd[j] = self.actionInd[j];
				cutsceneInstanceId.actionColor[j] = self.actionColor[j];
				cutsceneInstanceId.actionSelect[j] = false;
				cutsceneInstanceId.actionDelete[j] = false;
				cutsceneInstanceId.actionTime[j] = self.actionTime[j];
				cutsceneInstanceId.actionRowInd[j] = self.actionRowInd[j];
				cutsceneInstanceId.actionRowId[j] = self.actionRowId[j];
				cutsceneInstanceId.longestRowLength = self.longestRowLength;
				
				actionInd[j] = -1;
			}
			
			totalActions = 0;
			cutsceneInstanceId = -1;
		}
	} else {
		// Clear interface when trigger instance is deleted while selected
		for (i = 0; i <= self.rows; i += 1) {
			rowLength[i] = 0;
		}
		for (j = 1; j <= self.totalActions; j += 1) {
			actionInd[j] = -1;
		}
		
		cutsceneInstanceId = -1;
	}
} else {
	for (i = 0; i < instance_number(obj_trigger_dialogue_region_editor); i += 1) {
		if instance_find(obj_trigger_dialogue_region_editor,i).select {
			cutsceneInstanceId = instance_find(obj_trigger_dialogue_region_editor,i).id;
			
			for (i = 0; i < rows; i += 1) {
				rowLength[i] = cutsceneInstanceId.rowLength[i];
			}
			
			for (j = 1; j <= cutsceneInstanceId.totalActions; j += 1) {
				totalActions = cutsceneInstanceId.totalActions;
				actionInd[j] = cutsceneInstanceId.actionInd[j];
				actionColor[j] = cutsceneInstanceId.actionColor[j];
				actionSelect[j] = cutsceneInstanceId.actionSelect[j];
				actionDelete[j] = cutsceneInstanceId.actionDelete[j];
				actionTime[j] = cutsceneInstanceId.actionTime[j];
				actionRowInd[j] = cutsceneInstanceId.actionRowInd[j];
				actionRowId[j] = cutsceneInstanceId.actionRowId[j];
				longestRowLength = cutsceneInstanceId.longestRowLength;
			}
			
			break;
		}
	}
}

// Scrollbars
scrollHorFactor = (scrollHorRightBound - scrollHorLeftBound) / panelWidth;
scrollVerFactor = botPanelY / panelHeight;

if scrollHorFactor > 1 {
	scrollHorFactor = 1;
}
if scrollVerFactor > 1 {
	scrollVerFactor = 1;
}

// Scrolling
if relativeMouseX >= scrollHorLeftBound && relativeMouseX <= scrollHorRightBound {
	if mouse_y >= y + 4 && mouse_y <= 576 {
		if mouse_wheel_up() {
			if keyboard_check(vk_shift) {
				if scrollHorPartition < 100 - 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2) {
					scrollHorPartition += 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2);
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
				if scrollHorPartition > 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2) {
					scrollHorPartition -= 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2);
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

// Boundaries
if y < 300 {
	y = 300;
}
if y > 576 {
	y = 576;
}

scrollHorTopBound = y+4;
scrollHorBotBound = y+19;

scrollVerTopBound = y+34;
botPanelY = scrollVerBotBound - scrollVerTopBound;

// Select scroll bars
if relativeMouseX >= scrollHorX && relativeMouseX <= scrollHorX + scrollHorWidth {
	if mouse_y >= scrollHorTopBound && mouse_y <= scrollHorBotBound {
		if mouse_check_button_pressed(mb_left) && !select {
			scrollHorSelect = true;
			scrollHorSelectOff = relativeMouseX - scrollHorX;
		}
	}
}
if relativeMouseX >= scrollVerLeftBound && relativeMouseX <= scrollVerRightBound {
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
		scrollHorPartition = (scrollHorX - scrollHorLeftBound) / ((scrollHorRightBound - scrollHorLeftBound) - scrollHorWidth) * 100;
		
		if scrollHorX < scrollHorLeftBound {
			scrollHorX = scrollHorLeftBound;
			scrollHorPartition = 0;
		}
		if scrollHorX + scrollHorWidth > scrollHorRightBound {
			scrollHorX = scrollHorRightBound - scrollHorWidth;
			scrollHorPartition = 100;
		}
	}
} else {
	// Adapt to moving panel
	scrollHorX = scrollHorLeftBound + (scrollHorPartition/100) * ((scrollHorRightBound - scrollHorLeftBound) - scrollHorWidth);
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

scrollHorWidth = (scrollHorFactor) * (scrollHorRightBound - scrollHorLeftBound);
scrollVerHeight = (scrollVerFactor) * botPanelY;

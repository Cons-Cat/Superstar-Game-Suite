/// @description Insert description here
baseY = 420;
//relativeMouseX = mouse_x % 1024;
relativeMouseX = window_view_mouse_get_x(1);
relativeMouseY = window_view_mouse_get_y(1);
x = 512;

if relativeMouseX <= x + 60 && relativeMouseX >= x - 60 {
	if relativeMouseY >= y - 21 && relativeMouseY <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = relativeMouseY - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToY = round((relativeMouseY - mouseClickOff + 1) / 10) * 10 + 1;
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
	dragY = relativeMouseY - mouseClickOff;
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

// Adding actions to timeline
if addClick != -1 {
	totalActions += 1;
	actionSelect[totalActions] = false;
	actionDelete[totalActions] = false;
	
	for (i = 0; i < rows; i += 1) {
		if selectRow[i] {
			actionTime[totalActions] = rowLength[i]; // Number of 1/10'th seconds on timeline
			actionRowInd[totalActions] = i; // Which row it's placed on
			actionRowId[totalActions] = actorTxt[i]; // The corresponding instance_id as a string
		
			break;
		}
		
		if i = rows - 1 {
			// Cancel button input if no row is selected
			totalActions -= 1;
		}
	}
	
	if addClick = 0 {
		actionInd[totalActions] = 0; // Walk action
		actionColor[totalActions] = make_color_rgb(113,45,95); // Violet
		
		if !instance_exists(obj_cutscene_actor_getter_walk_target) {
			with instance_create_layer(0,0,"Instances",obj_cutscene_actor_getter_walk_target) {
				timeIndex = other.totalActions;
				rowIndex = other.i;
				canPlace = true;
				
				with other.actorId[other.i] {
					other.zfloor = self.zfloor;
					other.originX[0] = self.x + 10;
					other.originY[0] = self.y + 10;
				}
			}
		}
	}
	
	if addClick = 1 {
		actionInd[totalActions] = 1; // Rotate action
		actionColor[totalActions] = make_color_rgb(57,113,43); // Violet
		
		if !instance_exists(obj_cutscene_actor_getter_rotate_target) {
			with instance_create_layer(0,0,"Instances",obj_cutscene_actor_getter_rotate_target) {
				timeIndex = other.totalActions;
				rowIndex = other.i;
				canPlace = true;
				angle = 0;
				run = 0;
				rise = 0;
				mirror = 0;
				flip = 0;
				
				with other.actorId[other.i] {
					other.zfloor = self.zfloor;
					other.originX[0] = self.x + 10;
					other.originY[0] = self.y + 10;
				}
			}
		}
	}
	
	if addClick = 2 {
		actionInd[totalActions] = 2; // Dialogue action
		actionColor[totalActions] = make_color_rgb(113,84,45); // Violet
		
		if !instance_exists(obj_cutscene_actor_getter_dialogue) {
			with instance_create_layer(actorId[i].x,actorId[i].y-42,"Instances",obj_cutscene_actor_getter_dialogue) {
				timeIndex = other.totalActions;
				rowIndex = other.i;
				trg = other.actorId[other.i];
				zfloor = trg.zfloor;
				width = 6;
				height = 3;
				
				placex = xstart - width*5;
				placey = ystart;
			}
		}
	}
	
	if addClick = 3 {
		actionInd[totalActions] = 3; // Camera pan action
		actionColor[totalActions] = make_color_rgb(65,160,160); // Violet
		
		if !instance_exists(obj_cutscene_actor_getter_pan) {
			with instance_create_layer(cutsceneInstanceId.x-10,cutsceneInstanceId.y-2,"Instances",obj_cutscene_actor_getter_pan) {
				timeIndex = other.totalActions;
				trg = other.cutsceneInstanceId;
				selectState = 1;
				pointX = trg.x + 10;
				pointY = trg.y + 10;
				zfloor = trg.zfloor;
				panMagnitude = 10;
				easeInVal = 10;
				easeInSliderVal = easeInVal;
				easeOutVal = 10;
				easeOutSliderVal = easeOutVal;
				
				valPass[0] = panMagnitude;
				valPass[1] = easeInVal;
				valPass[2] = easeOutVal;
				
				for (j = 0; j <= 3; j += 1) {
					for (i = 0; i <= 2; i += 1) {
						if j = 0 {
							val[j,i] = 1;
						} else {
							val[j,i] = 0;
						}
					}
				}
			}
		}
	}
	
	if addClick = 5 {
		actionInd[totalActions] = 5; // Walk speed action
		actionColor[totalActions] = make_color_rgb(163,178,0); // Light green
		
		if !instance_exists(obj_cutscene_actor_getter_speed) {
			with instance_create_layer(actorId[i].x+10,actorId[i].y-35,"Instances",obj_cutscene_actor_getter_speed) {
				timeIndex = other.totalActions;
				rowIndex = other.i;
				canPlace = true;
				
				trg = other.cutsceneInstanceId;
				zfloor = trg.zfloor;
				
				slowSpd = true; // Default to slow speed
			}
		}
	}
	
	if addClick = 6 {
		actionInd[totalActions] = 6; // Arbitrary action
		actionColor[totalActions] = make_color_rgb(194,94,152); // Cute magenta
		
		if !instance_exists(obj_cutscene_actor_getter_arbitrary) {
			with instance_create_layer(actorId[i].x+10,actorId[i].y-35,"Instances",obj_cutscene_actor_getter_arbitrary) {
				timeIndex = other.totalActions;
				rowIndex = other.i;
				
				trg = other.cutsceneInstanceId;
				zfloor = trg.zfloor;
				
				arbitraryInd = 0;
				selected = false;
			}
		}
	}
	
	addClick = -1;
}

// Managing selection
for (i = 0; i < rows; i += 1) {
	if i = 0 {
		if instance_exists(obj_trigger_dialogue_region_editor) {
			actorId[i] = obj_trigger_dialogue_region_editor.id;
		} else {
			actorId[i] = -1;
		}
		
		actorTxt[i] = "obj_player";
	} else {
		if instance_number(obj_npc_position) = rows - 1 {
			actorId[i] = instance_find(obj_npc_position,i - 1);
			actorTxt[i] = actorId[i].instId1[0];
		}
	}
	
	canSelectRow[i] = false;
	
	if mouse_check_button_pressed(mb_left) {
		if !(mouse_x >= 0 && mouse_x <= 190 && mouse_y >= y+5 && mouse_y <= y+29) {
			selectRow[i] = false;
			
			if !instance_exists(obj_cutscene_actor_getter_target_parent) {
				actorId[i].orangeAnyways = false;
			}
			
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

// Calculating length of timeline
longestRowLength = 0;

if totalActions > 0 {
	for (i = 0; i <= rows; i += 1) {
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
								actorId[j].orangeAnyways = true;
								selectRow[j] = true;
								
								actionDoubleClick += 1;
								alarm[1] = 12;
								
								if actionDoubleClick = 2 {
									// Open action's interface
									if actionInd[i] = 0 {
										// Walk action
										if !instance_exists(obj_cutscene_actor_getter_walk_target) {
											with instance_create_layer(xNode[i],yNode[i],"Instances",obj_cutscene_actor_getter_walk_target) {
												timeIndex = other.i
												rowIndex = other.j;
												canDrag = true;
												canPlace = false;
												
												with other.actorId[other.j] {
													other.zfloor = self.zfloor;
													other.originX[0] = self.x+10;
													other.originY[0] = self.y+10;
												}
											}
										}
									}
									
									if actionInd[i] = 1 {
										// Rotate action
										if !instance_exists(obj_cutscene_actor_getter_rotate_target) {
											with instance_create_layer(actorId[j].x+10,actorId[j].y+10,"Instances",obj_cutscene_actor_getter_rotate_target) {
												timeIndex = other.i;
												rowIndex = other.j;
												canDrag = true;
												canPlace = false;
												angleCalc = other.angleRot[other.i];
												run = other.runRot[other.i];
												rise = other.riseRot[other.i];
												mirror = other.mirrorRot[other.i];
												flip = other.flipRot[other.i];
												
												angleExport = angleFormConv(angleCalc,mirror,flip);
												
												with other.actorId[other.j] {
													other.zfloor = self.zfloor;
													other.originX[0] = self.x+10;
													other.originY[0] = self.y+10;
												}
											}
										}
									}
									
									if actionInd[i] = 2 {
										// Dialogue action
										if !instance_exists(obj_cutscene_actor_getter_dialogue) {
											with instance_create_layer(actorId[j].x-xOffDialogue[i],actorId[j].y-yOffDialogue[i],"Instances",obj_cutscene_actor_getter_dialogue) {
												timeIndex = other.i;
												rowIndex = other.j;
												trg = other.actorId[other.j];
												zfloor = trg.zfloor;
												width = other.dialogueWidth[other.i];
												height = other.dialogueHeight[other.i];
												textRows = other.textRows[other.i];
												placex = xstart;
												placey = ystart;
												
												for (i = 0; i < textRows; i += 1) {
													str[i] = other.str[other.i,self.i];
													selectTextRow[i] = false;
													canSelectTextRow[i] = false;
												}
											}
										}
									}
									
									if actionInd[i] = 3 {
										// Camera pan action
										if !instance_exists(obj_cutscene_actor_getter_pan) {
											with instance_create_layer(cutsceneInstanceId.x-10,cutsceneInstanceId.y-2,"Instances",obj_cutscene_actor_getter_pan) {
												timeIndex = other.i;
												trg = other.cutsceneInstanceId;
												panAngle = other.panAngle[timeIndex];
												panMagnitude = other.panMagnitude[timeIndex];
												easeInVal = other.easeInVal[timeIndex];
												easeInSliderVal = easeInVal;
												easeOutVal = other.easeOutVal[timeIndex];
												easeOutSliderVal = easeOutVal;
												
												selectState = 0;
												pointX = trg.x + 10;
												pointY = trg.y + 10;
												zfloor = trg.zfloor;
												
												valPass[0] = panMagnitude;
												valPass[1] = easeInVal;
												valPass[2] = easeOutVal;
												
												for (i = 0; i <= 2; i += 1) {
													a = 0;
													
													for (j = 0; j <= 3; j += 1) {
														if string_char_at(string_digits(string_digits(valPass[i])),j+1-a) != "" {
															val[j,i] = real(string_char_at(string_digits(valPass[i]),j+1-a));
														} else {
															val[j,i] = 0;
														}
														
														if j = 0 {
															if valPass[i] < 10 {
																// Insert a 0 if val[] is not a double-digit integer
																val[0,i] = 0;
																a = 1;
															}
														}
													}
												}
											}
										}
									}
									
									if actionInd[i] = 5 {
										// Actor speed action
										with instance_create_layer(actorId[j].x+10,actorId[j].y-35,"Instances",obj_cutscene_actor_getter_speed) {
											timeIndex = other.i;
											slowSpd = other.slowSpd[timeIndex];
											
											trg = other.cutsceneInstanceId;
											zfloor = trg.zfloor;
										}
									}
									
									actionDoubleClick = 0;
									
									if actionInd[i] = 6 {
										// Arbitrary action
										with instance_create_layer(actorId[j].x+10,actorId[j].y-35,"Instances",obj_cutscene_actor_getter_arbitrary) {
											timeIndex = other.i;
											arbitraryInd = other.arbitraryInd[timeIndex];
											
											trg = other.cutsceneInstanceId;
											zfloor = trg.zfloor;
											
											selected = true;
										}
									}
								}
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
		} else {
			actionDelete[i] = false;
		}
		
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
			// Importing handled by the script importCutscene
			
			// Export metadata
			for (i = 0; i < rows; i += 1) {
				cutsceneInstanceId.rowLength[i] = self.rowLength[i];
				cutsceneInstanceId.actorTxt[i] = self.actorTxt[i];
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
				
				if actionInd[j] = 0 { // Walk action
					cutsceneInstanceId.xNode[j] = self.xNode[j];
					cutsceneInstanceId.yNode[j] = self.yNode[j];
				}
				
				if actionInd[j] = 1 { // Rotation action
					cutsceneInstanceId.angleRot[j] = self.angleRot[j];
					cutsceneInstanceId.angleRotExport[j] = self.angleRotExport[j];
					cutsceneInstanceId.runRot[j] = self.runRot[j];
					cutsceneInstanceId.riseRot[j] = self.riseRot[j];
					cutsceneInstanceId.mirrorRot[j] = self.mirrorRot[j];
					cutsceneInstanceId.flipRot[j] = self.flipRot[j];
				}
				
				if actionInd[j] = 2 { // Dialogue action
					cutsceneInstanceId.dialogueWidth[j] = self.dialogueWidth[j];
					cutsceneInstanceId.dialogueHeight[j] = self.dialogueHeight[j];
					cutsceneInstanceId.textRows[j] = self.textRows[j];
					cutsceneInstanceId.xOffDialogue[j] = self.xOffDialogue[j];
					cutsceneInstanceId.yOffDialogue[j] = self.yOffDialogue[j];
					
					for (i = 0; i < textRows[j]; i += 1) {
						cutsceneInstanceId.dialogueStr[j,i] = other.str[j,i];
					}
				}
				
				if actionInd[j] = 3 { // Camera pan action
					cutsceneInstanceId.panAngle[j] = self.panAngle[j];
					cutsceneInstanceId.panMagnitude[j] = self.panMagnitude[j];
					cutsceneInstanceId.easeInVal[j] = self.easeInVal[j];
					cutsceneInstanceId.easeOutVal[j] = self.easeOutVal[j];
				}
				
				if actionInd[j] = 5 { // Walk speed action
					cutsceneInstanceId.slowSpd[j] = self.slowSpd[j];
				}
				
				if actionInd[j] = 6 { // Arbitrary action
					cutsceneInstanceId.arbitraryInd[j] = self.arbitraryInd[j];
				}
				
				actionInd[j] = -1;
			}
			
			totalActions = 0;
			cutsceneInstanceId = -1; // Reset target instance
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
				if scrollVerPartition > 100 / (panelHeight / botPanelY) {
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
if mouse_check_button_pressed(mb_left) && !select {
	if relativeMouseX >= scrollHorX && relativeMouseX <= scrollHorX + scrollHorWidth {
		if mouse_y >= scrollHorTopBound && mouse_y <= scrollHorBotBound {
			scrollHorSelect = true;
			scrollHorSelectOff = relativeMouseX - scrollHorX;
		}
	}
	
	if relativeMouseX >= scrollVerLeftBound && relativeMouseX <= scrollVerRightBound {
		if mouse_y >= scrollVerY && mouse_y <= scrollVerY + scrollVerHeight {
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

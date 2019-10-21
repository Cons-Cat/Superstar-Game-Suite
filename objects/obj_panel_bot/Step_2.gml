/// @description Insert description here
baseY = ( 9 * 20 * obj_editor_gui.realPortScaleVer ) + ( 60 / 576 * window_get_height() );
x = room_width + view_wport[1]/2;
relativeX = x - room_width;

if relativeMouseX <= relativeX + 60 && relativeMouseX >= relativeX - 60 {
	if relativeMouseY >= y - 21 && relativeMouseY <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = true;
			tempSubPanelLeftY = obj_subpanel_left.y;
			mouseClickOff = relativeMouseY - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if select {
	if !mouse_check_button(mb_left) {
		select = false;
		
		moveToY = round((relativeMouseY - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToY > baseY - 30 && moveToY < baseY + 30 {
			moveToY = baseY;
		}
		if moveToY >= baseY + 30 {
			moveToY = view_hport[1];
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToY - y) / 2;
		
		image_index = 0;
	}
	
	// Dragging panel
	dragY = relativeMouseY - mouseClickOff;
	dragYTemp = dragY;
	
	y = dragY;
	
	// Dragging boundary
	if y < 300 {
		y = 300;
	}
	
	// Preventing displacement of the subpanel
	if y < obj_subpanel_left.y {
		obj_subpanel_left.y = self.y;
	} else {
		obj_subpanel_left.visible = true;
		
		if obj_subpanel_left.mousePeek > 0 {
			obj_subpanel_left.mousePeek -= 3.75;
		} else {
			obj_subpanel_left.mousePeek = 0;
		}
		
		if obj_subpanel_left.y < tempSubPanelLeftY {
			obj_subpanel_left.y = self.y;
		} else {
			obj_subpanel_left.y = tempSubPanelLeftY;
		}
	}
} else {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if floor(y) != floor(baseY) {
			moveToY = baseY;
		} else {
			moveToY = view_hport[1];
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

// On base
if floor(y) = floor(baseY) {
	onBase = 1;
} else {
	onBase = 0;
}

if y = view_hport[1] {
	onBase = 2;
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
	if hasRowSelected {
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
			
			if !instance_exists(obj_cutscene_walk_target) {
				with instance_create_layer(0,0,"Instances",obj_cutscene_walk_target) {
					timeIndex = other.totalActions;
					rowIndex = other.i;
					canPlace = true;
					canRelease = false;
					
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
			actionColor[totalActions] = make_color_rgb(57,113,43); // Green
			
			if !instance_exists(obj_cutscene_rotate_target) {
				with instance_create_layer(0,0,"Instances",obj_cutscene_rotate_target) {
					timeIndex = other.totalActions;
					rowIndex = other.i;
					canPlace = true;
					canRelease = false;
					placed = false;
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
			actionColor[totalActions] = make_color_rgb(113,84,45); // Gold
			
			if !instance_exists(obj_cutscene_dialogue) {
				with instance_create_layer(actorId[i].x,actorId[i].y-42,"Instances",obj_cutscene_dialogue) {
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
			actionColor[totalActions] = make_color_rgb(65,160,160); // Cyan
			
			if !instance_exists(obj_cutscene_pan) {
				with instance_create_layer(cutsceneInstanceId.x+10,cutsceneInstanceId.y+10,"Instances",obj_cutscene_pan) {
					timeIndex = other.totalActions;
					trg = other.cutsceneInstanceId;
					zoomVal = "100";
					//decimalPlace = -1;
				}
			}
		}
		
		/*if addClick = 4 {
			actionInd[totalActions] = 4; // Camera zoom action
			actionColor[totalActions] = make_color_rgb(23,79,124); // Deep blue
			
			if !instance_exists(obj_cutscene_zoom) {
				with instance_create_layer(cutsceneInstanceId.x-10,cutsceneInstanceId.y-2,"Instances",obj_cutscene_zoom) {
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
		}*/
		
		if addClick = 5 {
			actionInd[totalActions] = 5; // Walk speed action
			actionColor[totalActions] = make_color_rgb(163,178,0); // Light green
			
			if !instance_exists(obj_cutscene_speed) {
				with instance_create_layer(actorId[i].x+10,actorId[i].y-35,"Instances",obj_cutscene_speed) {
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
			
			if !instance_exists(obj_cutscene_arbitrary) {
				with instance_create_layer(actorId[i].x+10,actorId[i].y-35,"Instances",obj_cutscene_arbitrary) {
					timeIndex = other.totalActions;
					rowIndex = other.i;
					
					trg = other.cutsceneInstanceId;
					zfloor = trg.zfloor;
					
					arbitraryInd = 0;
					selected = false;
				}
			}
		}
	}
	
	addClick = -1;
}

// Managing selection
for (i = 0; i < rows; i += 1) {
	if i = 0 {
		if instance_exists(obj_trigger_cutscene_region_editor) {
			actorId[i] = obj_trigger_cutscene_region_editor.id;
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
	
	if mouse_check_button_pressed(mb_left) {
		if !(relativeMouseX >= 0 && relativeMouseX <= obj_panel_left.x && relativeMouseY >= obj_subpanel_left.y && relativeMouseY <= obj_subpanel_left.scrollVerBotBound) && !obj_subpanel_left.select && !obj_panel_left.select {
			if !canSelectRow[i] {
				selectRow[i] = false;
				hasRowSelected = false;
				
				if !instance_exists(obj_cutscene_target_parent) {
					actorId[i].orangeAnyways = false;
				}
				
				if relativeMouseX <= 189 && relativeMouseY >= y+5 {
					with obj_editor_button_parent {
						if fromTxt != "moveScene" {
							instance_destroy();
						}
					}
				}
			}
		}
	}
	
	canSelectRow[i] = false;
	
	if relativeMouseX >= 21 && relativeMouseX <= 191 {
		if relativeMouseY >= y+35 + i*14 && relativeMouseY <= y+46 + i*14 {
			canSelectRow[i] = true;
			
			if mouse_check_button_pressed(mb_left) {
				selectRow[i] = !selectRow[i];
				actorId[i].orangeAnyways = true;
				hasRowSelected = true;
				
				if cutsceneInstanceId = -1 {
					if actorId[i].select {
						actorId[i].spawnButtons = true;
					}
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

panelWidth = longestRowLength*6 + 2;

// Minimum length
if panelWidth < view_wport[1] - 386 {
	panelWidth = view_wport[1] - 386;
}

// Drag actions
cameraNetX = camera_get_view_x(obj_editor_gui.cameraBotPanel) - (camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) ) - view_wport[5] - obj_subpanel_left.longestPanelRightButton;
potentialActionTime = floor( (relativeMouseX - 193 + cameraNetX) / 6);
ax = ( ((scrollHorX - 193 - room_width) / (scrollHorRightBound - scrollHorLeftBound)) * panelWidth ) + 1;

for (i = 1; i <= totalActions; i += 1) {
	for (j = 0; j < rows; j += 1) {
		if relativeMouseX > 194 - ax + actionTime[i]*6 && relativeMouseX <= 193 - ax + actionTime[i]*6 + 6 {
			if relativeMouseY >= y + 34 + j*14 && relativeMouseY <= y + 44 + j*14 {
				if relativeMouseX >= 192 {
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
										if !instance_exists(obj_cutscene_walk_target) {
											with instance_create_layer(xNode[i],yNode[i],"Instances",obj_cutscene_walk_target) {
												timeIndex = other.i
												rowIndex = other.j;
												canDrag = true;
												canPlace = false;
												
												with other.actorId[other.j] {
													other.zfloor = self.zfloor;
													other.originX[0] = self.x + 10;
													other.originY[0] = self.y + 10;
												}
											}
										}
									}
									
									if actionInd[i] = 1 {
										// Rotate action
										if !instance_exists(obj_cutscene_rotate_target) {
											with instance_create_layer(actorId[j].x+10,actorId[j].y+10,"Instances",obj_cutscene_rotate_target) {
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
										if !instance_exists(obj_cutscene_dialogue) {
											with instance_create_layer(actorId[j].x-xOffDialogue[i],actorId[j].y-yOffDialogue[i],"Instances",obj_cutscene_dialogue) {
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
										if !instance_exists(obj_cutscene_pan) {
											with instance_create_layer(xNode[i],yNode[i],"Instances",obj_cutscene_pan) {
												timeIndex = other.i;
												trg = other.cutsceneInstanceId;
												zoomVal = string(other.zoomVal[timeIndex]);
											}
										}
									}
									
									if actionInd[i] = 5 {
										// Actor speed action
										with instance_create_layer(actorId[j].x+10,actorId[j].y-35,"Instances",obj_cutscene_speed) {
											timeIndex = other.i;
											slowSpd = other.slowSpd[timeIndex];
											
											trg = other.cutsceneInstanceId;
											zfloor = trg.zfloor;
										}
									}
									
									actionDoubleClick = 0;
									
									if actionInd[i] = 6 {
										// Arbitrary action
										with instance_create_layer(actorId[j].x+10,actorId[j].y-35,"Instances",obj_cutscene_arbitrary) {
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
						if actionTime[a] = potentialActionTime {
							actionTime[i] = actionTimeTemp; // Prevent the actions from overlapping
							
							break;
						}
					}
				}
				
				if a = totalActions {
					actionTime[i] = potentialActionTime; // Drag action snapped to 1/5 second ticks
					
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
				
				if actionInd[j] = 3 { // Camera action
					cutsceneInstanceId.xNode[j] = self.xNode[j];
					cutsceneInstanceId.yNode[j] = self.yNode[j];
					cutsceneInstanceId.zoomVal[j] = self.zoomVal[j];
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

// Minimap surface
/*if remakeMap {
	mapSurface = surface_create(room_width,room_height);
	updateMap = true;
}

if updateMap {
	updateMap = false;
	// var trg;
	
	// Clear the surface
	surface_set_target(mapSurface);
	draw_clear_alpha(c_white, 0);
	surface_reset_target();
	
	for (var k = 0; k < instance_number(obj_editor_terrain_par); k +=1) {
		var trg = instance_find(obj_editor_terrain_par,k);
		
		if surface_exists( trg.tileSurfaceDraw ) {
			// Add collision tiles to the map
			surface_copy( mapSurface, trg.x, trg.y, trg.tileSurfaceDraw );
		} else {
			// Skip a tick to make sure the surface exists before drawing to map
			// I suspect that this may not be working
			updateMap = true;
			
			break;
		}
	}
}*/

// Views
view_xport[4] = 193;
view_yport[4] = y + 34;
view_wport[4] = view_wport[1] - 384;
view_hport[4] = view_hport[1] - y - 34;

camera_set_view_pos(obj_editor_gui.cameraBotPanel,camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + view_wport[5] + ( ((scrollHorX - 193 - room_width) / (scrollHorRightBound - scrollHorLeftBound)) * panelWidth + longestPanelRightButton),0);
camera_set_view_size(obj_editor_gui.cameraBotPanel,view_wport[4],view_hport[4]);

if y >= view_hport[1] {
	y = view_hport[1];
	view_visible[4] = false;
} else {
	view_visible[4] = true;
}

// Scroll bars
scrollHorLeftBound = room_width + 192;
scrollHorRightBound = room_width + view_wport[1] - 192
scrollHorTopBound = y+4;
scrollHorBotBound = y+19;

scrollVerLeftBound = room_width;
scrollVerRightBound = room_width + 16;
scrollVerTopBound = y+34;
scrollVerBotBound = view_hport[1] - 3;
botPanelY = scrollVerBotBound - scrollVerTopBound;

event_inherited();

if !visible {
	view_set_visible(4,false);
}

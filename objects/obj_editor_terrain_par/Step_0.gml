/// @description Manipulating dimensions and place
if obj_editor_gui.mode = modeForSelectVal {
	modeForSelect = true;
} else {
	modeForSelect = false;
}

mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;
relativeMouseX = window_mouse_get_x();
relativeMouseY = window_mouse_get_y();

if placed != 0 {
	// canSelect defined by obj_editor_gui
	// De-selection handled by obj_editor_button_parent
	if canSelect { // If an instance is hovered over
		if modeForSelect {
			if obj_editor_gui.mode = 4 {
				// Trigger instances
				if mouse_check_button_pressed(mb_left) && !instance_exists(obj_editor_button_parent) {
					canSpawnButtons = true;
					
					select = true;
					buttonSelected = 1;
					obj_editor_gui.canChangeSelect = false;
					
					// Slide sub-panel in
					obj_subpanel_left.tempY = obj_subpanel_left.y;
					obj_subpanel_left.moveDirection = 1;
					obj_subpanel_left.moveToY = obj_panel_bot.y;
					obj_subpanel_left.moveToSpd = (obj_panel_bot.y - obj_subpanel_left.y)/6.5;
					
					// Standard formula to solve for time, given speed and distance
					// +5 is a pause to dramatize the motion
					obj_subpanel_left.alarm[1] = abs(obj_panel_bot.y - obj_subpanel_left.y) / obj_subpanel_left.moveToSpd + 5;
					
					alarm[1] = obj_subpanel_left.alarm[1];
				}
			} else if obj_editor_gui.mode = 3 {
				// Tiling for collisions instances
				if mouse_check_button_pressed(mb_left) {
					if modeForSelect = 0 || modeForSelect = 1 {
						canSpawnTiles = true;
						
						// Slide side panels in
						if obj_panel_left.moveToSpd = 0 && obj_panel_right.moveToSpd = 0 {
							global.tempXLeft = obj_panel_left.x;
							global.tempXRight = obj_panel_right.x;
						}
						
						
						obj_panel_right.exitInterface = true;
						obj_panel_left.exitInterface = true;
										
						alarm[1] = 18;
					}
				}
			} else {
				// Collision instances
				if mouse_check_button_pressed(mb_left) && !instance_exists(obj_editor_button_parent) {
					spawnButtons = true; // Button instances are spawned by child objects
					
					select = true;
					buttonSelected = 1;
					obj_editor_gui.canChangeSelect = false;
				}
			}
		}
	} else {
		if window_mouse_get_y() > obj_panel_top.y && !obj_panel_top.canSelect {
			if window_mouse_get_x() > obj_panel_left.x - room_width && !obj_panel_left.canSelect {
				if window_mouse_get_x() < obj_panel_right.x - room_width && !obj_panel_right.canSelect {
					if window_mouse_get_y() < obj_panel_bot.y && !obj_panel_bot.canSelect {
						if mouse_check_button_pressed(mb_left) {
							// De-select tiles
							if obj_editor_gui.mode = 3 {
								canSpawnTiles = false;
								
								obj_panel_right.exitInterface = true;
								obj_panel_left.exitInterface = true;
								
								alarm[1] = 18;
							}
						}
					}
				}
			}
		}
	}
	
	if !select {
		exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[0]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		//exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId3+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		
		/*if str != "moveScene" && str != "actor" {
			exportStringSideF = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[0]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor+height-1)*20)+"},");
			exportStringSideB = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[3]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringSideL = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[1]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringSideR = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[2]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x+(width-1)*20)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringFloor = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[4]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[1]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		}*/
	}
}

// Spawn tile buttons
if spawnTiles {
	spawnTiles = false;
	
	// Spawn tiles GUI
	if str = "rectangle" {
		#region
		
		for (i = 0; i < width + 2; i += 1) {
			for (j = 0; j < zfloor - zcieling + 2; j += 1) {
				with instance_create_layer(camera_get_view_x(obj_editor_gui.cameraLeftPanel) + 2 + i*21,j*21,"Instances",obj_tiles_grid) {
					trgId = other.id;
					i = other.i;
					j = other.j;
					width = other.width;
					tileDrawSpr = other.tileDrawSpr;
					tileRowWidth = other.width + 2;
					tileLayerCount = other.tileLayerCount;
					
					for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
						hasTile[k] = other.hasTile[scr_array_xy(i,j,tileRowWidth),k];
						hasTile[k+1] = other.hasTile[scr_array_xy(i,j,tileRowWidth),k+1];
						hasTileDraw[k] = other.hasTile[scr_array_xy(i,j,tileRowWidth),k];
						hasTileDraw[k+1] = other.hasTile[scr_array_xy(i,j,tileRowWidth),k+1];
						
						layerVisible[k] = other.layerVisible[k];
						layerVisibleDraw[k] = other.layerVisible[k];
						
						layerOrder[k] = other.layerOrder[k];
						layerType[k] = other.layerType[k];
						
						// Pass in tiles
						if hasTile[k] {
							xVal[k] = other.tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k];
							yVal[k] = other.tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k];
							
							xValDraw[k] = xVal[k];
							yValDraw[k] = yVal[k];
						}
						
						if hasTile[k+1] {
							xVal[k+1] = other.tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1];
							yVal[k+1] = other.tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1];
								
							xValDraw[k+1] = xVal[k+1];
							yValDraw[k+1] = yVal[k+1];
						}
						
						// Pass in layer names
						layerName[k] = other.layerName[k];
						layerName[k+1] = other.layerName[k+1];
					}
				}
			}
		}
		
		obj_panel_left.panelWidth = i * 21;
		obj_panel_left.panelHeight = j * 21;
		
		#endregion
	}
	
	// Spawn tiles GUI (slope 1)
	if str = "slope1" {
		#region
		
		for (i = 0; i < width + 2; i += 1) {
			for (j = zfloor + 1; j >= zcieling; j -= 1) {
				if !(i = 0 && j = zcieling) && !(i = width + 1 && j = zfloor + 1) {
					with instance_create_layer(1026 + i * 21,86 + (zfloor + 1)*21 - j*21,"Instances",obj_tiles_grid) {
						trgId = other.id;
						i = other.i;
						j = other.j;
						tileDrawSpr = other.tileDrawSpr;
						xVal = other.tileArrayDrawX[i,j];
						yVal = other.tileArrayDrawY[i,j];
					}
				}
			}
		}
		
		obj_panel_left.panelWidth = i * 21;
		obj_panel_left.panelHeight = (zfloor + 1 - zcieling) * 21;
		
		#endregion
	}
	
	// Spawn tiles GUI (slope 2)
	if str = "slope2" {
		#region
		
		for (i = 0; i <= width + 2; i += 1) {
			for (j = zfloor + 1; j >= zcieling; j -= 1) {
				with instance_create_layer(1026 + i * 21,86 + (zfloor + 1)*21 - j*21,"Instances",obj_tiles_grid) {
					trgId = other.id;
					i = other.i;
					j = other.j;
					tileDrawSpr = other.tileDrawSpr;
					xVal = other.tileArrayDrawX[i,j];
					yVal = other.tileArrayDrawY[i,j];
				}
			}
		}
		
		obj_panel_left.panelWidth = i * 21;
		obj_panel_left.panelHeight = (zfloor + 1 - zcieling) * 21;
		
		#endregion
	}
	
	// Spawn tiles GUI (slope 3)
	if str = "slope3" {
		#region
		
		for (i = 0; i <= width + 2; i += 1) {
			for (j = zfloor + 2; j >= zcieling; j -= 1) {
				with instance_create_layer(1026 + i*21,86 + (zfloor + 2)*21 - j*21,"Instances",obj_tiles_grid) {
					trgId = other.id;
					i = other.i;
					j = other.j;
					tileDrawSpr = other.tileDrawSpr;
					xVal = other.tileArrayDrawX[i,j];
					yVal = other.tileArrayDrawY[i,j];
				}
			}
		}
		
		obj_panel_left.panelWidth = i * 21;
		obj_panel_left.panelHeight = (zfloor + 2 - zcieling) * 21;
		
		#endregion
	}
	
	// Spawn tiles GUI (staircase)
	if str = "staircase" {
		#region
		
		for (i = 0; i < widthIterate; i += 1) {
			for (j = heightIterate; j >= zfloor; j -= 1) {
				with instance_create_layer(1026 + i*21,86 + heightIterate*21 - j*21,"Instances",obj_tiles_grid) {
					trgId = other.id;
					i = other.i;
					j = other.j;
					tileDrawSpr = other.tileDrawSpr;
					xVal = other.tileArrayDrawX[i,j];
					yVal = other.tileArrayDrawY[i,j];
				}
			}
		}
		
		obj_panel_left.panelWidth = i * 21;
		obj_panel_left.panelHeight = heightIterate * 21;
		
		#endregion
	}
	
	// Right panel dimensions match the tileset's dimensions
	obj_panel_right.panelWidth = sprite_get_width(tileDrawSpr);
	
	if sprite_get_height(tileDrawSpr) <= 334 {
		obj_panel_right.scrollPanelVerDefined = false;
		obj_panel_right.panelHeight = 0;
	} else {
		obj_panel_right.scrollPanelVerDefined = true;
		obj_panel_right.panelHeight = sprite_get_height(tileDrawSpr);
	}
	
	if !instance_exists(obj_tiles_sheet) {
		// Open menu
		with instance_create_layer(room_width,0,"Instances",obj_tiles_sheet) {
			tileDefaultSpr = other.tileDrawSpr;
		}
		
		with instance_create_layer(room_width,0,"Instances",obj_tiles_layers) {
			trgId = other.id;
			tileLayerCount = other.tileLayerCount;
			tileDefaultSpr = other.tileDefaultSpr;
			
			for (i = 0; i <= tileLayerCount; i += 2) {
				layerOrder[i] = other.layerOrder[i];
				layerVisible[i] = other.layerVisible[i];
				
				layerName[i] = other.layerName[i];
				layerName[i+1] = other.layerName[i+1];
				
				eyeState[i] = 0;
				eyeCol[i] = col;
				
				select[i] = false;
				canSelect[i] = false;
				
				select[i+1] = false;
				canSelect[i+1] = false;
				
				layerAlpha[i] = 1;
				layerType[i] = other.layerType[i];
			}
		}
	}
	
	canSpawnButtons = false;
}

// Placing in the level
if placed = 0 {
	x = (mouseCheckX div global.snapDimension) * global.snapDimension;
	y = (mouseCheckY div global.snapDimension) * global.snapDimension;
}

if mouse_check_button_released(mb_left) {
	if placed = 0 {
		lastX = x;
		lastY = y;
		
		canMerge = true; // Merge upon placement
		obj_editor_gui.canChangeSelect = true;
		
		placed = 1;
	}
}

image_xscale = width;
image_yscale = height + zfloor - zcieling;

// Terrain collision height and alpha
if finite {
	zplace = zfloor;
	alpha = 1;
} else {
	zplace = 20000;
	alpha = 0.25;
}

// Make orange when mouse hovers over it
if !canSelect {
	if finite {
		layerColor = blankCol;
	} else {
		layerColor = blankColDark;
	}
} else {
	layerColor = c_orange;
}

/// @description Manipulating dimensions and place
if obj_editor_gui.mode = modeForSelectVal {
	modeForSelect = true;
} else {
	modeForSelect = false;
}

if placed = 1 {
	if canSelect {
		if mouse_y > obj_panel_top.y {
			if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
				if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
					if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
						if modeForSelect {
							if obj_editor_gui.mode != 3 {
								// Dimension manipulation
								if mouse_check_button_pressed(mb_left) && !instance_exists(obj_editor_button_parent) {
									spawnButtons = true; // Button instances are created from child objects
									
									select = 1;
									buttonSelected = 1;
									obj_editor_gui.canChangeSelect = false;
								}
							} else {
								if mouse_check_button_pressed(mb_left) {
									// Tiling for collisions instances
									if modeForSelect = 0 || modeForSelect = 1 {
										if mouse_check_button_pressed(mb_left) {
											// Slide side panels out
											if obj_panel_left.moveToSpd = 0 && obj_panel_right.moveToSpd = 0 {
												global.tempXLeft = obj_panel_left.x;
												global.tempXRight = obj_panel_right.x;
											}
											
											// Assign values to slide side panels in
											obj_panel_left.moveToX = 0;
											obj_panel_left.moveToSpd = global.tempXLeft/4;
											obj_panel_left.moveDirection = -1;
											
											obj_panel_right.moveToX = 1024;
											obj_panel_right.moveToSpd = (1024 - global.tempXRight)/4;
											obj_panel_right.moveDirection = 1;
											
											alarm[1] = 18;
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	if select = 0 {
		exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[0]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		//exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId3+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		
		if str != "moveScene" && str != "actor" {
			exportStringSideF = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[0]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor+height-1)*20)+"},");
			exportStringSideB = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[3]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringSideL = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[1]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringSideR = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[2]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x+(width-1)*20)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
			exportStringFloor = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[4]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[1]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		}
	}
}

// Spawn tile buttons
if spawnTiles {
	if sprMaterialDirectory != "" {
		spawnTiles = false;
		
		// Spawn tiles GUI
		if str = "rectangle" {
			for (i = 0; i < width + 2; i += 1) {
				for (j = 0; j < image_yscale + 1; j += 1) {
					with instance_create_layer(1026 + i*21,86 + j*21,"Instances",obj_tiles_grid) {
						trgId = other.id;
						i = other.i;
						j = other.j;
						tempMaterial = other.sprMaterial;
						xVal = other.tileArrayDrawX[i,j];
						yVal = other.tileArrayDrawY[i,j];
					}
				}
			}
			
			obj_panel_left.panelWidth = i * 21;
			obj_panel_left.panelHeight = j * 21;
		}
		
		// Spawn tiles GUI (slope 1)
		if str = "slope1" {
			for (i = 0; i < width + 2; i += 1) {
				for (j = zfloor + 1; j >= zcieling; j -= 1) {
					if !(i = 0 && j = zcieling) && !(i = width + 1 && j = zfloor + 1) {
						with instance_create_layer(1026 + i * 21,86 + (zfloor + 1)*21 - j*21,"Instances",obj_tiles_grid) {
							trgId = other.id;
							i = other.i;
							j = other.j;
							tempMaterial = other.sprMaterial;
							xVal = other.tileArrayDrawX[i,j];
							yVal = other.tileArrayDrawY[i,j];
						}
					}
				}
			}
			
			obj_panel_left.panelWidth = i * 21;
			obj_panel_left.panelHeight = (zfloor + 1 - zcieling) * 21;
		}
		
		// Spawn tiles GUI (slope 2)
		if str = "slope2" {
			for (i = 0; i <= width + 2; i += 1) {
				for (j = zfloor + 1; j >= zcieling; j -= 1) {
					with instance_create_layer(1026 + i * 21,86 + (zfloor + 1)*21 - j*21,"Instances",obj_tiles_grid) {
						trgId = other.id;
						i = other.i;
						j = other.j;
						tempMaterial = other.sprMaterial;
						xVal = other.tileArrayDrawX[i,j];
						yVal = other.tileArrayDrawY[i,j];
					}
				}
			}
			
			obj_panel_left.panelWidth = i * 21;
			obj_panel_left.panelHeight = (zfloor + 1 - zcieling) * 21;
		}
		
		// Spawn tiles GUI (slope 3)
		if str = "slope3" {
			for (i = 0; i <= width + 1; i += 1) {
				for (j = zfloor + 2; j >= zcieling; j -= 1) {
					with instance_create_layer(1026 + i*21,86 + (zfloor + 2)*21 - j*21,"Instances",obj_tiles_grid) {
						trgId = other.id;
						i = other.i;
						j = other.j;
						tempMaterial = other.sprMaterial;
						xVal = other.tileArrayDrawX[i,j];
						yVal = other.tileArrayDrawY[i,j];
					}
				}
			}
			
			obj_panel_left.panelWidth = i * 21;
			obj_panel_left.panelHeight = (zfloor + 2 - zcieling) * 21;
		}
		
		// Spawn tiles GUI (staircase)
		if str = "staircase" {
			for (i = 0; i < widthIterate; i += 1) {
				for (j = heightIterate; j >= zfloor; j -= 1) {
					with instance_create_layer(1026 + i*21,86 + heightIterate*21 - j*21,"Instances",obj_tiles_grid) {
						trgId = other.id;
						i = other.i;
						j = other.j;
						tempMaterial = other.sprMaterial;
						xVal = other.tileArrayDrawX[i,j];
						yVal = other.tileArrayDrawY[i,j];
					}
				}
			}
			
			obj_panel_left.panelWidth = i * 21;
			obj_panel_left.panelHeight = heightIterate * 21;
		}
		
		obj_panel_right.panelWidth = sprite_get_width(global.sprMaterial);
			
		if sprite_get_height(global.sprMaterial) <= 334 {
			obj_panel_right.scrollPanelVerDefined = false;
			obj_panel_right.panelHeight = 0;
		} else {
			obj_panel_right.scrollPanelVerDefined = true;
			obj_panel_right.panelHeight = sprite_get_height(global.sprMaterial);
		}
		
		if !instance_exists(obj_tiles_sheet) {
			// Open menu
			if 1024 + (i+1) * 21 < 1800 {
				// Ensure that the tiles sheet never overlaps with the left panel view
				obj_panel_right.tilesSheetPlacement = 1800;
				instance_create_layer(1800,86,"Instances",obj_tiles_sheet);
			} else {
				// Ensure that the tiles sheet is always placed beyond the tiles grid
				obj_panel_right.tilesSheetPlacement = 1024 + (i+1) * 21;
				instance_create_layer(1024 + (i+1) * 21,86,"Instances",obj_tiles_sheet);
			}
		}
	}
	
	canSpawnButtons = false;
}

// Placing in the level
if placed = 0 {
	x = floor((mouse_x + 192 - 23) / 40) * 20 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
	y = floor((mouse_y + 576) / 40) * 20 - 320 + 36 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20 - zfloor * 20;
}

if mouse_check_button_released(mb_left) {
	if placed = 0 {
		lastX = x;
		lastY = y;
		obj_editor_gui.canChangeSelect = true;
		
		placed = 1;
	}
}

image_xscale = width;
image_yscale = height+zfloor-zcieling;

// Terrain collision height and alpha
if finite {
	zplace = zfloor;
	alpha = 1;
} else {
	zplace = 20000;
	alpha = 0.25;
}

if !canSelect {
	if finite {
		layerColor = blankCol;
	} else {
		layerColor = blankColDark;
	}
} else {
	layerColor = c_orange;
}

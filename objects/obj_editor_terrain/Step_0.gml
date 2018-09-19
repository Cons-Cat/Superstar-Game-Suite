/// @description Manipulating dimensions
if placed = 1 {
	if !instance_exists(obj_editor_button_parent) {
		if mouse_x >= self.x && mouse_x < self.x+width*20 && ((obj_editor_gui.mode = 0 || obj_editor_gui.mode = 3) && (mouse_y >= self.y && mouse_y < self.y+image_yscale*20) || obj_editor_gui.mode = 1 && (mouse_y >= self.y+(zfloor-zcieling)*20 && mouse_y < self.y+image_yscale*20)) {
			for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
				if ((obj_editor_gui.mode = 0 || obj_editor_gui.mode = 3) && (mouse_x >= instance_find(obj_editor_terrain_par,i).x && mouse_x < instance_find(obj_editor_terrain_par,i).x+instance_find(obj_editor_terrain_par,i).width*20 && mouse_y >= instance_find(obj_editor_terrain_par,i).y && mouse_y < instance_find(obj_editor_terrain_par,i).y+instance_find(obj_editor_terrain_par,i).image_yscale*20) || obj_editor_gui.mode = 1 && (mouse_x >= instance_find(obj_editor_terrain_par,i).x && mouse_x < instance_find(obj_editor_terrain_par,i).x+instance_find(obj_editor_terrain_par,i).width*20 && mouse_y >= instance_find(obj_editor_terrain_par,i).y+(instance_find(obj_editor_terrain_par,i).zfloor-instance_find(obj_editor_terrain_par,i).zcieling)*20 && mouse_y < instance_find(obj_editor_terrain_par,i).y+instance_find(obj_editor_terrain_par,i).image_yscale*20)) {
					if instance_find(obj_editor_terrain_par,i).depth < self.depthIterate {
						with obj_editor_terrain_par { canSelect = false; }
						with instance_find(obj_editor_terrain_par,i) { canSelect = true; }
						self.depthIterate = instance_find(obj_editor_terrain_par,i).depth;
						self.highestDepthIterate = self.i;
					}
				} else {
					if instance_find(obj_editor_terrain_par,i).canSelect = false {
						depthIterate = 0;
					}
				}
			}
		} else {
			canSelect = false;
			depthIterate = 0;
		}
	}
	
	if mouse_check_button_pressed(mb_left) && mouse_x < camera_get_view_x(obj_editor_gui.camera)+camera_get_view_width(obj_editor_gui.camera)-48 {
		if canSelect = true {
			if (obj_editor_gui.mode = 0 && mouse_x >= x && mouse_x <= x+width*20 && mouse_y >= y && mouse_y <= y+height*20+(zfloor-zcieling)*20) || (obj_editor_gui.mode = 1 && mouse_x >= x && mouse_x <= x+width*20 && mouse_y >= y+(zfloor-zcieling)*20 && mouse_y <= y+height*20+(zfloor-zcieling)*20) {
				if select = 0 && !instance_exists(obj_editor_button_parent) {
					select = 1;
				
					with instance_create_layer(x,y+height*10,"Instances",obj_arrow_editor_left) {
						trg = other.id;
					}
					with instance_create_layer(x+width*20,y+height*10,"Instances",obj_arrow_editor_right) {
						trg = other.id;
					}
					with instance_create_layer(x+width*10,y,"Instances",obj_arrow_editor_up) {
						trg = other.id;
					}
					with instance_create_layer(x+width*10,y+height*20,"Instances",obj_arrow_editor_down) {
						trg = other.id;
					}
					with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
						trg = other.id;
					}
					with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
						trg = other.id;
					}
					with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
						trg = other.id;
					}
					with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
						trg = other.id;
					}
				}
			} else if obj_editor_gui.mode = 3 {
				if global.pieceSelected = -1 {
					if collision_point(mouse_x,mouse_y,self.id,false,false) {
						sprMaterialDirectory = "";
						sprMaterialDirectory = get_open_filename_ext("Material Image File|*.png", "", working_directory + "\Room Saves\ ", "Import Material Tileset");
					
						if sprMaterialDirectory != "" {
							global.pieceSelected = self.id;
						}
					
						obj_editor_gui.hasMaterials = true;
					
						for (i = 0; i <= obj_editor_gui.materialsImported; i += 1) {
							if obj_editor_gui.sprMaterialDirectoryList[i] = self.sprMaterialDirectory {
								global.sprMaterial = obj_editor_gui.materialDirectorySprite[i];
								break;
							}
							if i = obj_editor_gui.materialsImported {
								global.sprMaterial = sprite_add(other.sprMaterialDirectory,0,false,false,0,0);
								obj_editor_gui.sprMaterialDirectoryList[i] = sprMaterialDirectory;
								obj_editor_gui.materialDirectorySprite[i] = global.sprMaterial;
								obj_editor_gui.materialsImported += 1;
								break;
							}
						}
				
						if sprMaterialDirectory != "" {
							// Spawn tiles GUI
							for (i = 0; i < width+2; i += 1) {
								for (j = 0; j < image_yscale+1; j += 1) {
									with instance_create_layer(i*20+i,600+j*20+j,"Instances",obj_tiles_grid) {
										trgId = other.id;
										i = other.i;
										j = other.j;
										tempMaterial = other.sprMaterial;
										xVal = other.tileArrayDrawX[i,j];
										yVal = other.tileArrayDrawY[i,j];
									}
								}
							}
					
							if !instance_exists(obj_tiles_sheet) {
								instance_create_layer(600,600,"Instances",obj_tiles_sheet) {
							}
					
							view_visible[1] = true;
							view_visible[2] = true;
							} else {
								// Cancel menu opening
								global.pieceSelected = -1;
							}
						}
					}
				}
			}
		}
	}
	if select = 1 {
		select = 0;
	} else {
		exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[0]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[0]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		exportStringSideF = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[0]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[1]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor+height-1)*20)+"},");
		exportStringSideB = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[3]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[4]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[2]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
		exportStringSideL = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[1]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[2]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
		exportStringSideR = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[2]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[3]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[3]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(1)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x+(width-1)*20)+","+chr(34)+"y"+chr(34)+": "+string(y+(zfloor)*20)+"},");
		exportStringFloor = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId5[4]+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1[5]+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId4[1]+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
	}
}
if !instance_exists(obj_editor_button_parent) {
	// Ensure that object deselects properly
	select = 0;
}

// Placing in the level
if placed = 0 {
	x = floor(mouse_x/20)*20;
	y = floor(mouse_y/20)*20 - zfloor*20;
}
if mouse_check_button_released(mb_left) {
	if placed = 0 {
		placed = 1;
		obj_tile_button_parent2.select = 0;
	}
}

image_xscale = width;
image_yscale = height+zfloor-zcieling;

// Depth
depth = -(y + (height+zfloor)*20) - (zfloor);

// Tile array
if resetArray = true {
	resetArray = false;
	sprMaterial = spr_tls_rectangle_default // Reset material
	
	for (i = 0; i <= width + 2; i += 1) {
		for (j = 0; j <= image_yscale + 1; j += 1) {
			tileArrayDrawX[i,j] = 0;
			tileArrayDrawY[i,j] = 120;
			
			if i = 1 && j = 1 {
				if width > 1 && height > 1 {
					// Top left floor corner index
					tileArrayDrawX[i,j] = 20;
					tileArrayDrawY[i,j] = 20;
				} else if width > 1 {
					// Left beam edge
					tileArrayDrawX[i,j] = 0;
					tileArrayDrawY[i,j] = 220;
				} else if height > 1 {
					// Vertical top beam edge
					tileArrayDrawX[i,j] = 80;
					tileArrayDrawY[i,j] = 180;
				} else {
					// Center edge
					tileArrayDrawX[i,j] = 0;
					tileArrayDrawY[i,j] = 100;
				}
			}
			if i = width && j = 1 {
				if height > 1 && width > 1 {
					// Top right floor corner index
					tileArrayDrawX[i,j] = 60;
					tileArrayDrawY[i,j] = 20;
				}
			}
			if i = 1 && j = height {
				if height > 1 && width > 1 {
					// Bottom left floor corner index
					tileArrayDrawX[i,j] = 20;
					tileArrayDrawY[i,j] = 60;
				} else if height > 1 {
					// Vertical bottom beam edge
					tileArrayDrawX[i,j] = 80;
					tileArrayDrawY[i,j] = 220;
				}
			}
			if i = width && j = height {
				if width > 1 && height > 1 {
					// Bottom right floor corner index
					tileArrayDrawX[i,j] = 60;
					tileArrayDrawY[i,j] = 60;
				}
			}
			if i > 1 && i < width && j = 1 {
				if height > 1 {
					// Top floor edge index
					tileArrayDrawX[i,j] = 40;
					tileArrayDrawY[i,j] = 20;
				}
			}
			if i > 1 && i < width && j = height {
				if width > 1 {
					if height > 1 {
						// Bottom floor edge index
						tileArrayDrawX[i,j] = 40;
						tileArrayDrawY[i,j] = 60;
					} else {
						// Center horizontal beam center edge index
						tileArrayDrawX[i,j] = 20;
						tileArrayDrawY[i,j] = 220;
					}
				}
			}
			if j > 1 && j < height && i = 1 {
				if width > 1 && height > 1 {
					// Left floor edge index
					tileArrayDrawX[i,j] = 20;
					tileArrayDrawY[i,j] = 40;
				} else if height > 1 {
					// Center vertical beam edge index
					tileArrayDrawX[1,j] = 80;
					tileArrayDrawY[1,j] = 200;
				}
			}
			if height = 1 && width >= 2 {
				// Right horizontal beam edge index
				tileArrayDrawX[width,1] = 40;
				tileArrayDrawY[width,1] = 220;
			}
			if j > 1 && j < height && i = width {
				if width > 1 {
					// Right floor edge index
					tileArrayDrawX[i,j] = 60;
					tileArrayDrawY[i,j] = 40;
				}
			}
			if i > 1 && i < width && j > 1 && j < height {
				if width > 1 && height > 1 {
					// Center floor index
					tileArrayDrawX[i,j] = 40;
					tileArrayDrawY[i,j] = 40;
				}
			}
			
			if j > height {
				if i = 1 {
					if width > 1 {
						// Left wall edge
						tileArrayDrawX[i,j] = 20;
						tileArrayDrawY[i,j] = 100;
					} else {
						// Vertical beam center wall edge
						tileArrayDrawX[i,j] = 80;
						tileArrayDrawY[i,j] = 100;
					}
				}
				if i = width {
					if width > 1 {
						// Right wall edge
						tileArrayDrawX[i,j] = 60;
						tileArrayDrawY[i,j] = 100;
					}
				}
				if i > 1 && i < width && j = image_yscale {
					if width > 1 {
						// Bottom wall edge
						tileArrayDrawX[i,j] = 40;
						tileArrayDrawY[i,j] = 120;
					}
				}
				if i > 1 && i < width && j < image_yscale {
					if width > 1 {
						// Center wall
						tileArrayDrawX[i,j] = 40;
						tileArrayDrawY[i,j] = 100;
					}
				}
				if i = 1 && j = image_yscale {
					if width > 1 {
						// Bottom left wall corner
						tileArrayDrawX[i,j] = 20;
						tileArrayDrawY[i,j] = 120;
					}
				}
				if i = width && j = image_yscale {
					if width > 1 {
						// Bottom right wall corner
						tileArrayDrawX[i,j] = 60;
						tileArrayDrawY[i,j] = 120;
					}
				}
				if i = 1 && j = image_yscale {
					if width = 1 && image_yscale > 1 {
						// Vertical beam bottom edge
						tileArrayDrawX[i,j] = 80;
						tileArrayDrawY[i,j] = 120;
					}
				}
			}
		}
	}
}

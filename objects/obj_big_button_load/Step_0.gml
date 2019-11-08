/// @description  X Position
x = round( (obj_panel_left.baseX - 4 - room_width) - ( (obj_panel_left.baseX - 4 - room_width) / 6.25) ) + room_width;

if select {
	select = false;
	
	saveFile = get_open_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Load Level Data");
	
	if saveFile != "" {
		// Wipe the field
		with obj_editor_terrain_par {
			instance_destroy();
		}
		
		export = file_text_open_read(saveFile);
		
		// Top data
		terParCount = file_text_readln(export);
		
		for (i = 0; i < terParCount; i += 1) {
			objStr = file_text_read_string(export);
			file_text_readln(export)
			objX = file_text_read_real(export);
			file_text_readln(export)
			objY = file_text_read_real(export);
			file_text_readln(export)
			
			// Load collision
			switch objStr {
				case "rectangle":
					obj = obj_editor_terrain;
					break;
				case "slope1":
					obj = obj_editor_slope1;
					break;
				case "slope2":
					obj = obj_editor_slope2;
					break;
				case "slope3":
					obj = obj_editor_slope3;
					break;
				case "moveScene":
					obj = obj_trigger_cutscene_region_editor;
					break;
				case "actor":
					obj = obj_npc_position;
					break;
				default:
					break;
			}
			
			with instance_create_layer(objX,objY,"Instances",obj) { // asset_get_index() ?
				export = other.export;
				resetArray = false;
				placed = 1;
				
				// Read generic data
				width = file_text_read_real(export);
				file_text_readln(export)
				height = file_text_read_real(export);
				file_text_readln(export)
				zfloor = file_text_read_real(export);
				file_text_readln(export)
				zcieling = file_text_read_real(export);
				file_text_readln(export)
				
				// Load rectangle data
				if other.objStr = "rectangle" || other.objStr = "slope1" || other.objStr = "slope2" || other.objStr = "slope3" {
					#region
					
					finite = file_text_read_real(export);
					file_text_readln(export)
					tileDrawSpr = file_text_read_real(export);
					file_text_readln(export)
					tileLayerCount = file_text_read_real(export);
					file_text_readln(export)
					tileArrayHeight = file_text_read_real(export);
					file_text_readln(export)
					
					// Generic slope data
					if other.objStr != "rectangle" {
						mirror = file_text_read_real(export);
						file_text_readln(export)
						flip = file_text_read_real(export);
						file_text_readln(export)
					}
					
					// Rectangle terrain tiles
					for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through arbitrary layers
						layerOrder[k] = file_text_read_real(export);
						file_text_readln(export)
					}
					
					for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through arbitrary layers
						for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Iterate through absolute layers
							if layerOrder[k2] = k {
								// Read layer data
								layerVisible[k2] = file_text_read_real(export);
								file_text_readln(export)
								layerType[k2] = file_text_read_real(export);
								file_text_readln(export)
								
								layerName[k2] = file_text_read_string(export);
								file_text_readln(export)
								layerName[k2+1] = file_text_read_string(export);
								file_text_readln(export)
								
								// Read hasTile values
								for (a = 0; a < width + 2; a += 1) { // Iterate horizontally
									for (b = 0; b < height + zfloor - zcieling + 1; b += 1) { // Iterate vertically
										hasTile[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
										file_text_readln(export)
										hasTile[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
										file_text_readln(export)
										
										// Define tile co-ordinates if true
										if hasTile[scr_array_xy(a, b, tileArrayHeight), k2] {
											tileArrayDrawX[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
											file_text_readln(export)
											tileArrayDrawY[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
											file_text_readln(export)
										}
										if hasTile[scr_array_xy(a, b, tileArrayHeight), k2+1] {
											tileArrayDrawX[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
											file_text_readln(export)
											tileArrayDrawY[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
											file_text_readln(export)
										}
									}
								}
								
								// Read marble pixels
								if layerType[k2] = 1 {
									for (a = 0; a < width * 20; a += 1) { // Iterate horizontally
										for (b = 0; b < (height + zfloor - zcieling) * 20; b += 1) { // Iterate vertically
											marblePixelCol[a,b] = file_text_read_real(export);
											file_text_readln(export)
										}
									}
								}
							}
						}
					}
					
					#endregion
				}
				
				// Load cutscene region data
				if other.objStr = "moveScene" {
					#region
					
					totalActions = file_text_read_real(export);
					file_text_readln(export)
					obj_panel_bot.rows = file_text_read_real(export);
					file_text_readln(export)
					
					for (var j = 0; j < obj_panel_bot.rows; j += 1) {
						actorTxt[j] = file_text_read_string(export);
						file_text_readln(export)
					}
					
					for (var j = 0; j <= totalActions; j += 1) {
						actionInd[j] = file_text_read_real(export);
						file_text_readln(export)
						actionTime[j] = file_text_read_real(export);
						file_text_readln(export)
						actionRowInd[j] = file_text_read_real(export);
						file_text_readln(export)
						
						if actionInd[j] = 0 { // Walk action
							xNode[j] = file_text_read_real(export);
							file_text_readln(export)
							yNode[j] = file_text_read_real(export);
							file_text_readln(export)
						}
						
						if actionInd[j] = 1 { // Rotation action
							angleRot[j] = file_text_read_real(export);
							file_text_readln(export)
							angleRotExport[j] = file_text_read_real(export);
							file_text_readln(export)
						}
						
						if actionInd[j] = 2 { // Dialogue action
							xOffDialogue[j] = file_text_read_real(export);
							file_text_readln(export)
							yOffDialogue[j] = file_text_read_real(export);
							file_text_readln(export)
							bubbleCount[j] = file_text_read_real(export);
							file_text_readln(export)
							
							for (var k = 0; k <= bubbleCount[j]; k += 1) {
								lineCount[j,k] = file_text_read_real(export);
								file_text_readln(export)
								bubbleX[j,k] = file_text_read_real(export);
								file_text_readln(export)
								bubbleY[j,k] = file_text_read_real(export);
								file_text_readln(export)
								
								for (var z = 0; z <= lineCount[j,k]; z += 1) {
									lineStr[scr_array_xy(k,z,bubbleCount[j]),z] = file_text_read_string(export);
									file_text_readln(export)
								}
							}
						}
						
						if actionInd[j] = 3 { // Camera pan action
							xNode[j] = file_text_read_real(export);
							file_text_readln(export)
							yNode[j] = file_text_read_real(export);
							file_text_readln(export)
							zoomVal[j] = file_text_read_real(export);
							file_text_readln(export)
						}
						
						if actionInd[j] = 5 { // Walk speed action
							slowSpd[j] = file_text_read_real(export);
							file_text_readln(export)
						}
						
						if actionInd[j] = 6 { // Arbitrary action
							arbitraryInd[j] = file_text_read_real(export);
							file_text_readln(export)
						}
					}
					
					#endregion
				}
				
				// Load actor data
				if other.objStr = "actor" {
					#region
					
					placed = 2;
					actorTxt = file_text_read_string(export);
					file_text_readln(export)
					angle = file_text_read_real(export);
					file_text_readln(export)
					trg.dirIsoDef = self.angle;
					
					#endregion
				}
			}
		}
	}
}

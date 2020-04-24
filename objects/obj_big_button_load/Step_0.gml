/// @description  X Position
x = round( (obj_panel_left.baseX - 4 - room_width) - ( (obj_panel_left.baseX - 4 - room_width) / 6.25) ) + room_width;

if select {
	select = false;
	
	saveFile = get_open_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Load Level Data");
	
	if saveFile != "" {
		// Wipe the field
		with obj_editor_placeable_parent {
			instance_destroy();
		}
		with obj_trigger_vertex {
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
					obj = obj_npc_editor;
					break;
				case "panScene":
					obj = obj_trigger_pan_region_editor;
				case "anchorScene":
					obj = obj_trigger_anchor_region_editor;
				default:
					break;
			}
			
			with instance_create_layer(objX,objY,"Instances",obj) { // asset_get_index() ?
				export = other.export;
				resetArray = false;
				writeVertices = false;
				placed = 1;
				
				// Read generic data
				width = file_text_read_real(export);
				file_text_readln(export);
				height = file_text_read_real(export);
				file_text_readln(export);
				zfloor = file_text_read_real(export);
				file_text_readln(export);
				zcieling = file_text_read_real(export);
				file_text_readln(export);
				
				// Load rectangle data
				if other.objStr = "rectangle" || other.objStr = "slope1" || other.objStr = "slope2" || other.objStr = "slope3" {
					#region
					
					finite = file_text_read_real(export);
					file_text_readln(export);
					tileDrawSpr = file_text_read_real(export);
					file_text_readln(export);
					tileLayerCount = file_text_read_real(export);
					file_text_readln(export);
					tileArrayHeight = file_text_read_real(export);
					file_text_readln(export);
					
					tilingWidth = width + 2;
					tilingHeight = zfloor + height - zcieling + 1;
					
					// Generic slope data
					if other.objStr != "rectangle" {
						mirror = file_text_read_real(export);
						file_text_readln(export);
						flip = file_text_read_real(export);
						file_text_readln(export);
					}
					
					// Rectangle terrain tiles
					for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through arbitrary layers
						layerOrder[k] = file_text_read_real(export);
						file_text_readln(export);
					}
					
					for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through arbitrary layers
						for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Iterate through absolute layers
							if layerOrder[k2] = k {
								// Read layer data
								layerVisible[k2] = file_text_read_real(export);
								file_text_readln(export);
								layerType[k2] = file_text_read_real(export);
								file_text_readln(export);
								
								layerName[k2] = file_text_read_string(export);
								file_text_readln(export);
								layerName[k2+1] = file_text_read_string(export);
								file_text_readln(export);
								
								// Read hasTile values
								for (a = 0; a < tilingWidth; a += 1) { // Iterate horizontally
									for (b = 0; b < tilingHeight; b += 1) { // Iterate vertically
										hasTile[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
										file_text_readln(export);
										hasTile[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
										file_text_readln(export);
										
										// Define tile co-ordinates if true
										if hasTile[scr_array_xy(a, b, tileArrayHeight), k2] {
											tileArrayDrawX[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
											file_text_readln(export);
											tileArrayDrawY[scr_array_xy(a, b, tileArrayHeight), k2] = file_text_read_real(export);
											file_text_readln(export);
										}
										if hasTile[scr_array_xy(a, b, tileArrayHeight), k2+1] {
											tileArrayDrawX[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
											file_text_readln(export);
											tileArrayDrawY[scr_array_xy(a, b, tileArrayHeight), k2+1] = file_text_read_real(export);
											file_text_readln(export);
										}
									}
								}
								
								// Read marble pixels
								if layerType[k2] = 1 {
									for (a = 0; a < width * 20; a += 1) { // Iterate horizontally
										for (b = 0; b < (height + zfloor - zcieling) * 20; b += 1) { // Iterate vertically
											marblePixelColInd[a,b] = file_text_read_real(export);
											file_text_readln(export);
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
					
					recalculate = true;
					placed = 2;
					
					instId1[0] = file_text_read_string(export);
					file_text_readln(export);
					totalActions = file_text_read_real(export);
					file_text_readln(export)
					obj_panel_bot.rows = file_text_read_real(export);
					file_text_readln(export)
					
					for (var j = 0; j < obj_panel_bot.rows; j += 1) {
						actorRowTxt[j] = file_text_read_string(export);
						file_text_readln(export)
					}
					
					for (var j = 1; j <= totalActions; j += 1) {
						actionInd[j] = file_text_read_real(export);
						file_text_readln(export)
						actionTime[j] = file_text_read_real(export);
						file_text_readln(export)
						actionRowInd[j] = file_text_read_real(export);
						file_text_readln(export)
						
						if actionInd[j] = 0 { // Walk action
							#region
							
							xNode[j] = file_text_read_real(export);
							file_text_readln(export)
							yNode[j] = file_text_read_real(export);
							file_text_readln(export)
							
							#endregion
						}
						
						if actionInd[j] = 1 { // Rotation action
							#region
							
							angleRot[j] = file_text_read_real(export);
							file_text_readln(export)
							angleRotExport[j] = file_text_read_real(export);
							file_text_readln(export)
							
							#endregion
						}
						
						if actionInd[j] = 2 { // Dialogue action
							#region
							
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
							
							#endregion
						}
						
						if actionInd[j] = 3 { // Camera pan action
							#region
							
							xNode[j] = file_text_read_real(export);
							file_text_readln(export)
							yNode[j] = file_text_read_real(export);
							file_text_readln(export)
							zoomVal[j] = file_text_read_real(export);
							file_text_readln(export)
							
							#endregion
						}
						
						if actionInd[j] = 5 { // Walk speed action
							#region
							
							slowSpd[j] = file_text_read_real(export);
							file_text_readln(export)
							
							#endregion
						}
						
						if actionInd[j] = 6 { // Arbitrary action
							#region
							
							arbitraryInd[j] = file_text_read_real(export);
							file_text_readln(export)
							
							#endregion
						}
					}
					
					writeVertices = true;
					
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
				
				// Load camera panning region data
				if other.objStr = "panScene" {
					#region
					
					recalculate = true;
					writeVertices = true;
					placed = 2;
					
					instId1[0] = file_text_read_string(export);
					file_text_readln(export);
					angle = file_text_read_real(export);
					file_text_readln(export);
					magnitude = file_text_read_real(export);
					file_text_readln(export);
					zoomVal = file_text_read_real(export);
					file_text_readln(export);
					
					#endregion
				}
				
				// Load camera anchor region data
				if other.objStr = "anchorScene" {
					#region
					
					majorRadius = file_text_read_string(export);
					file_text_readln(export);
					minorRadius = file_text_read_string(export);
					file_text_readln(export);
					thresholdRadius = file_text_read_string(export);
					file_text_readln(export);
					zoomVal = file_text_read_string(export);
					file_text_readln(export);
					
					#endregion
				}
				
				if writeVertices {
					#region
					
					writeVertices = false;
					
					vertexCount = file_text_read_real(export);
					file_text_readln(export);
					
					for (j = 0; j < vertexCount; j += 1) {
						with instance_create_layer(x,y,"Instances",obj_trigger_vertex) {
							hasThreshold = bool(file_text_read_real(other.export));
							file_text_readln(other.export);
							trgXOff = file_text_read_real(other.export);
							file_text_readln(other.export);
							trgYOff = file_text_read_real(other.export);
							file_text_readln(other.export);
							vertexInd = file_text_read_real(other.export);
							file_text_readln(other.export);
							vertexToInd = file_text_read_real(other.export);
							file_text_readln(other.export);
							
							if hasThreshold {
								recalculate2 = true;
								
								w = file_text_read_real(other.export);
								file_text_readln(other.export);
								girth = file_text_read_real(other.export);
								tempGirth = girth;
								file_text_readln(other.export);
								thresholdX = file_text_read_real(other.export);
								file_text_readln(other.export);
								thresholdY = file_text_read_real(other.export);
								file_text_readln(other.export);
								edgeMidPointX = file_text_read_real(other.export);
								file_text_readln(other.export);
								edgeMidPointY = file_text_read_real(other.export);
								file_text_readln(other.export);
							}
							
							trgStr = other.instId1[0];
							findTrg = true;
						}
					}
					
					#endregion
				}
			}
		}
	}
}

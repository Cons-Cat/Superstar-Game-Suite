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
			
			// Load rectangular collision
			if objStr = "rectangle" {
				obj = obj_editor_terrain;
			} else {
				// Skip creation of undefined instances
				break;
			}
			
			with instance_create_layer(objX,objY,"Instances",obj) {
				export = other.export;
				
				// Read generic data
				width = file_text_read_real(export);
				file_text_readln(export)
				height = file_text_read_real(export);
				file_text_readln(export)
				zfloor = file_text_read_real(export);
				file_text_readln(export)
				zcieling = file_text_read_real(export);
				file_text_readln(export)
				
				resetArray = false;
				placed = 1;
				
				// Load rectangle data
				if other.objStr = "rectangle" {
					#region
					
					finite = file_text_read_real(export);
					file_text_readln(export)
					tileDrawSpr = file_text_read_real(export);
					file_text_readln(export)
					tileLayerCount = file_text_read_real(export);
					file_text_readln(export)
					tileArrayHeight = file_text_read_real(export);
					file_text_readln(export)
					
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
			}
		}
	}
}

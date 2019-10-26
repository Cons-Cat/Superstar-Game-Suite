/// @description  X Position
x = round( (obj_panel_left.baseX - 4 - room_width) / 3 * 2 - ( (obj_panel_left.baseX - 4 - room_width) / 6.25) ) + room_width;

if select {
	select = false;
	
	// Save level data
	saveFile = get_save_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Save Level Data");
	
	if saveFile != "" {
		str = "";
		export = file_text_open_write(saveFile);
		
		// Top data
		str += string(instance_number(obj_editor_terrain_par));
		
		for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
			trg = instance_find(obj_editor_terrain_par,i);
			
			// Write generic data
			str += string_hash_to_newline("#" + string(trg.str));
			str += string_hash_to_newline("#" + string(trg.x));
			str += string_hash_to_newline("#" + string(trg.y));
			str += string_hash_to_newline("#" + string(trg.width));
			str += string_hash_to_newline("#" + string(trg.height));
			str += string_hash_to_newline("#" + string(trg.zfloor));
			str += string_hash_to_newline("#" + string(trg.zcieling));
			
			// Write instance-particular data
			if trg.str = "rectangle" {
				#region
				
				str += string_hash_to_newline("#" + string(trg.finite));
				str += string_hash_to_newline("#" + string(trg.tileDrawSpr));
				str += string_hash_to_newline("#" + string(trg.tileLayerCount));
				str += string_hash_to_newline("#" + string(trg.tileArrayHeight));
				
				// Rectangle terrain tiles
				for (k = 0; k <= trg.tileLayerCount; k += 2) { // Iterate through arbitrary layers
						str += string_hash_to_newline("#" + string(trg.layerOrder[k]));
				}
				
				for (k = 0; k <= trg.tileLayerCount; k += 2) { // Iterate through arbitrary layers
					// Write layer data
					str += string_hash_to_newline("#" + string(trg.layerVisible[k]));
					str += string_hash_to_newline("#" + string(trg.layerType[k]));
					
					str += string_hash_to_newline("#" + string(trg.layerName[k]));
					str += string_hash_to_newline("#" + string(trg.layerName[k+1]));
					
					// Write hasTile values
					for (a = 0; a < trg.width + 2; a += 1) { // Iterate horizontally
						for (b = 0; b < trg.height + trg.zfloor - trg.zcieling + 1; b += 1) { // Iterate vertically
							str += string_hash_to_newline("#" + string(trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k]));
							str += string_hash_to_newline("#" + string(trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
							
							// Define tile co-ordinates if true
							if trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k] {
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawX[scr_array_xy(a, b, trg.tileArrayHeight), k]));
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawY[scr_array_xy(a, b, trg.tileArrayHeight), k]));
							}
							if trg.hasTile[scr_array_xy(a, b, trg.tileArrayHeight), k+1] {
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawX[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
								str += string_hash_to_newline("#" + string(trg.tileArrayDrawY[scr_array_xy(a, b, trg.tileArrayHeight), k+1]));
							}
						}
					}
					
					// Write marble pixels
					if trg.layerType[k] = 1 {
						for (a = 0; a < trg.width * 20; a += 1) { // Iterate horizontally
							for (b = 0; b < (trg.height + trg.zfloor - trg.zcieling) * 20; b += 1) { // Iterate vertically
								str += string_hash_to_newline("#" + string(trg.marblePixelCol[a,b]));
							}
						}
					}
				}
				
				#endregion
			}
		}
		
		str += string_hash_to_newline("#");
		
		file_text_write_string(export,str);
		file_text_close(export);
	}
}

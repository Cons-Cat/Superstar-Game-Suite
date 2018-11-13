/// @description 
if select = 1 {
	saveFile = get_save_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Export For Game Maker");
	if saveFile != "" {
		str = "";
		export = file_text_open_write(saveFile);
		
		str = str + string(instance_number(obj_editor_terrain_par));
		str = str + string_hash_to_newline("#"+string(obj_editor_gui.hasMaterials));
		str = str + string_hash_to_newline("#"+string(obj_room_editor.str));
		for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
			trg = instance_find(obj_editor_terrain_par,i).id;
			
			str = str + string_hash_to_newline("#obj_editor_terrain");
			str = str + string_hash_to_newline("#"+string(trg.width));
			str = str + string_hash_to_newline("#"+string(trg.height));
			str = str + string_hash_to_newline("#"+string(trg.zfloor));
			str = str + string_hash_to_newline("#"+string(trg.zcieling));
			str = str + string_hash_to_newline("#"+string(trg.x));
			str = str + string_hash_to_newline("#"+string(trg.y));
			str = str + string_hash_to_newline("#"+string(trg.sprMaterialDirectory));
			str = str + string_hash_to_newline("#"+string(trg.mirror));
			str = str + string_hash_to_newline("#"+string(trg.flip));
			str = str + string_hash_to_newline("#"+string(trg.str));
			str = str + string_hash_to_newline("#"+string(trg.finite));
			
			if trg.str = "rectangle" {
				for (a = 0; a <= trg.width + 2; a += 1) {
					for (b = 0; b <= trg.image_yscale + 1; b += 1) {
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawX[a,b]));
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawY[a,b]));
					}
				}
			}
			if trg.str = "slope1" {
				for (a = 0; a < trg.width + 2; a += 1) {
					for (b = trg.zfloor + 1; b >= trg.zcieling; b -= 1) {
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawX[a,b]));
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawY[a,b]));
					}
				}
			}
			if trg.str = "slope2" {
				for (a = 0; a <= trg.width + 2; a += 1) {
					for (b = trg.zfloor + 1; b >= trg.zcieling; b -= 1) {
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawX[a,b]));
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawY[a,b]));
					}
				}
			}
			if trg.str = "slope3" {
				for (a = 0; a < trg.width + 2; a += 1) {
					for (b = trg.zfloor + 2; b >= trg.zcieling; b -= 1) {
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawX[a,b]));
						str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawY[a,b]));
					}
				}
			}
		}
		
		file_text_write_string(export,str);
		file_text_close(export);
	}
}

select = 0;
col = c_white;

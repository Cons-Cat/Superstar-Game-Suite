/// @description 
if select = 1 {
	saveFile = get_save_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Export For Game Maker");
	if saveFile != "" {
		str = "";
		export = file_text_open_write(saveFile);
		
		str = str + string(instance_number(obj_editor_terrain));
		str = str + string_hash_to_newline("#"+string(obj_editor_gui.hasMaterials));
		str = str + string_hash_to_newline("#"+string(obj_room_editor.str));
		for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
			trg = instance_find(obj_editor_terrain,i).id;
			str = str + string_hash_to_newline("#obj_editor_terrain");
			str = str + string_hash_to_newline("#"+string(trg.width));
			str = str + string_hash_to_newline("#"+string(trg.height));
			str = str + string_hash_to_newline("#"+string(trg.zfloor));
			str = str + string_hash_to_newline("#"+string(trg.zcieling));
			str = str + string_hash_to_newline("#"+string(trg.x));
			str = str + string_hash_to_newline("#"+string(trg.y));
			str = str + string_hash_to_newline("#"+string(trg.sprMaterialDirectory));
			
			for (a = 0; a <= trg.width + 2; a += 1) {
				for (b = 0; b <= trg.height+(trg.zfloor-trg.zcieling) + 1; b += 1) {
					str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawX[a,b]));
					str = str + string_hash_to_newline("#"+string(trg.tileArrayDrawY[a,b]));		
				}
			}
		}
		
		file_text_write_string(export,str);
		file_text_close(export);
	}
}

select = 0;
col = c_white;

/// @description 
if select = 1 {
	saveFile = get_open_filename_ext("Editor Save File|*.vasc", "", working_directory + "\Room Saves\ ", "Export For Game Maker");
	if saveFile != "" {
		obj_editor_gui.materialsImported = 0;
		export = file_text_open_read(saveFile);
		
		instCount = file_text_read_real(export)-1;
		file_text_readln(export);
		hasMaterials = file_text_read_real(export);
		file_text_readln(export);
		obj_room_editor.str = file_text_read_string(export);
		file_text_readln(export);
		
		with obj_editor_terrain_par {
			instance_destroy();
		}
		
		for (i = 0; i <= instCount; i += 1) {
			obj = file_text_read_string(export);
			file_text_readln(export);
			width = file_text_read_real(export);
			file_text_readln(export);
			height = file_text_read_real(export);
			file_text_readln(export);
			zfloor = file_text_read_real(export);
			file_text_readln(export);
			zcieling = file_text_read_real(export);
			file_text_readln(export);
			xx = file_text_read_real(export);
			file_text_readln(export);
			yy = file_text_read_real(export);
			file_text_readln(export);
			sprMaterialDirectory = file_text_read_string(export);
			file_text_readln(export);
			mirror = file_text_read_string(export);
			file_text_readln(export);
			flip = file_text_read_string(export);
			file_text_readln(export);
			str = file_text_read_string(export);
			file_text_readln(export);
			
			if str = "rectangle" {
				for (a = 0; a <= width + 2; a += 1) {
					for (b = 0; b <= height+(zfloor-zcieling) + 1; b += 1) {
						tileArrayDrawX[a,b] = file_text_read_real(export); // tileArrayDrawX
						file_text_readln(export);
						tileArrayDrawY[a,b] = file_text_read_real(export); // tileArrayDrawY
						file_text_readln(export);
					}
				}
				
				with instance_create_layer(xx,yy,"Instances",obj_editor_terrain) {
					placed = 1;
					resetArray = false;
					sprMaterialDirectoryLoad = other.hasMaterials;
					sprMaterialDirectory = other.sprMaterialDirectory;
					width = other.width;
					height = other.height;
					zfloor = other.zfloor;
					zcieling = other.zcieling;
				
					for (a = 0; a <= width + 2; a += 1) {
						for (b = 0; b <= height+(zfloor-zcieling) + 1; b += 1) {
							tileArrayDrawX[a,b] = other.tileArrayDrawX[a,b];
							tileArrayDrawY[a,b] = other.tileArrayDrawY[a,b];
						}
					}
				}
			}
			
			if str = "slope1" {
				for (a = 0; a < width + 2; a += 1) {
					for (b = zfloor + 1; b >= zcieling; b -= 1) {
						tileArrayDrawX[a,b] = file_text_read_real(export); // tileArrayDrawX
						file_text_readln(export);
						tileArrayDrawY[a,b] = file_text_read_real(export); // tileArrayDrawY
						file_text_readln(export);
					}
				}
				
				with instance_create_layer(xx,yy,"Instances",obj_editor_slope1) {
					placed = 1;
					resetArray = false;
					sprMaterialDirectoryLoad = other.hasMaterials;
					sprMaterialDirectory = other.sprMaterialDirectory;
					width = other.width;
					height = other.height;
					zfloor = other.zfloor;
					zcieling = other.zcieling;
					mirror = bool(other.mirror);
					flip = bool(other.flip);
					
					for (a = 0; a < width + 2; a += 1) {
						for (b = zfloor + 1; b >= zcieling; b -= 1) {
							tileArrayDrawX[a,b] = other.tileArrayDrawX[a,b];
							tileArrayDrawY[a,b] = other.tileArrayDrawY[a,b];
						}
					}
				}
			}
			
			if str = "infinite" {
				with instance_create_layer(xx,yy,"Instances",obj_editor_infinite) {
					placed = 1;
					width = other.width;
					height = other.height;
					zfloor = other.zfloor;
					zcieling = other.zcieling;
				}
			}
		}
		
		file_text_close(export);
	}
}

select = 0;
col = c_white;

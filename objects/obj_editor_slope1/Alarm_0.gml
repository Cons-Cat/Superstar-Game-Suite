/// @description 
if sprMaterialDirectoryLoad = true {
	for (i = 0; i <= obj_editor_gui.materialsImported; i += 1) {
		if obj_editor_gui.sprMaterialDirectoryList[i] = self.sprMaterialDirectory {
			global.sprMaterial = self.sprMaterialDirectory;
			self.sprMaterial = obj_editor_gui.materialDirectorySprite[i];
			break;
		}
		if i = obj_editor_gui.materialsImported {
			sprMaterialDirectory = get_open_filename_ext("Material Image File|*.png", "", working_directory + "\Room Saves\ ", "OPEN: " + sprMaterialDirectory);
			global.sprMaterial = sprite_add(sprMaterialDirectory,0,false,false,0,0);
			self.sprMaterial = global.sprMaterial;
			obj_editor_gui.sprMaterialDirectoryList[i] = sprMaterialDirectory;
			obj_editor_gui.materialDirectorySprite[i] = global.sprMaterial;
			obj_editor_gui.materialsImported += 1;
			break;
		}
	}
}

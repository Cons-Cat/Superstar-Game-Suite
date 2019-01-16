/// @description Slide panels in / generate tiles
if instance_exists(obj_tiles_grid) {
	with obj_tiles_grid {
		instance_destroy();
	}
}

obj_panel_left.moveToX = global.tempXLeft;
obj_panel_left.moveToSpd = global.tempXLeft / 6;
obj_panel_left.moveDirection = 1;
obj_panel_left.scrollHorPartition = 0;
obj_panel_left.scrollVerPartition = 0;

obj_panel_right.moveToX = global.tempXRight;
obj_panel_right.moveToSpd = (1024 - global.tempXRight) / 6;
obj_panel_right.moveDirection = -1;
obj_panel_right.scrollHorPartition = 0;
obj_panel_right.scrollVerPartition = 0;

// Tile input box
//if collision_point(obj_editor_gui.mouseCheckX,obj_editor_gui.mouseCheckY,self.id,true,false) {
sprMaterialDirectory = "";
sprMaterialDirectory = get_open_filename_ext("Material Image File|*.png", "", working_directory + "\Room Saves\ ", "Import Material Tileset");

if sprMaterialDirectory != "" {
	global.pieceSelected = self.id;
}

obj_editor_gui.hasMaterials = true;

for (i = 0; i <= obj_editor_gui.materialsImported; i += 1) {
	if i = obj_editor_gui.materialsImported {
		global.sprMaterial = sprite_add(other.sprMaterialDirectory,0,false,false,0,0);
		obj_editor_gui.sprMaterialDirectoryList[i] = sprMaterialDirectory;
		obj_editor_gui.materialDirectorySprite[i] = global.sprMaterial;
		obj_editor_gui.materialsImported += 1;
		
		break;
	}
	if obj_editor_gui.sprMaterialDirectoryList[i] = self.sprMaterialDirectory {
		global.sprMaterial = obj_editor_gui.materialDirectorySprite[i];
		
		break;
	}
}

canSpawnButtons = true;
spawnTiles = true;

/// @description Insert description here
event_inherited();

if changeMode {
	if instance_exists(obj_editor_terrain_par) {
		obj_editor_gui.mode = 2;
	}
	
	changeMode = false;
}

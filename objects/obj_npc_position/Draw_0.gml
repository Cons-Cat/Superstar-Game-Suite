/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		draw_sprite_ext(spr_trigger_region,0,x + 10,y + 10,1,1,0,layerColor,0.7);
	}
}

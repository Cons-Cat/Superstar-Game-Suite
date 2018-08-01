/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		draw_sprite_ext(spr_trigger_region,0,x,y,1,1,0,make_color_rgb(249,238,132),0.8);
	}
}

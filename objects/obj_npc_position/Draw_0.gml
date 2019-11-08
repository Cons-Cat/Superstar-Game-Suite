/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		// Draw Shadow
		if zfloor > 0 {
			gpu_set_blendmode(bm_inv_src_color);
			draw_sprite_ext(spr_shadow_editor,0,x+10,y+10+zfloor*20,1,1,0,c_white,0.8);
			gpu_set_blendmode(bm_normal);
		}
		
		draw_sprite_ext(spr_trigger_region,0,x + 10,y + 10,1,1,0,layerColor,0.7);
	}
}

/// @description Draw region
if obj_editor_gui.mode = 4 {
	// Draw Shadow
	gpu_set_blendmode(bm_inv_src_color);
	for (i = 0; i < width; i += 1) {
		for (j = 0; j < height; j += 1) {
			draw_sprite_ext(spr_shadow_editor,0,x+i*20,y+j*20+zfloor*20,1,1,0,c_white,0.8);
		}
	}
	gpu_set_blendmode(bm_normal);
	
	for (i = 0; i < width; i += 1) {
		for (j = 0; j < height; j += 1) {
			if !collision_point(x+i*20,y+j*20,obj_trigger_parent,false,true) {
				draw_sprite_ext(spr_trigger_region,0,x+i*20,y+j*20,1,1,0,make_color_rgb(101,168,196),0.7);
			} else {
				if collision_point(x+i*20,y+j*20,obj_trigger_parent,false,true).depth > self.depth {
					draw_sprite_ext(spr_trigger_region,0,x+i*20,y+j*20,1,1,0,make_color_rgb(101,168,196),0.7);
				}
			}
		}
	}
}

/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		// Draw Shadow
		gpu_set_blendmode(bm_inv_src_color);
		
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				if zfloor > 0 {
					draw_sprite_ext(spr_shadow_editor,0,x+10+i*20,y+10+j*20,1,1,0,c_white,0.8);
				}
			}
		}
		
		// Draw tile
		gpu_set_blendmode(bm_normal);
		
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				draw_sprite_ext(spr_trigger_region,0,x+10+i*20,y+10+j*20-zfloor*20,1,1,0,layerColor,0.7);
			}
		}
	}
	
	// Fill polygon
	if select {
		if !broken {
			for (i = 0; i < ds_list_size(polygon); i += 6) {
				draw_triangle(ds_list_find_value(polygon,i),ds_list_find_value(polygon,i+1),ds_list_find_value(polygon,i+2),ds_list_find_value(polygon,i+3),ds_list_find_value(polygon,i+4),ds_list_find_value(polygon,i+5),false);
			}
		}
	}
}

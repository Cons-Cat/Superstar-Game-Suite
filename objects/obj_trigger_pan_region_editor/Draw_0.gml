/// @description Draw region
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode = 4 {
		if !select {
			// Draw Shadow
			if zfloor > 0 {
				gpu_set_blendmode(bm_inv_src_color);
				draw_sprite_ext(spr_shadow_editor,0,x+10,y+10+zfloor*20,1,1,0,c_white,0.8);
				gpu_set_blendmode(bm_normal);
			}
			
			// Draw tile
			draw_sprite_ext(spr_trigger_region,0,x+10,y+10,1,1,0,layerColor,0.7);
		}
	}
	
	// Fill polygon
	if select {
		if !broken {
			if zfloor > 0 {
				gpu_set_blendmode(bm_inv_src_color); // Shadow
				
				draw_set_alpha(0.8);
				for (i = 0; i < ds_list_size(polygon); i += 6) {
					draw_triangle(ds_list_find_value(polygon,i)-0.5,ds_list_find_value(polygon,i+1)-0.5,ds_list_find_value(polygon,i+2)-0.5,ds_list_find_value(polygon,i+3)-0.5,ds_list_find_value(polygon,i+4)-0.5,ds_list_find_value(polygon,i+5)-0.5,false);
				}
			}
			
			gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply blend mode
			draw_set_color(blankCol);
			
			/*draw_set_alpha(0.4);
			for (i = 0; i < ds_list_size(polygonOutside); i += 6) {
				draw_triangle(ds_list_find_value(polygonOutside,i)-0.5,ds_list_find_value(polygonOutside,i+1)-0.5-(zfloor*20),ds_list_find_value(polygonOutside,i+2)-0.5,ds_list_find_value(polygonOutside,i+3)-0.5-(zfloor*20),ds_list_find_value(polygonOutside,i+4)-0.5,ds_list_find_value(polygonOutside,i+5)-0.5-(zfloor*20),false);
			}*/
			
			draw_set_alpha(1);
			for (i = 0; i < ds_list_size(polygon); i += 6) {
				draw_triangle(ds_list_find_value(polygon,i)-0.5,ds_list_find_value(polygon,i+1)-0.5-(zfloor*20),ds_list_find_value(polygon,i+2)-0.5,ds_list_find_value(polygon,i+3)-0.5-(zfloor*20),ds_list_find_value(polygon,i+4)-0.5,ds_list_find_value(polygon,i+5)-0.5-(zfloor*20),false);
			}
			
			gpu_set_blendmode(bm_normal);
		}
	}
}

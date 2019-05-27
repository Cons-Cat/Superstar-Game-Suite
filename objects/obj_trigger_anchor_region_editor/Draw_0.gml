/// @description Draw region
//if instance_exists(obj_editor_gui) {
if obj_editor_gui.mode = 4 {
//	if !select {
//		// Draw Shadow
//		if zfloor > 0 {
//			gpu_set_blendmode(bm_inv_src_color);
//			draw_sprite_ext(spr_shadow_editor,0,x+10,y+10+zfloor*20,1,1,0,c_white,0.8);
//			gpu_set_blendmode(bm_normal);
//		}
			
//		// Draw tile
//		draw_sprite_ext(spr_trigger_region,0,x+10,y+10,1,1,0,layerColor,0.7);
//	}
	draw_sprite_ext(spr_trigger_region,0,x+10,y+10,1,1,0,layerColor,0.7);
	
	if select {
		draw_set_color(blankCol);
		
		gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply blend mode
		draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,false);
		
		draw_set_alpha(0.3);
		gpu_set_blendmode(bm_normal);
		draw_ellipse(x1,y1,x2,y2,false);
		
		draw_set_color(c_red);
		draw_set_alpha(1);
		
		draw_set_color(c_black);
		draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,true);
		draw_ellipse(x1,y1,x2,y2,true);
	}
}

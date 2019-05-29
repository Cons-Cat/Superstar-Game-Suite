/// @description Draw region
if obj_editor_gui.mode = 4 {
	if select {
		// Draw Shadow
		if zfloor > 0 {
			gpu_set_blendmode(bm_inv_src_color);
		
			draw_set_alpha(0.5);
			draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20+zfloor*20,x2-thresholdRadius*20,y2+thresholdRadius*20+zfloor*20,false);
			
			draw_set_alpha(0.8);
			draw_ellipse(x1,y1+zfloor*20,x2,y2+zfloor*20,false);
		
			gpu_set_blendmode(bm_normal);
		}
		
		// Draw radiuses
		draw_set_color(blankCol);
		
		gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply blend mode
		draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,false);
		
		draw_set_alpha(0.45);
		
		gpu_set_blendmode(bm_normal);
		draw_ellipse(x1,y1,x2,y2,false);
		
		draw_set_alpha(1);
		
		draw_set_color(c_black);
		draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,true);
		draw_ellipse(x1,y1,x2,y2,true);
	}
	
	draw_sprite_ext(spr_trigger_region,0,x+10,y+10,1,1,0,layerColor,0.7);
}

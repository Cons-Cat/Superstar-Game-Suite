/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
	if obj_z_mode.mode = 0 || obj_z_min.z <= zfloor {
		// Draw Shadow
		#region
		
		if (obj_z_mode.mode = 0 && zcieling > 0) || (obj_z_mode.mode = 1 && zfloor >= obj_z_min.z && zcieling <= obj_z_max.z) {
			gpu_set_blendmode(bm_inv_src_color);
		
			for (i = 0; i < width; i += 1) {
				for (j = 0; j < height; j += 1) {
					if !collision_point(x+i*20,y+j*20+(zfloor)*20,obj_editor_terrain,false,true) {
						draw_sprite_ext(spr_shadow_editor,0,x+i*20+10,y+j*20+10+zfloor*20,1,1,0,c_white,0.8);
					}
				}
			}
			
			gpu_set_blendmode(bm_normal);
		}
		
		#endregion
		
		if width = 1 {
			scr_draw_terrain(x,spr_terrain_editor,9,spr_walls_editor,6,spr_walls_editor,7,spr_terrain_editor,16);
		} else {
			if width > 1 {
				scr_draw_terrain(x,spr_terrain_editor,10,spr_walls_editor,0,spr_walls_editor,3,spr_terrain_editor,17);
				scr_draw_terrain(x+(width-1)*20,spr_terrain_editor,12,spr_walls_editor,2,spr_walls_editor,5,spr_terrain_editor,19);
			}
			
			if width > 2 {
				for (i = 1; i < width - 1; i++) {
					scr_draw_terrain(x+i*20,spr_terrain_editor,11,spr_walls_editor,1,spr_walls_editor,4,spr_terrain_editor,18);
				}
			}
		}
	}
	
	#endregion
}

// Wireframe mode
if obj_editor_gui.mode = 1 {
	#region
	
	// Bottom surface
	draw_set_color(layerColorShadow);
	draw_set_alpha(0.45);
	draw_rectangle(x,y+(zfloor-zcieling)*20,x+width*20-1,y+(height+zfloor-zcieling)*20-1,false);
	
	draw_set_alpha(1);
	draw_set_color(layerColorLine);
	
	// Horizontal lines
	draw_rectangle(x,y,x+width*20-1,y,false);
	draw_rectangle(x,y+height*20-1,x+width*20-1,y+height*20,false);
	
	draw_rectangle(x,y+(zfloor-zcieling)*20,x+width*20-1,y+(zfloor-zcieling)*20,false);
	draw_rectangle(x,y+(height+zfloor-zcieling)*20-1,x+width*20-1,y+(height+zfloor-zcieling)*20-1,false);
	
	// Vertical lines
	draw_rectangle(x,y,x,y+(height+zfloor-zcieling)*20-1,false);
	draw_rectangle(x+width*20-1,y,x+width*20-1,y+(height+zfloor-zcieling)*20-1,false);
	
	#endregion
}

// Tiling / Trigger / Play
event_inherited();

/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
	if obj_z_mode.mode = 0 || obj_z_min.z <= zfloor {
		if !mirror {
			if !flip {
				scr_draw_terrain(x,spr_terrain_slope3_editor,0,spr_walls_slope3_editor,0,spr_walls_slope3_editor,2,spr_terrain_slope3_editor,4);
			} else {
				scr_draw_terrain(x,spr_terrain_slope3_editor,3,spr_walls_slope3_editor_flip,1,spr_walls_slope3_editor_flip,0,spr_terrain_slope3_editor,7);
			}
		} else {
			if !flip {
				scr_draw_terrain(x,spr_terrain_slope3_editor,1,spr_walls_slope3_editor,3,spr_walls_slope3_editor,5,spr_terrain_slope3_editor,5);
			} else {
				scr_draw_terrain(x,spr_terrain_slope3_editor,2,spr_walls_slope3_editor_flip,1,spr_walls_slope3_editor_flip,0,spr_terrain_slope3_editor,6);
			}
		}
	}
	
	#endregion
}

// Wireframe mode
if obj_editor_gui.mode = 1 {
	#region
	
	if obj_z_mode.mode = 0 || (obj_z_min.z <= zcieling && obj_z_max.z >= zcieling) {
		// Bottom surface
		draw_set_color(layerColorShadow);
		draw_set_alpha(0.45);
		
		if flip {
			if mirror {
				draw_triangle(x,cielY+39,x+width*20-1,cielY+39,x,cielY,false);
			} else {
				draw_triangle(x,cielY+39,x+width*20-1,cielY+39,x+width*20-1,cielY,false);
			}
		} else {
			if mirror {
				draw_triangle(x,cielY,x+width*20-1,cielY+39,x+width*20-1,cielY,false);
			} else {
				draw_triangle(x,cielY,x,cielY+39,x+width*20-1,cielY,false);
			}
		}
		
		draw_set_alpha(1);
		draw_set_color(layerColorLine);
		
		// Top surface
		
		// Diagonal line
		for (i = 0; i <= width*20-1; i += 1) {
			if mirror {
				draw_rectangle(x+width*20-i,floorY+39+scr_calc_slopepixel(marbleAngleOffset, i)-1,x+width*20-i,floorY+40+scr_calc_slopepixel(marbleAngleOffset, i)-1,false);
				draw_rectangle(x+width*20-i,cielY+38+scr_calc_slopepixel(marbleAngleOffset, i),x+width*20-i,cielY+39+scr_calc_slopepixel(marbleAngleOffset, i),false);
			} else {
				draw_rectangle(x+i,floorY+39+scr_calc_slopepixel(marbleAngleOffset, i)-1,x+i,floorY+40+scr_calc_slopepixel(marbleAngleOffset, i)-1,false);
				draw_rectangle(x+i,cielY+38+scr_calc_slopepixel(marbleAngleOffset, i),x+i,cielY+39+scr_calc_slopepixel(marbleAngleOffset, i),false);
			}
		}
		
		// Horizontal line
		if flip {
			draw_rectangle(x,floorY+40,x+width*20-1,floorY+40,false);
			draw_rectangle(x,cielY+39,x+width*20-1,cielY+39,false);
		} else {
			draw_rectangle(x,floorY,x+width*20-1,floorY,false);
			draw_rectangle(x,cielY,x+width*20-1,cielY,false);
		}
		
		// Side line
		if mirror {
			if flip {
				draw_rectangle(x,floorY,x,cielY+39,false);
				draw_rectangle(x+width*20-1,floorY+40,x+width*20-1,cielY+39,false);
			} else {
				draw_rectangle(x+width*20-1,floorY,x+width*20-1,cielY+39,false);
				draw_rectangle(x,floorY,x,cielY,false);
			}
		} else {
			if flip {
				draw_rectangle(x+width*20-1,floorY,x+width*20-1,cielY+39,false);
				draw_rectangle(x,floorY+40,x,cielY+39,false);
			} else {
				draw_rectangle(x,floorY,x,cielY+39,false);
				draw_rectangle(x+width*20-1,floorY,x+width*20-1,cielY,false);
			}
		}
	}
	
	#endregion
}

// Tiling / Trigger / Play
event_inherited();

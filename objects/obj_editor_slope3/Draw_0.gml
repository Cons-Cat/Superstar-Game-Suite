/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
	if obj_z_mode.mode = 0 || obj_z_min.z <= zfloor {
		if !mirror {
			if !flip {
				scr_draw_terrain(x,spr_terrain_slope3_editor,0,spr_walls_slope3_editor,0,spr_walls_slope3_editor,2,spr_terrain_slope3_editor,4);
			} else {
				scr_draw_terrain(x,spr_terrain_slope3_editor,3,spr_walls_editor,6,spr_walls_editor,7,spr_terrain_slope3_editor,7);
			}
		} else {
			if !flip {
				scr_draw_terrain(x,spr_terrain_slope3_editor,1,spr_walls_slope3_editor,3,spr_walls_slope3_editor,5,spr_terrain_slope3_editor,5);
			} else {
				scr_draw_terrain(x,spr_terrain_slope3_editor,2,spr_walls_editor,6,spr_walls_editor,7,spr_terrain_slope3_editor,6);
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
	
	if flip {
		if mirror {
			draw_triangle(x,y+(height+zfloor-zcieling)*20,x+width*20-1,y+(height+zfloor-zcieling)*20,x,y+(zfloor-zcieling)*20,false);
		} else {
			draw_triangle(x,y+(height+zfloor-zcieling)*20,x+width*20-1,y+(height+zfloor-zcieling)*20,x+width*20-1,y+(zfloor-zcieling)*20,false);
		}
	} else {
		if mirror {
			draw_triangle(x,y+(zfloor-zcieling)*20,x+width*20-1,y+(height+zfloor-zcieling)*20,x+width*20-1,y+(zfloor-zcieling)*20,false);
		} else {
			draw_triangle(x,y+(zfloor-zcieling)*20,x,y+(height+zfloor-zcieling)*20,x+width*20-1,y+(zfloor-zcieling)*20,false);
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(layerColorLine);
	
	// Top surface
	
	// Diagonal line
	for (i = 0; i <= width*20-1; i += 1) {
		if mirror {
			draw_rectangle(x+width*20-i,y+39+scr_calc_slopepixel(marbleAngleOffset, i)-1,x+width*20-i,y+40+scr_calc_slopepixel(marbleAngleOffset, i)-1,false);
			draw_rectangle(x+width*20-i,y+39+scr_calc_slopepixel(marbleAngleOffset, i)+(zfloor-zcieling)*20-1,x+width*20-i,y+40+scr_calc_slopepixel(marbleAngleOffset, i)+(zfloor-zcieling)*20-1,false);
		} else {
			draw_rectangle(x+i,y+39+scr_calc_slopepixel(marbleAngleOffset, i)-1,x+i,y+40+scr_calc_slopepixel(marbleAngleOffset, i)-1,false);
			draw_rectangle(x+i,y+39+scr_calc_slopepixel(marbleAngleOffset, i)+(zfloor-zcieling)*20-1,x+i,y+40+scr_calc_slopepixel(marbleAngleOffset, i)+(zfloor-zcieling)*20-1,false);
		}
	}
	
	// Horizontal line
	if flip {
		draw_rectangle(x,y+height*20,x+width*20-1,y+height*20,false);
		draw_rectangle(x,y+(height+zfloor-zcieling)*20-1,x+width*20-1,y+(height+zfloor-zcieling)*20-1,false);
	} else {
		draw_rectangle(x,y,x+width*20-1,y,false);
		draw_rectangle(x,y+(zfloor-zcieling)*20,x+width*20-1,y+(zfloor-zcieling)*20,false);
	}
	
	// Side line
	if mirror {
		if flip {
			draw_rectangle(x,y,x,y+(height + zfloor - zcieling)*20-1,false);
			draw_rectangle(x+width*20-1,y+height*20,x+width*20-1,y+(height + zfloor - zcieling)*20-1,false);
		} else {
			draw_rectangle(x+width*20-1,y,x+width*20-1,y+(height + zfloor - zcieling)*20-1,false);
			draw_rectangle(x,y,x,y+(zfloor - zcieling)*20,false);
		}
	} else {
		if flip {
			draw_rectangle(x+width*20-1,y,x+width*20-1,y+(height + zfloor - zcieling)*20-1,false);
			draw_rectangle(x,y+height*20,x,y+(height + zfloor - zcieling)*20-1,false);
		} else {
			draw_rectangle(x,y,x,y+(height + zfloor - zcieling)*20-1,false);
			draw_rectangle(x+width*20-1,y,x+width*20-1,y+(zfloor - zcieling)*20,false);
		}
	}
	
	#endregion
}

// Tiling / Trigger / Play
event_inherited();

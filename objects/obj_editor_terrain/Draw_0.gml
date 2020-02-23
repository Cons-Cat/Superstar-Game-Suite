/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
	if obj_z_mode.mode = 0 || obj_z_min.z <= zfloor {
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
	
	if obj_z_mode.mode = 0 || (obj_z_min.z <= zcieling && obj_z_max.z >= zcieling) {
		// Bottom surface
		draw_set_color(layerColorShadow);
		draw_set_alpha(0.45);
		draw_rectangle(x,cielY,x+width*20-1,cielY+20,false);
	
		draw_set_alpha(1);
		draw_set_color(layerColorLine);
	
		// Horizontal lines
		draw_rectangle(x,floorY,x+width*20-1,floorY,false);
		draw_rectangle(x,floorY+19,x+width*20-1,floorY+19,false);
	
		draw_rectangle(x,cielY,x+width*20-1,cielY,false);
		draw_rectangle(x,cielY+19,x+width*20-1,cielY+19,false);
	
		// Vertical lines
		draw_rectangle(x,floorY,x,cielY+19,false);
		draw_rectangle(x+width*20-1,floorY,x+width*20-1,cielY+19,false);
	}
	
	#endregion
}

// Tiling / Trigger / Play
event_inherited();

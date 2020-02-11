/// @description Draw tiles surface

// Tile painting mode / Trigger collision mode / Play testing mode
if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4 {
	// Draw surface baked in the Step event
	if surface_exists(tileSurfaceDraw) {
		draw_surface_ext(tileSurfaceDraw,x-20,y-20,1,1,0,layerColor,1);
	} else {
		// Draw generic null texture
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				draw_sprite_ext(spr_surface_error,1,x+i*20,y+j*20,1,1,0,layerColor,1);
			}
			for (j = height; j < height + zfloor - zcieling; j += 1) {
				draw_sprite_ext(spr_surface_error,0,x+i*20,y+j*20,1,1,0,layerColor,1);
			}
		}
	}
}

/*draw_set_alpha(0.55);
draw_set_color(c_black);
draw_text(x,y,id);
draw_set_alpha(1);
*/

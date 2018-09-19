/// @description Draw terrain

// Trigger mode
if obj_editor_gui.mode = 4 {
	// Draw walls
	if canSelect {
		layerColor = c_orange;
	} else {
		layerColor = c_white;
	}
	
	draw_sprite_ext(spr_infinite_wall,0,x,y,width,height+(zfloor-zcieling),0,layerColor,0.4);
	
	// Draw floor
	for (i = 0; i < width; i += 1) {
		for (j = 0; j < height; j += 1) {
			draw_sprite_ext(spr_infinite_floor,0,x+i*20,y+j*20,1,1,0,layerColor,0.4);
		}
	}
}

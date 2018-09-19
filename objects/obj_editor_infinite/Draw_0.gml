/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
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
	
	draw_set_alpha(0.1);
}

// Wireframe mode
if obj_editor_gui.mode = 1 {
	if canSelect {
		layerColor = c_orange;
	} else {
		layerColor = c_maroon;
	}
	
	if zfloor > 0 {
		layerColorLine = make_color_rgb(color_get_red(layerColor)+30,color_get_green(layerColor)+30,color_get_blue(layerColor)+30);
		layerColorShadow = make_color_rgb(color_get_red(layerColor)-60,color_get_green(layerColor)-60,color_get_blue(layerColor)-60);
	} else {
		if canSelect = false {
			layerColorLine = c_white;
			layerColorShadow = c_gray;
		} else {
			layerColorLine = c_orange;
			layerColorShadow = c_red;
		}
	}
	draw_set_color(layerColorShadow);
	draw_set_alpha(0.4);
	
	// Bottom surface
	draw_set_alpha(0.35);
	draw_rectangle(x,y+(zfloor-zcieling)*20,x+width*20,y+height*20+(zfloor-zcieling)*20,false);
	draw_set_alpha(1);
	draw_set_color(layerColorLine);
	// Top surface
	draw_rectangle(x,y,x+width*20,y+height*20,true);
	draw_rectangle(x+1,y+1,x+width*20-1,y+height*20-1,true);
	draw_rectangle(x+2,y+2,x+width*20-2,y+height*20-2,true);
	// Front surface
	draw_rectangle(x,y+height*20,x+width*20,y+height*20+(zfloor-zcieling)*20,true);
	draw_rectangle(x+1,y+height*20+1,x+width*20-1,y+height*20+(zfloor-zcieling)*20-1,true);
	draw_rectangle(x+2,y+height*20+2,x+width*20-2,y+height*20+(zfloor-zcieling)*20-2,true);
	
	draw_set_alpha(1);
}

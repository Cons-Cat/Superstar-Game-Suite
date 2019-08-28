/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	if zcieling > 0 {
		// Draw Shadow
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
	
	// Draw walls
	if width > 1 {
		for (i = 1; i < width-1; i += 1) { // Center fill
			for (j = 1; j < zfloor-zcieling; j += 1) {
				if canSelect = false {
					layerColor = col[ abs( (zfloor - j) % 8) ];
				} else {
					layerColor = c_orange;
				}
				draw_sprite_ext(spr_walls_editor,1,x+i*20,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
			}
		}
		
		for (j = 1; j < zfloor-zcieling; j += 1) { // Left and right edges
			if canSelect = false {
				layerColor = col[ abs( (zfloor - j) % 8) ];
			} else {
				layerColor = c_orange;
			}
			draw_sprite_ext(spr_walls_editor,0,x,y+(height-1)*20+j*20,1,1,0,layerColor,alpha);
			draw_sprite_ext(spr_walls_editor,2,x+(width-1)*20,y+(height-1)*20+j*20,1,1,0,layerColor,alpha);
		}
	} else {
		for (j = 1; j < zfloor-zcieling; j += 1) {
			if canSelect = false {
				layerColor = col[ abs( (zfloor - j) % 8) ];
			} else {
				layerColor = c_orange;
			}
			draw_sprite_ext(spr_walls_editor,6,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
		}
	}
	
	if canSelect = false {
		layerColor = col[ abs(zcieling % 8) ];
	} else {
		layerColor = c_orange;
	}
	
	if width > 1 {
		for (i = 1; i < width-1; i += 1) { // Bottom edge
			draw_sprite_ext(spr_walls_editor,4,x+i*20,y+(height-1)*20+(zfloor-zcieling)*20,1,1,0,layerColor,alpha);
		}
		
		draw_sprite_ext(spr_walls_editor,3,x,y+(height-1)*20+(zfloor-zcieling)*20,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_walls_editor,5,x+(width-1)*20,y+(height-1)*20+(zfloor-zcieling)*20,1,1,0,layerColor,alpha);
		
	} else {
		draw_sprite_ext(spr_walls_editor,7,x,y+(zfloor-zcieling)*20+(height-1)*20,1,1,0,layerColor,alpha);
	}
	
	// Draw floor
	if canSelect = false {
		if zfloor > 0 {
			layerColor = col[ abs( (zfloor-1) % 8 ) ];
		} else {
			layerColor = c_white;
		}
	} else {
		layerColor = c_orange;
	}
	
	if width > 1 && height > 1 {
		draw_sprite_ext(spr_terrain_editor,0,x,y,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_terrain_editor,2,x+(width-1)*20,y,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_terrain_editor,6,x,y+(height-1)*20,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_terrain_editor,8,x+(width-1)*20,y+(height-1)*20,1,1,0,layerColor,alpha);
	
		for (i = 1; i < width-1; i += 1) {
			draw_sprite_ext(spr_terrain_editor,1,x+i*20,y,1,1,0,layerColor,alpha);
			draw_sprite_ext(spr_terrain_editor,7,x+i*20,y+(height-1)*20,1,1,0,layerColor,alpha);
		}
		for (j = 1; j < height-1; j += 1) {
			draw_sprite_ext(spr_terrain_editor,3,x,y+j*20,1,1,0,layerColor,alpha);
			draw_sprite_ext(spr_terrain_editor,5,x+(width-1)*20,y+j*20,1,1,0,layerColor,alpha);
		}
		for (i = 1; i < width-1; i += 1) {
			for (j = 1; j < height-1; j += 1) {
				draw_sprite_ext(spr_terrain_editor,4,x+i*20,y+j*20,1,1,0,layerColor,alpha);
			}
		}
	} else if width = 1 && height > 1 {
		// Vertical line
		for (j = 1; j < height - 1; j += 1) {
			draw_sprite_ext(spr_terrain_editor,14,x,y+j*20,1,1,0,layerColor,alpha);
		}
		draw_sprite_ext(spr_terrain_editor,13,x,y,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_terrain_editor,15,x,y+(height-1)*20,1,1,0,layerColor,alpha);
	} else if width > 1 && height = 1 {
		// Horizontal line
		for (i = 1; i < width - 1; i += 1) {
			draw_sprite_ext(spr_terrain_editor,11,x+i*20,y,1,1,0,layerColor,alpha);
		}
		draw_sprite_ext(spr_terrain_editor,10,x,y,1,1,0,layerColor,alpha);
		draw_sprite_ext(spr_terrain_editor,12,x+(width-1)*20,y,1,1,0,layerColor,alpha);
	} else {
		// Single space
		for (i = 0; i < width; i += 1) { // Center fill
			for (j = 0; j < height; j += 1) {
				draw_sprite_ext(spr_terrain_editor,9,x+i*20,y+j*20,1,1,0,layerColor,alpha);
			}
		}
	}
	
	// Initialize shadow iteration
	for (i = 0; i < width; i += 1) {
		for (j = 0; j < height; j += 1) {
			shadowed[i,j] = 0;
		}
	}
	
	if zcieling >= 0 {
		// Draw Shadow
		gpu_set_blendmode(bm_inv_src_color);
		
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				for (z = 0; z < y+(zfloor+height)*20; z += 20) {
					if collision_point(x+i*20,z,obj_editor_terrain,false,true) {
						shadowed[i,j] += 1;
						trg = collision_point(x+i*20,z,obj_editor_terrain,false,true).id;
					
						for (v = 0; v < trg.height; v += 1) {
							if zfloor < trg.zcieling {
								if (self.y+self.zfloor*20+j*20) = (trg.y+trg.zfloor*20+v*20) {
									if shadowed[i,j] = 1 {
										draw_sprite_ext(spr_shadow_editor,0,x+i*20+10,y+j*20+10,1,1,0,c_white,0.75);
									}
								}
							}
						}
					}
				}
			}
		}
		
		gpu_set_blendmode(bm_normal);
	}
}

// Wireframe mode
if obj_editor_gui.mode = 1 {
	if canSelect = false {
		layerColor = col[ abs( (zfloor-1) % 8) ];
	} else {
		layerColor = c_orange;
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
}

// Tile painting mode / Play testing mode
if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4 && !global.drawMarble {
	/*for (i = 0; i < width + 2; i += 1) {
		for (j = 0; j < zfloor - zcieling + 2; j += 1) {
			for (k = 0; k <= tileLayerCount; k += 2) {
				if layerVisible[k] {
					if hasTile[scr_array_xy(i,j,tileRowWidth),k] {
						draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k],20,20,x+i*20-20,y+j*20-20,1,1,layerColor,alpha);
					}
					
					if hasTile[scr_array_xy(i,j,tileRowWidth),k+1] {
						draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1],20,20,x+i*20-20,y+j*20-20,1,1,layerColor,alpha);
					}
				}
			}
		}
	}*/
	
	//draw_surface_ext(tileSurfaceDraw,x-20,y-20,1,1,0,layerColor,1);
}

// Draw marble
if global.drawMarble {
	draw_surface(marbleSurfaceSide,x,y);
}

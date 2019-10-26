/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	if zcieling > 0 {
		// Draw Shadow
		gpu_set_blendmode(bm_inv_src_color);
		for (i = 0; i < width; i += 1) {
			for (j = 0; j < height; j += 1) {
				if !collision_point(x+i*20,y+j*20+(zfloor)*20,obj_editor_terrain,false,true) {
					draw_sprite_ext(spr_shadow_editor,0,x+i*20,y+j*20+zfloor*20,1,1,0,c_white,0.8);
				}
			}
		}
		gpu_set_blendmode(bm_normal);
	}
	
	// Draw walls
	for (i = 0; i < width; i += 1) {
		for (j = 1; j <= zfloor-zcieling; j += 1) {
			if canSelect = false {
				layerColor = col[ abs(zfloor - j % 8) ];
			} else {
				layerColor = c_orange;
			}
			
			if !mirror {
				if !flip {
					if width > 1 {
						if i < 1 {
							// Left edge
							if j < zfloor-zcieling {
								draw_sprite_ext(spr_walls_slope1_editor,4,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,2,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							}
						} else if i = width - 1 {
							// Right edge
							if j < zfloor-zcieling {
								draw_sprite_ext(spr_walls_slope1_editor,10,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,12,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							}
						} else {
							// Center fill
							if j < zfloor-zcieling  {
								draw_sprite_ext(spr_walls_slope1_editor,6,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,0,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
							}
						}
					} else {
						// Column
						if j < zfloor-zcieling {
							draw_sprite_ext(spr_walls_slope1_editor,14,x+i*20,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
						} else {
							draw_sprite_ext(spr_walls_slope1_editor,8,x+i*20,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
						}
					}
				} else {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_editor,6,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_editor,7,x+i*20,y+j*20+(height-1)*20-(i)*20,1,1,0,layerColor,alpha);
					}
				}
			} else {
				if !flip {
					if width > 1 {
						if i < 1 {
							// Left edge
							if j < zfloor-zcieling {
								draw_sprite_ext(spr_walls_slope1_editor,11,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,13,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							}
						} else if i = width - 1 {
							// Right edge
							if j < zfloor-zcieling {
								draw_sprite_ext(spr_walls_slope1_editor,5,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,3,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							}
						} else {
							// Center fill
							if j < zfloor-zcieling  {
								draw_sprite_ext(spr_walls_slope1_editor,7,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							} else {
								draw_sprite_ext(spr_walls_slope1_editor,1,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
							}
						}
					} else {
						// Column
						if j < zfloor-zcieling {
							draw_sprite_ext(spr_walls_slope1_editor,15,x+i*20,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
						} else {
							draw_sprite_ext(spr_walls_slope1_editor,9,x+i*20,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
						}
					}
				} else {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_editor,6,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_editor,7,x+i*20,y+j*20+(height)*20-(width-i)*20,1,1,0,layerColor,alpha);
					}
				}
			}
		}
	}
	
	if canSelect = false {
		layerColor = col[ abs(zcieling % 8) ];
	} else {
		layerColor = c_orange;
	}

	//	Draw floor
	if canSelect = false {
		if zfloor > 0 {
			layerColor = col[ abs( (zfloor-1) % 8 ) ];
		} else {
			layerColor = c_white;
		}
	} else {
		layerColor = c_orange;
	}
	
	for (i = 0; i < width; i += 1) {
		if !flip {
			if !mirror {
				draw_sprite_ext(spr_terrain_slope1_editor,0,x+i*20,y-i*20,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(spr_terrain_slope1_editor,1,x+(width-i-1)*20,y-i*20,1,1,0,layerColor,alpha);
			}
		} else {
			if !mirror {
				draw_sprite_ext(spr_terrain_slope1_editor,3,x+i*20,y-i*20,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(spr_terrain_slope1_editor,2,x+(width-i-1)*20,y-i*20,1,1,0,layerColor,alpha);
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
										draw_sprite_ext(spr_shadow_editor,0,x+i*20,y+j*20,1,1,0,c_white,0.75);
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
	for (i = 0; i < width; i += 1) {
		if !mirror {
			draw_triangle(x+i*20,y-i*20+zfloor*20+20,x+i*20,y-i*20+zfloor*20,x+i*20+20,y-i*20+zfloor*20,false);
		} else {
			draw_triangle(x+width*20-i*20,y-i*20+zfloor*20+20,x+width*20-i*20-20,y-i*20+zfloor*20,x+width*20-i*20,y-i*20+zfloor*20,false);
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(layerColorLine);
	
	// Top surface
	if !mirror {
		draw_line(x,y+height*20+zfloor*20,x+width*20,y+zfloor*20-width*20+20)
		draw_line(x,y+height*20+zfloor*20-1,x+width*20,y+zfloor*20-width*20+19)
			
		draw_line(x,y+height*20,x+width*20,y-width*20+20)
		draw_line(x,y+height*20-1,x+width*20,y-width*20+19)
	} else {
		draw_line(x,y+height*20+zfloor*20-width*20,x+width*20,y+zfloor*20+20)
		draw_line(x,y+height*20+zfloor*20-width*20-1,x+width*20,y+zfloor*20+19)
			
		draw_line(x,y+height*20-width*20,x+width*20,y+20)
		draw_line(x,y+height*20-width*20-1,x+width*20,y+19)
	}
	
	for (i = 0; i < width; i += 1) {
		if !mirror {
			draw_line(x+i*20,y-i*20,x+i*20,y-i*20+20);
			draw_line(x+i*20+1,y-i*20,x+i*20+1,y-i*20+20);
			
			draw_line(x+i*20,y-i*20,x+i*20+20,y-i*20);
			draw_line(x+i*20,y-i*20+1,x+i*20+20,y-i*20+1);
		} else {
			draw_line(x+i*20+20,y+i*20-width*20+20,x+i*20+20,y+i*20+40-width*20);
			draw_line(x+i*20+19,y+i*20-width*20+20,x+i*20+20,y+i*20+39-width*20);
			
			draw_line(x+i*20,y+i*20-width*20+20,x+i*20+20,y+i*20-width*20+20);
			draw_line(x+i*20,y+i*20-width*20+21,x+i*20+20,y+i*20-width*20+21);
		}
	}
	
	if !mirror {
		draw_line(x,y+height*20,x,y+height*20+zfloor*20);
		draw_line(x+1,y+height*20,x+1,y+height*20+zfloor*20);
	
		draw_line(x+width*20,y+height*20-width*20,x+width*20,y+zfloor*20+height*20-width*20);
		draw_line(x+width*20-1,y+height*20-width*20,x+width*20-1,y+zfloor*20+height*20-width*20);
	} else {
		draw_line(x+width*20,y+height*20,x+width*20,y+height*20+zfloor*20);
		draw_line(x+width*20-1,y+height*20,x+width*20-1,y+height*20+zfloor*20);
	
		draw_line(x,y+height*20-width*20,x,y+zfloor*20+height*20-width*20);
		draw_line(x+1,y+height*20-width*20,x+1,y+zfloor*20+height*20-width*20);
	}
}

// Tile painting mode / Play testing mode
if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4 {
	// Draw surface baked in the Step event
	if surface_exists(tileSurfaceDraw) {
		draw_surface_ext(tileSurfaceDraw,x-20,y-20,1,1,0,layerColor,1);
	}
}

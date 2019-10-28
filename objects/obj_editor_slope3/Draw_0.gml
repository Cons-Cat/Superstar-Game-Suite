/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
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
				layerColor = col[ abs(zfloor - j % 9) ];
			} else {
				layerColor = c_orange;
			}
			
			if !mirror {
				if !flip {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_slope3_editor,0,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_slope3_editor,2,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					}
				} else {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_editor,6,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_editor,7,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					}
				}
			} else {
				if !flip {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_slope3_editor,3,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_slope3_editor,5,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					}
				} else {
					if j < zfloor-zcieling {
						draw_sprite_ext(spr_walls_editor,6,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					} else {
						draw_sprite_ext(spr_walls_editor,7,x,y+j*20+(height-1)*20,1,1,0,layerColor,alpha);
					}
				}
			}
		}
	}
	
	if canSelect = false {
		layerColor = col[ abs(zcieling % 9) ];
	} else {
		layerColor = c_orange;
	}
	
	//	Draw floor
	if canSelect = false {
		if zfloor > 0 {
			layerColor = col[ abs( (zfloor-1) % 9 ) ];
		} else {
			layerColor = c_white;
		}
	} else {
		layerColor = c_orange;
	}
	
	for (i = 0; i < width; i += 1) {
		if !flip {
			if !mirror {
				draw_sprite_ext(spr_terrain_slope3_editor,0,x+i*20,y-i*20,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(spr_terrain_slope3_editor,1,x+(width-i-1)*20,y-i*20,1,1,0,layerColor,alpha);
			}
		} else {
			if !mirror {
				draw_sprite_ext(spr_terrain_slope3_editor,3,x+i*20,y-i*20,1,1,0,layerColor,alpha);
			} else {
				draw_sprite_ext(spr_terrain_slope3_editor,2,x+(width-i-1)*20,y-i*20,1,1,0,layerColor,alpha);
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

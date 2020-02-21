/// @description Draw terrain

// Solid mode
if obj_editor_gui.mode = 0 {
	#region
	
	if obj_z_mode.mode = 0 || obj_z_min.z <= zfloor {
		// Draw Shadow
		#region
		
		if zcieling > 0 || (obj_z_mode.mode = 1 && zfloor >= obj_z_min.z) {
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
		
		// Draw walls
		#region
		
		for (j = 0; j < zfloor-zcieling; j += 1) {
			if canSelect = false {
				layerColor = col[ (j + zcieling) % 9 ];
			} else {
				layerColor = c_orange;
			}
			
			if ( obj_z_max.z >= j + 1 ) || obj_z_mode.mode = 0 {
				if width > 1 {
					if j = 0 {
						// Bottom edge
						for (i = 1; i < width-1; i += 1) {
							draw_sprite_ext(spr_walls_editor,4,x+i*20,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
						}
						
						// Bottom corners
						draw_sprite_ext(spr_walls_editor,3,x,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
						draw_sprite_ext(spr_walls_editor,5,x+(width-1)*20,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
					} else {
						for (i = 1; i < width-1; i += 1) { // Center fill
							draw_sprite_ext(spr_walls_editor,1,x+i*20,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
						}
						
						draw_sprite_ext(spr_walls_editor,0,x,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
						draw_sprite_ext(spr_walls_editor,2,x+(width-1)*20,y-j*20+(height+zfloor-zcieling-1)*20,1,1,0,layerColor,alpha);
					}
				} else {
					if (j + zcieling >= obj_z_min.z && j + zcieling < obj_z_max.z) || obj_z_mode.mode = 0 {
						if (obj_z_mode.mode = 1 && (j + zcieling = obj_z_min.z || j = zfloor - zcieling - ( cielY - y ) / 20)) || (j = 0 && obj_z_mode.mode = 0) {
							draw_sprite_ext(spr_walls_editor,7,x,cielY,1,1,0,layerColor,alpha);
						} else {
							draw_sprite_ext(spr_walls_editor,6,x,y+(height+zfloor-zcieling-j-1)*20,1,1,0,layerColor,alpha);
						}
					}
				}
			}
		}
		
		#endregion
		
		if floorY < y + (height + zfloor - zcieling) * 20 {
			//	Calculate floor color
			if canSelect = false {
				if zfloor > 0 && ( obj_z_max.z > 0 || obj_z_mode.mode = 0 ) {
					layerColor = col[ abs( ((y + (height+zfloor)*20 - floorY) div 20 - 2) % 9 ) ];
				} else {
					layerColor = c_white;
				}
			} else {
				layerColor = c_orange;
			}
			
			// Draw floor
			#region
		
			if width > 1 && height > 1 {
				draw_sprite_ext(spr_terrain_editor,0,x,floorY,1,1,0,layerColor,alpha);
				draw_sprite_ext(spr_terrain_editor,2,x+(width-1)*20,floorY,1,1,0,layerColor,alpha);
				draw_sprite_ext(spr_terrain_editor,6,x,floorY+(height-1)*20,1,1,0,layerColor,alpha);
				draw_sprite_ext(spr_terrain_editor,8,x+(width-1)*20,floorY+(height-1)*20,1,1,0,layerColor,alpha);
			
				for (i = 1; i < width-1; i += 1) {
					draw_sprite_ext(spr_terrain_editor,1,x+i*20,floorY,1,1,0,layerColor,alpha);
					draw_sprite_ext(spr_terrain_editor,7,x+i*20,floorY+(height-1)*20,1,1,0,layerColor,alpha);
				}
			
				for (j = 1; j < height-1; j += 1) {
					draw_sprite_ext(spr_terrain_editor,3,x,floorY+j*20,1,1,0,layerColor,alpha);
					draw_sprite_ext(spr_terrain_editor,5,x+(width-1)*20,floorY+j*20,1,1,0,layerColor,alpha);
				}
			
				for (i = 1; i < width-1; i += 1) {
					for (j = 1; j < height-1; j += 1) {
						draw_sprite_ext(spr_terrain_editor,4,x+i*20,floorY+j*20,1,1,0,layerColor,alpha);
					}
				}
			} else if width = 1 && height > 1 {
				// Vertical line
				for (j = 1; j < height - 1; j += 1) {
					draw_sprite_ext(spr_terrain_editor,14,x,floorY+j*20,1,1,0,layerColor,alpha);
				}
			
				draw_sprite_ext(spr_terrain_editor,13,x,floorY,1,1,0,layerColor,alpha);
				draw_sprite_ext(spr_terrain_editor,15,x,floorY+(height-1)*20,1,1,0,layerColor,alpha);
			} else if width > 1 && height = 1 {
				// Horizontal line
				if floorY = y || obj_z_mode.mode = 0 {
					for (i = 1; i < width - 1; i += 1) {
						draw_sprite_ext(spr_terrain_editor,11,x+i*20,floorY,1,1,0,layerColor,alpha);
					}
				
					draw_sprite_ext(spr_terrain_editor,10,x,floorY,1,1,0,layerColor,alpha);
					draw_sprite_ext(spr_terrain_editor,12,x+(width-1)*20,floorY,1,1,0,layerColor,alpha);
				} else {
					for (i = 1; i < width - 1; i += 1) {
						draw_sprite_ext(spr_terrain_editor,18,x+i*20,floorY,1,1,0,layerColor,alpha);
					}
				
					draw_sprite_ext(spr_terrain_editor,17,x,floorY,1,1,0,layerColor,alpha);
					draw_sprite_ext(spr_terrain_editor,19,x+(width-1)*20,floorY,1,1,0,layerColor,alpha);
				}
			} else {
				// Single space
				if floorY = y || obj_z_mode.mode = 0 {
					draw_sprite_ext(spr_terrain_editor,9,x,floorY,1,1,0,layerColor,alpha);
				} else {
					draw_sprite_ext(spr_terrain_editor,16,x,floorY,1,1,0,layerColor,alpha);
				}
			}
		
			#endregion
			
			// Initialize shadow iteration
			for (i = 0; i < width; i += 1) {
				for (j = 0; j < height; j += 1) {
					shadowed[i,j] = 0;
				}
			}
			
			// Draw Shadow
			if zcieling >= 0 {
				#region
				
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
				
				#endregion
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

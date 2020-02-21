/// @description Depth and Baking

// Update floorMax
if updateZRange {
	updateZRange = false;
	
	if obj_z_mode.mode = 0 {
		floorY = y;
		cielY = y + (zfloor - zcieling) * 20;
	} else {
		var floorMax = y + (zfloor - obj_z_max.z) * 20;
		var floorMin = y + (zfloor - obj_z_min.z) * 20;
		
		floorY = clamp(y, floorMax, y + (zfloor + zcieling) * 20);
		cielY = clamp(y + (zfloor - zcieling) * 20, y, floorMin);
	}
}

// Position has changed
if lastX != x || lastY != y || lastWidth != width || lastCieling != zcieling {
	#region
	
	// Update depth
	depth = obj_editor_gui.depth - (y + zfloor*20 + 20) - zfloor - depthOffset;
	
	// Update minimap
	scr_editor_map(lastX-20,lastY-20,lastX-20+(lastWidth+2)*20,lastY-20+(height+zfloor-lastCieling+1)*20,self.id);
	scr_editor_map(x-20,y-20,x-20+(width+2)*20,y-20+(height+zfloor-zcieling+1)*20,-1);
	
	lastX = x;
	lastY = y;
	lastWidth = width;
	lastCieling = zcieling;
	
	#endregion
}

if placed = 1 {
	if !surface_exists(tileSurfaceDraw) {
		calculateSub = true;
		surfaceResize = true;
		tileSurfaceDraw = surface_create(20,20);
   }
	
	if !surface_exists(marbleSurface) {
		calculateSub = true;
		surfaceResize = true;
		marbleSurface = surface_create(20,20);
	}
	
	// Resizing the game window
	if surfaceResize {
		#region
		
		surfaceResize = false;
		calculateSub = true;
		
		for (i = 0; i <= tileLayerCount; i += 2) {
			if layerType[i] = 1 { // Marble layer
				if layerVisible[i] {
					bakeMarble = true;
				} else {
					marbleLostResize = true;
					// bakeMarble is true when the visibility is toggled on
					// in obj_tiles_layers
				}
				
				break;
			}
		}
		
		tileSurfaceDraw = surface_create((width + 2) * 20,(height + zfloor - zcieling + 1) * 20);
		
		if zfloor - zcieling > 0 {
			marbleSurface = surface_create(width * 20,(height + zfloor - zcieling) * 20);
		} else {
			marbleSurface = surface_create(width * 20,20);
		}
		
		#endregion
	}
	
	// Generate marble streaks
	if genMarble {
		#region
		
		genMarble = false;
		bakeMarble = true;
		hasMarble = true;
		
		// Initialize variables
		#region
		
		hasAdjacentLeftAbove = false;
		hasAdjacentRightAbove = false;
		hasAdjacentLeft = false;
		hasAdjacentRight = false;
		
		hasAdjacentDown = false;
		obj_editor_terrain_par.marbleHasBeenWiped = false;
		
		#endregion
		
		show_debug_message("");
		
		// Wipe marble recursively
		scr_marble_wipe();
		
		// Calculate streaks recursively
		scr_marble_reset_recursion();
		scr_marble_genstreaks(5,streaksCol[5]); // Light streaks
		
		scr_marble_reset_recursion();
		scr_marble_genstreaks(6,streaksCol[6]); // Dark streaks
		
		// Draw marble texture recursively
		scr_marble_draw_texture(5);
		scr_marble_draw_texture(6);
		
		scr_marble_draw_aa();
		scr_marble_draw_details();
		
		#endregion
	}
	
	if bakeMarble {
		// Draw texture to surface
		#region
		
		bakeMarble = false;
		calculateSub = true;
		
		if surface_exists(marbleSurface) {
			surface_resize(marbleSurface,width*20,(height + zfloor - zcieling)*20);
		} else {
			marbleSurface = surface_create(width*20,(height + zfloor - zcieling)*20);
		}
		
		surface_set_target(marbleSurface);
		draw_clear_alpha(c_white,0);
		
		for (i = 0; i < width * 20; i += 1) {
			for (j = 0; j < (height + zfloor - zcieling) * 20; j += 1) {
				if marblePixelColInd[i,j] >= 0 {
					if flip {
						// Skip pixels above angle offset
						if j >=  angleStartY - i*angleSlope {
							draw_set_color( marbleCol[marblePixelColInd[i,j]] );
							draw_rectangle( i, j, i, j, false );
						}
					} else {
						// Skip pixels below angle offset
						if j <= angleStartY + (zfloor - zcieling) * 20 - i*angleSlope {
							draw_set_color( marbleCol[marblePixelColInd[i,j]] );
							draw_rectangle( i, j, i, j, false );
						} else {
							break;
						}
					}
				}
			}
		}
		
		// Debug transfuse
		draw_set_alpha(0.75);
		
		for (i = 0; i < marbleDebugPixelCount; i += 1) {
			draw_set_color(marbleCol[marbleDebugPixelColInd[i]]);
			draw_rectangle(marbleDebugPixelX[i],marbleDebugPixelY[i],marbleDebugPixelX[i],marbleDebugPixelY[i],false);
		}
		
		draw_set_alpha(1);
		
		surface_reset_target();
		
		#endregion
	}
	
	// Bake tile surfaces
	if calculateSub {
		#region
		
		calculateSub = false; // Recalculating the surface
		surface_resize(tileSurfaceDraw, (width + 2) * 20, (height + zfloor - zcieling + 1) * 20);
		
		surface_set_target(tileSurfaceDraw);
		draw_clear_alpha(c_white,0);
		surface_reset_target();
		
		tileSurfaceCalc = surface_create((width + 2) * 20,(height + zfloor - zcieling + 1) * 20);
		surface_set_target(tileSurfaceCalc);
		draw_clear_alpha(c_white,0);
		
		for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
			if layerVisible[k] {
				if layerType[k] = 0 { // Tiles layer
					#region
					
					for (i = 0; i < width + 2; i += 1) {
						for (j = 0; j < height + zfloor - zcieling + 1; j += 1) {
							if hasTile[scr_array_xy(i,j,tileArrayHeight),k] {
								draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k],tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k],20,20,i*20,j*20);
								
								// Subtract sub-layer
								if hasTile[scr_array_xy(i,j,tileArrayHeight),k+1] {
									gpu_set_blendmode(bm_subtract);
									draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k+1],tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k+1],20,20,i*20,j*20);
									gpu_set_blendmode(bm_normal);
								}
							}
						}
					}
					
					#endregion
				}
				
				if layerType[k] = 1 { // Marble layer
					#region
					
					draw_surface(marbleSurface,20,20);
					
					for (i = 1; i < width + 1; i += 1) {
						for (j = 1; j < height + zfloor - zcieling + 1; j += 1) {
							// Pass in marble
							if hasTile[scr_array_xy(i,j,tileArrayHeight),k] {
								with obj_tiles_grid {
									if i = other.i && j = other.j {
										// Copy marble into grid
										if surface_exists(marbleSurface) {
											surface_set_target(marbleSurface);
											draw_clear_alpha(c_white,0);
											draw_surface_part(other.marbleSurface,(i-1)*20,(j-1)*20,20,20,0,0);
											surface_reset_target();
										}
									}
								}
							}
							
							// Subtract sub-layer
							if hasTile[scr_array_xy(i,j,tileArrayHeight),k+1] {
								gpu_set_blendmode(bm_subtract);
								draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k+1],tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k+1],20,20,i*20,j*20);
								gpu_set_blendmode(bm_normal);
							}
						}
					}
					
					#endregion
				}
				
				// Add layer to the drawing surface
				surface_copy(tileSurfaceDraw, 0, 0, tileSurfaceCalc);
			}
		}
		
		surface_reset_target();
		surface_free(tileSurfaceCalc);
		
		// Update minimap
		scr_editor_map(x-20,y-20,x-20+(width+2)*20,y-20+(height+zfloor-zcieling+1)*20,-1);
		
		#endregion
	}
}

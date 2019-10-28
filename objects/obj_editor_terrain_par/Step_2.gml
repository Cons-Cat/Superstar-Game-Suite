/// @description Depth and Baking
depth = obj_editor_gui.depth -(y + zfloor*20 + 20) - zfloor - depthOffset;

if placed = 1 {
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
			marbleSurfaceSide = surface_create(width * 20,(height + zfloor - zcieling) * 20);
		} else {
			marbleSurfaceSide = surface_create(width * 20,20);
		}
		
		#endregion
	}
	
	// Generate marble streaks
	if genMarble {
		#region
		
		genMarble = false;
		bakeMarble = true;
		
		// Initialize variables
		#region
		
		hasAdjacentLeft = false;
		hasAdjacentRight = false;
		hasAdjacentDown = false;
		
		marbleNetPixels = 0;
		marbleSamplesLight = ceil( width * ( height + zfloor - zcieling ) );
		marbleSamplesDark = floor( width * ( height + zfloor - zcieling ) );
		edgeStreakCountRead = 0;
		edgeStreakCountWrite = 0;
		transfuseIterate = 0;
		
		for (i = 0; i < width * 20; i += 1) {
			for (j = 0; j < ( height + zfloor - zcieling ) * 20; j += 1) {
				marblePixelCol[i,j] = 3;
			}
		}
		
		#endregion
		
		// Transfuse streaks from adjacent terrain
		#region
		
		for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
			tempInst = instance_find(obj_editor_terrain_par,i);
			
			if tempInst.id != self.id { // Exclude itself from the set
				if tempInst.y + (tempInst.height + tempInst.zfloor) * 20 = self.y + (self.height + self.zfloor) * 20 {
					// Transfuse rightward streaks
					if tempInst.x + tempInst.width * 20 = self.x {
						if tempInst.y <= self.y {
							hasAdjacentLeft = true;
						}
						
						edgeStreakCountRead = tempInst.edgeStreakCountWrite;
						
						for (j = 0; j < edgeStreakCountRead; j += 1) {
							if tempInst.x + tempInst.edgeStreakX[j] <= self.x + 2 {
								transfusedSampleX[j] = 0;
								transfusedSampleY[j] = ( self.height + self.zfloor ) * 20 - ( tempInst.height + tempInst.zfloor - tempInst.edgeStreakY[j] );
								//show_debug_message("y: " + string(transfusedSampleY[j]));
								transfusedSampleDir[j] = tempInst.edgeStreakDir[j];
								// transfusePixelValue[j] = tempInst.edgeStreakValue[j];
								
								transfusedDistributionX[j] = 0;
								transfusedDistributionY[j] = transfusedSampleY[j] div 20;
							}
						}
					}
					
					// Transfuse leftward streaks
					if tempInst.x = self.x + self.width * 20 {
						if tempInst.y <= self.y {
							hasAdjacentRight = true;
						}
					}
				}
				
				
				// Transfuse upward streaks
				if tempInst.y = self.y + self.height*20 {
					if tempInst.x + tempInst.width*20 >= self.x + self.width*20 {
						if tempInst.x <= self.x {
							if tempInst.zfloor = self.zfloor {
								hasAdjacentDown = true;
								show_message(i);
							}
						}
					}
				}
			}
		}
		
		#endregion
		
		// Calculate streak values
		#region
		
		randomize();
		
		for (i = 0; i < marbleSamplesLight + marbleSamplesDark; i += 1) {
			// Initialize streak
			var initializeNew = true;
			var distributionX = i;
			var distributionY = 0;
			
			if distributionX >= marbleSamplesLight {
				distributionX -= marbleSamplesLight;
			}
			
			while distributionX >= width {
				distributionX -= width;
				distributionY += 1;
			}
			
			// Initialize a transfused streak
			for (j = 0; j < edgeStreakCountRead; j += 1) {
				transfuseIterate = j;
				
				if distributionX = transfusedDistributionX[j] && distributionY = transfusedDistributionY[j] {
					marbleSampleX = transfusedSampleX[j];
					marbleSampleY = transfusedSampleY[j];
					marbleSampleDir = transfusedSampleDir[j]
					//show_debug_message(string(id) + " Read: " + string(transfuseIterate));
					
					initializeNew = false;
					break;
				}
			}
			
			if initializeNew {
				// Initialize a new streak
				marbleSampleX = random_range(5 + distributionX * 20, 15 + distributionX * 20);
				marbleSampleY = random_range(5 + distributionY * 20, 15 + distributionY * 20);
					
				if hasAdjacentLeft {
					marbleSampleDir = floor(random(180)) + 90;
				}
				if hasAdjacentRight {
					marbleSampleDir = (floor(random(180)) + 270);
				}
				if !hasAdjacentLeft && !hasAdjacentRight {
					marbleSampleDir = floor(random(360));
				}
			}
			
			marbleSampleLength = round( (width * 20) / ( (marbleSamplesDark + marbleSamplesLight) / 4.0 ) * 20 * random_range(0.85,1.15));
			
			for (j = 0; j < marbleSampleLength; j += 1) {
				marbleNetPixels += 1;
				
				// Develop streak
				marbleSampleDir += random_range(-38,38);
				marbleSampleX += lengthdir_x(1,marbleSampleDir);
				marbleSampleY += lengthdir_y(1,marbleSampleDir);
				
				// Develop girth
				marbleSampleGirth[marbleNetPixels] = marbleSampleGirth[marbleNetPixels - 1];
				
				if j < marbleSampleLength - marbleSampleGirth[marbleNetPixels] {
					marbleSampleGirth[marbleNetPixels] += random_range(-0.55,0.55);
				} else {
					marbleSampleGirth[marbleNetPixels] -= 1;
				}
				
				// Girth limits
				if marbleSampleGirth[marbleNetPixels] < 0.5 {
					marbleSampleGirth[marbleNetPixels] = 0.5;
				}
				if marbleSampleGirth[marbleNetPixels] > 4.5 {
					marbleSampleGirth[marbleNetPixels] = 4.5;
				}
				
				marbleSampleGirth[marbleNetPixels + 1] = marbleSampleGirth[marbleNetPixels];
				
				// Define where a pixel is placed
				marblePixelX[marbleNetPixels] = marbleSampleX;
				marblePixelY[marbleNetPixels] = marbleSampleY;
				marbleStreakDir[marbleNetPixels] = marbleSampleDir;
				
				// Define the value of the pixel
				if initializeNew {
					if i <= marbleSamplesLight {
						// Light streaks
						if marbleSampleGirth[marbleNetPixels] >= 1 {
							marblePixelValue[marbleNetPixels] = 5;
						} else {
							// Taper value
							marblePixelValue[marbleNetPixels] = 4;
						}
					} else {
						// Dark streaks
						if marbleSampleGirth[marbleNetPixels] >= 1 {
							marblePixelValue[marbleNetPixels] = 6;
						} else {
							// Taper value
							marblePixelValue[marbleNetPixels] = 5;
						}
					}
				} else {
					marblePixelValue[marbleNetPixels] = 7; //transfusePixelValue[transfuseIterate];
				}
				
				// Store data for transfusing streaks onto external terrain surfaces
				if /*marblePixelX[marbleNetPixels] <= 2 ||*/ marblePixelX[marbleNetPixels] >= width * 20 - 2 {
					edgeStreakX[edgeStreakCountWrite] = marblePixelX[marbleNetPixels];
					edgeStreakY[edgeStreakCountWrite] = marblePixelY[marbleNetPixels];
					edgeStreakDir[edgeStreakCountWrite] = marbleSampleDir;
					// edgeStreakValue[edgeStreakCountWrite] = marblePixelValue[marbleNetPixels];
					
					edgeStreakCountWrite += 1;
					
					if initializeNew {
						//show_debug_message(string(id) + " Write: " + string(edgeStreakCountWrite));
					}
					
					break;
				}
			}
		}
		
		#endregion
		
		// Calculate basic pixels
		#region
		
		// Generate circle noise
		for (i = -10; i < width * 20 + 10; i += floor(irandom_range(4,11))) {
			for (j = -10; j < (height + zfloor - zcieling) * 20 + 10; j += floor(irandom_range(4,7))) {
				var radius = 2 + random(4);
				
				scr_marble_draw_circle(i,j,radius,4);
			}
		}
		
		// Erase circle noise around top edges
		if zfloor - zcieling > 0 {
			for (j = 0; j < height * 20 - 1; j += 1) {
				if !hasAdjacentLeft {
					marblePixelCol[0,j] = 3;
				}
				if !hasAdjacentRight {
					marblePixelCol[width * 20,j] = 3;
				}
			}
		}
		
		// Draw marble streaks
		for (i = 0; i <= marbleNetPixels; i += 1) {
			scr_marble_draw_streak(marblePixelX[i], marblePixelY[i], marbleSampleGirth[i], marbleStreakDir[i], marbleAngleOffset, marblePixelValue[i]);
		}
		
		#endregion
		
		// Calculate detail pixels
		#region
		
		// Blend corners with anti-aliasing
		for (zz = 0; zz <= 1; zz += 1) { // Iterate between light and dark streak
			for (i = 0; i < width*20; i += 1) {
				for (j = 0; j < (height + zfloor - zcieling) * 20; j += 1) {
					// Focus on either dark or light streaks
					if zz = 0 {
						// Blend light streaks first
						k = 5;
					} else {
						// Blend dark streaks secondly
						k = 6;
					}
					
					var netK = k;
					
					var adjacentCount = 0;
					var dirCheck = 0;
					
					if marblePixelCol[i,j] = k {
						continue;
					}
					
					repeat(4) {
						dirCheck += 1;
						
						if dirCheck = 1 {
							var ii = i - 1;
							var jj = j;
						}
						if dirCheck = 2 {
							var ii = i + 1;
							var jj = j;
						}
						if dirCheck = 3 {
							var ii = i;
							var jj = j - 1;
						}
						if dirCheck = 4 {
							var ii = i;
							var jj = j + 1;
						}
						
						// Limit within boundaries
						if ii < 0 || ii >= width * 20 { continue; }
						if jj < 0 || jj >= ( height + zfloor - zcieling) * 20 { continue; }
						
						tempColInd = marblePixelCol[ii,jj];
						
						// If the adjacent pixel's darkness is equal to the selected streak's darkness
						if tempColInd = k {
							adjacentCount += 1;
						}
						
						// If any adjacent pixel's darkness is greater than, increment the darkness of the anti-aliasing
						if tempColInd > k {
							netK = k + 1;
						}
					}
					
					// If the select pixel is in a corner
					if adjacentCount >= 2 {
						marblePixelCol[i,j] = netK - 1;
					}
				}
			}
		}
		
		// Lighten top surface
		for (i = 0; i < width*20; i += 1) {
			if flip {
				for (j = 0; j < height * 20; j += 1) {
					marblePixelCol[i,j] -= 2;
				}
			} else {
				for (j = 0; j < angleStartY + 1 - i*angleSlope; j += 1) {
					marblePixelCol[i,j] -= 2;
				}
			}
		}
		
		// If the terrain is not flat
		if zfloor - zcieling > 0 {
			for (i = 0; i < width * 20; i += 1) {
				// Bevel top edge
				if !hasAdjacentDown {
					if flip {
						marblePixelCol[i,height*20-1] = scr_marble_bevelpixel(i,height*20-1);
					} else {
						marblePixelCol[i,angleStartY - i*angleSlope] = scr_marble_bevelpixel(i,angleStartY - i*angleSlope);
					}
				}
				
				// Occlude bottom edge
				if marblePixelCol[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] < 6 {
					marblePixelCol[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] += 1;
				}
			}
			
			// Bevel left edge
			if !hasAdjacentLeft {
				if flip {
					for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
						marblePixelCol[0, j] =  scr_marble_bevelpixel(0,j);
					}
				} else {
					for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
						marblePixelCol[0, j] = scr_marble_bevelpixel(0,j);
					}
				}
			}
			
			// Bevel right edge
			if !hasAdjacentRight {
				if flip {
					for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
						marblePixelCol[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
					}
				} else {
					for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
						marblePixelCol[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
					}
				}
			}
		}
		
		#endregion
		
		#endregion
	}
	
	if bakeMarble {
		// Draw texture to surface
		#region
		
		bakeMarble = false;
		calculateSub = true;
		
		surface_resize(marbleSurfaceSide,width*20,(height + zfloor - zcieling)*20);
		surface_set_target(marbleSurfaceSide);
		draw_clear_alpha(c_white,0);
		
		for (i = 0; i < width * 20; i += 1) {
			for (j = 0; j < (height + zfloor - zcieling) * 20; j += 1) {
				if marblePixelCol[i,j] != -1 {
					if flip {
						// Skip pixels above angle offset
						if j >=  angleStartY - i*angleSlope {
							draw_set_color( marbleCol[marblePixelCol[i,j]] );
							draw_rectangle( i, j, i, j, false );
						}
					} else {
						// Skip pixels below angle offset
						if j <= angleStartY + (zfloor - zcieling) * 20 - i*angleSlope {
							draw_set_color( marbleCol[marblePixelCol[i,j]] );
							draw_rectangle( i, j, i, j, false );
						} else {
							break;
						}
					}
				}
			}
		}
		
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
					
					draw_surface(marbleSurfaceSide,20,20);
					
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
											draw_surface_part(other.marbleSurfaceSide,(i-1)*20,(j-1)*20,20,20,0,0);
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
		
		#endregion
	}
}

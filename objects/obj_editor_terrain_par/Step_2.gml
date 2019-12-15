/// @description Depth and Baking

// Position has changed
if lastX != x || lastY != y || lastWidth != width || lastCieling != zcieling {
	#region
	
	// Update depth
	depth = obj_editor_gui.depth -(y + zfloor*20 + 20) - zfloor - depthOffset;
	
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
		
		hasAdjacentLeft = false;
		hasAdjacentRight = false;
		hasAdjacentDown = false;
		
		streakNetIterations = 0;
		streaksLight = ceil( width * ( height + zfloor - zcieling ) );
		streaksDark = floor( width * ( height + zfloor - zcieling ) );
		edgeStreakCountRead = 0;
		edgeStreakCountWrite = 0;
		transfuseIterate = 0;
		marbleDebugPixelCount = 0;
		
		for (i = 0; i < width * 20; i += 1) {
			for (j = 0; j < ( height + zfloor - zcieling ) * 20; j += 1) {
				marblePixelColInd[i,j] = 3;
			}
		}
		
		#endregion
		
		// Transfuse streaks from adjacent terrain
		#region
		
		for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
			#region
			
			tempInst = instance_find(obj_editor_terrain_par,i);
			
			if tempInst.id != self.id { // Exclude itself from the set
				if tempInst.y + (tempInst.height + tempInst.zfloor) * 20 = self.y + (self.height + self.zfloor) * 20 {
					// Transfuse rightward streaks
					if tempInst.x + tempInst.width * 20 = self.x {
						if tempInst.y <= self.y {
							hasAdjacentLeft = true;
						}
						
						/*edgeStreakCountRead = tempInst.edgeStreakCountWrite;
						
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
						}*/
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
							}
						}
					}
				}
			}
			
			#endregion
		}
		
		with obj_editor_terrain_par {
			if self.id != other.id { // Exclude itself from the set
				if hasMarble {
					// Transfer horizontal streaks
					#region
					
					// If z coordinate is the same
					if y + (height + zfloor)*20 = other.y + (other.height + other.zfloor)*20 {
						// If the y dimensions overlap
						if (y >= other.y && y <= other.y + (other.height + other.zfloor - other.zcieling)*20)
						|| (y <= other.y && y + (height + zfloor - zcieling)*20 >= other.y) {
							// If the x coordinates are adjacent
							if x = other.x + other.width*20 || x + width*20 = other.x {
								show_debug_message("Reading: ");
								other.edgeStreakCountRead = 0;
								
								for (i = 0; i < edgeStreakCountWrite; i += 1) {
									if (
									( x = other.x + other.width*20 && edgeStreakTransX[i] <= 2 )
									xor ( x + width*20 = other.x && edgeStreakTransX[i] >= width*20 - 2 )
									)
									{
										if ( ( zfloor = other.zfloor ) || ( y + edgeStreakTransY[i] > other.y + other.height*20 ) )
										//&& ( y + edgeStreakTransY[i] < other.y + ( other.height + other.zfloor - other.zcieling )*20 )
										{
											other.edgeStreakReadX[other.edgeStreakCountRead] = edgeStreakTransX[i] + ( self.x - other.x );
											other.edgeStreakReadY[other.edgeStreakCountRead] = edgeStreakTransY[i] - ( other.y - self.y );
											other.edgeStreakReadDir[other.edgeStreakCountRead] = edgeStreakTransDir[i];
											other.edgeStreakReadGirth[other.edgeStreakCountRead] = edgeStreakTransGirth[i];
											other.edgeStreakReadDark[other.edgeStreakCountRead] = edgeStreakTransDark[i];
											
											other.edgeStreakReadLength[other.edgeStreakCountRead] = edgeStreakTransLength[i];
											other.edgeStreakReadJ[other.edgeStreakCountRead] = edgeStreakTransJ[i];
											
											show_debug_message("edgeStreakCountRead: " + string(other.edgeStreakCountRead) );
											other.edgeStreakCountRead += 1;
										}
									}
								}
							}
						}
					}
					
					show_debug_message("----------------------------------------------------");
					
					#endregion
				}
			}
		}
		
		#endregion
		
		// Calculate streak values
		#region
		
		randomize();
		
		for (i = 0; i < streaksLight + streaksDark; i += 1) {
			// Initialize streak
			var initializeNew;
			var distributionX = i;
			var distributionY = 0;
			var transfusedThisStreak = false;
			
			while distributionX >= width {
				distributionX -= width;
				distributionY += 1;
			}
			
			if (transfuseIterate < edgeStreakCountRead)
			&& (
			( i <= streaksLight && !edgeStreakReadDark[transfuseIterate] )
			|| ( i > streaksDark && edgeStreakReadDark[transfuseIterate] )
			)
			{
				initializeNew = false;
			} else {
				initializeNew = true;
			}
			
			if initializeNew {
				// Initialize a new streak
				streakSampleX = random_range(5 + distributionX * 20, 15 + distributionX * 20);
				streakSampleY = random_range(5 + distributionY * 20, 15 + distributionY * 20);
				
				if hasAdjacentLeft {
					streakSampleDir = floor(random(180)) + 90;
				}
				if hasAdjacentRight {
					streakSampleDir = (floor(random(180)) + 270);
				}
				if !hasAdjacentLeft && !hasAdjacentRight {
					streakSampleDir = floor(random(360));
				}
				
				streakSampleLength = round( (width * 20) / ( (streaksDark + streaksLight) / 4.0 ) * 20 * random_range(0.655,1.05));
				streakSampleStart = 0;
			} else {
				// Transfuse an adjacent streak
				streakSampleX = edgeStreakReadX[transfuseIterate];
				streakSampleY = edgeStreakReadY[transfuseIterate];
				streakSampleDir = edgeStreakReadDir[transfuseIterate];
				marbleSampleGirth[0] = edgeStreakReadGirth[transfuseIterate];
				
				streakSampleLength = edgeStreakReadLength[transfuseIterate];
				streakSampleStart = edgeStreakReadJ[transfuseIterate];
				
				transfuseIterate += 1;
			}
			
			
			var transRight = false;
			var transLeft = false;
			var streakAnglePassing = streakSampleDir;
			var transEdgesPassed = 0;
			var tempEdgesPassed = transEdgesPassed;
			
			// Develop streak
			for (j = streakSampleStart; j < streakSampleLength; j += 1) {
				//if initializeNew && instance_number(obj_editor_terrain_par) > 1 { break; }
				
				// Give streak random turbulence
				streakSampleDir += random_range(-38,38);
				streakSampleDir = (streakSampleDir + 360) % 360;
				
				/*if angleDevelopMin != -1 {
					if streakSampleDir < angleDevelopMin {
						streakSampleDir = angleDevelopMin;
					}
					if streakSampleDir > angleDevelopMax {
						streakSampleDir = angleDevelopMax;
					}
				}*/
				
				streakSampleX += lengthdir_x(1,streakSampleDir);
				streakSampleY += lengthdir_y(1,streakSampleDir);
				
				// Extend streak length
				streakNetIterations += 1;
				
				// Develop girth
				marbleSampleGirth[streakNetIterations] = marbleSampleGirth[streakNetIterations - 1];
				
				if j < streakSampleLength - marbleSampleGirth[streakNetIterations] {
					marbleSampleGirth[streakNetIterations] += random_range(-0.55,0.55);
				} else {
					marbleSampleGirth[streakNetIterations] -= 1;
				}
				
				// Girth limits
				if marbleSampleGirth[streakNetIterations] < 1 {
					marbleSampleGirth[streakNetIterations] = 1;
				}
				if marbleSampleGirth[streakNetIterations] > 4.5 {
					marbleSampleGirth[streakNetIterations] = 4.5;
				}
				
				// Define where a pixel is placed
				marblePixelX[streakNetIterations] = streakSampleX;
				marblePixelY[streakNetIterations] = streakSampleY;
				marbleStreakDir[streakNetIterations] = streakSampleDir;
				
				// Define the value of the pixel
				//if initializeNew {
				if i <= streaksLight {
					// Light streaks
					if marbleSampleGirth[streakNetIterations] >= 1 {
						marblePixelValue[streakNetIterations] = 5;
					} else {
						// Taper value
						marblePixelValue[streakNetIterations] = 4;
					}
				} else {
					// Dark streaks
					if marbleSampleGirth[streakNetIterations] >= 1 {
						marblePixelValue[streakNetIterations] = 6;
					} else {
						// Taper value
						marblePixelValue[streakNetIterations] = 5;
					}
				}
				
				// Transfuse this streak
					// Transfuse across right edge
					if
					(
					floor(streakSampleX) >= width*20 - 1
					) {
						if !transRight {
							streakSampleX = width*20 - 1;
							
							transRight = true;
							streakAnglePassing = streakSampleDir;
							transEdgesPassed += 1;
							
							// Break streaks that pass rightward (outward)
							if ( streakAnglePassing <= 90 || streakAnglePassing >= 270 ) {
								transEdgesPassed = 2;
							}
						} else if (
						  transRight
						  && (
							  // Pass rightward, and back in leftward
							 /* (
								  ( streakAnglePassing <= 90 || streakAnglePassing >= 270 )
								  && (
									  ( streakSampleDir >= 90 )
									  && ( streakSampleDir <= 270 )
								  )
							  )
							  // Pass leftward, and back in rightward
							  ||*/ (
								  ( streakAnglePassing >= 90 && streakAnglePassing <= 270 )
								  && (
									  ( streakSampleDir <= 90 )
									  || ( streakSampleDir >= 270 )
								  )
							  )
						  )
						) {
							streakSampleX = width*20 - 1;
							transEdgesPassed += 1;
						}
					}
					
					// Transfuse across left edge
					if
					(
					floor(streakSampleX) <= 0
					) {
						if !transLeft 
						{
							streakSampleX = 0;
							
							transLeft = true;
							streakAnglePassing = streakSampleDir;
							transEdgesPassed += 1;
							
							// Break streaks that pass leftward (outward)
							if ( streakAnglePassing >= 90 && streakAnglePassing <= 270 ) {
								transEdgesPassed = 2;
							}
						} else if (
							transLeft
							&& (
								// Pass rightward, and back in leftward
								(
									( streakAnglePassing <= 90 || streakAnglePassing >= 270 )
									&& (
										( streakSampleDir >= 90 )
										&& (  streakSampleDir <= 270 )
									)
								)
								// Pass leftward, and back in rightward
								/*|| (
									( streakAnglePassing >= 90 && streakAnglePassing <= 270 )
									&& (
										( streakSampleDir <= 90 )
										|| ( streakSampleDir >= 270 )
									)
								)*/
							)
						) {
							streakSampleX = 0;
							transEdgesPassed += 1;
						}
					}
					
					if tempEdgesPassed != transEdgesPassed {
						tempEdgesPassed = transEdgesPassed;
						
						edgeStreakTransX[edgeStreakCountWrite] = streakSampleX;
						edgeStreakTransY[edgeStreakCountWrite] = streakSampleY;
						edgeStreakTransDir[edgeStreakCountWrite] = streakSampleDir;
						edgeStreakTransGirth[edgeStreakCountWrite] = marbleSampleGirth[streakNetIterations];
						edgeStreakTransLength[edgeStreakCountWrite] = streakSampleLength;
						edgeStreakTransJ[edgeStreakCountWrite] = j;
						
						// Dark or light
						if marblePixelValue[streakNetIterations] = 6 {
							edgeStreakTransDark[edgeStreakCountWrite] = true;
						} else {
							edgeStreakTransDark[edgeStreakCountWrite] = false;
						}
						
						// Debugging transfusion
						if transRight {
							marbleDebugPixelColInd[marbleDebugPixelCount] = 7; // Red
						}
						if transLeft {
							marbleDebugPixelColInd[marbleDebugPixelCount] = 8; // Blue
						}
						
						marbleDebugPixelX[marbleDebugPixelCount] = streakSampleX;
						marbleDebugPixelY[marbleDebugPixelCount] = streakSampleY;
						marbleDebugPixelCount += 1;
						
						edgeStreakCountWrite += 1;
					}
					
					// End the streak
					if tempEdgesPassed = 2 {
						streakSampleLength = 0;
						
						break;
					}
					
				//}
				//}
				
				// Beyond texture's vertical bounds
				if streakSampleY > (height + zfloor - zcieling) * 20 || streakSampleY < 0 {
					// Skip the rest of this streak
					streakNetIterations -= 1;
					
					break;
				}
			}
		}
		
		#endregion
		
		// Calculate basic pixels
		#region
		
		// Generate circle noise
		/*for (i = -10; i < width * 20 + 10; i += floor(irandom_range(4,11))) {
			for (j = -10; j < (height + zfloor - zcieling) * 20 + 10; j += floor(irandom_range(4,7))) {
				var radius = 2 + random(4);
				
				if ( (j div 5) * 5 ) % 2 = 0 {
					// Even rows
					scr_marble_draw_circle(i,j,radius,4);
				} else {
					// Odd rows
					scr_marble_draw_circle(i + radius,j,radius,4);
				}
			}
		}
		
		// Erase circle noise around top edges
		if zfloor - zcieling > 0 {
			for (j = 0; j < height * 20 - 1; j += 1) {
				if !hasAdjacentLeft {
					marblePixelColInd[0,j] = 3;
				}
				if !hasAdjacentRight {
					marblePixelColInd[width * 20,j] = 3;
				}
			}
		}*/
		
		// Draw marble streaks
		for (i = 1; i <= streakNetIterations; i += 1) {
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
					
					if marblePixelColInd[i,j] = k {
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
						
						tempColInd = marblePixelColInd[ii,jj];
						
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
						marblePixelColInd[i,j] = netK - 1;
					}
				}
			}
		}
		
		// Lighten top surface
		for (i = 0; i < width*20; i += 1) {
			if flip {
				for (j = 0; j < height * 20; j += 1) {
					marblePixelColInd[i,j] -= 2;
				}
			} else {
				for (j = 0; j < angleStartY + 1 - i*angleSlope; j += 1) {
					marblePixelColInd[i,j] -= 2;
				}
			}
		}
		
		// If the terrain is not flat
		if zfloor - zcieling > 0 {
			for (i = 0; i < width * 20; i += 1) {
				// Bevel top edge
				if !hasAdjacentDown {
					if flip {
						marblePixelColInd[i,height*20-1] = scr_marble_bevelpixel(i,height*20-1);
					} else {
						marblePixelColInd[i,angleStartY - i*angleSlope] = scr_marble_bevelpixel(i,angleStartY - i*angleSlope);
					}
				}
				
				// Occlude bottom edge
				if marblePixelColInd[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] < 6 {
					marblePixelColInd[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] += 1;
				}
			}
			
			// Bevel left edge
			/*if !hasAdjacentLeft {
				if flip {
					for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
						marblePixelColInd[0, j] =  scr_marble_bevelpixel(0,j);
					}
				} else {
					for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
						marblePixelColInd[0, j] = scr_marble_bevelpixel(0,j);
					}
				}
			}
			
			// Bevel right edge
			if !hasAdjacentRight {
				if flip {
					for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
						marblePixelColInd[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
					}
				} else {
					for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
						marblePixelColInd[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
					}
				}
			}*/
		}
		
		#endregion
		
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

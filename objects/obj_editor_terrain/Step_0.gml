/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Merge like instances
if canMerge {
	if collision_point(bbox_right+10,y+10,obj_editor_terrain,false,true) { // Merge rightward
		for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
			tempInst = instance_find(obj_editor_terrain,i);
			
			if tempInst.zfloor = self.zfloor && tempInst.zcieling = self.zcieling && tempInst.y = self.y && tempInst.x = self.x + self.width*20 {
				width += tempInst.width;
				resetArray = true;
				
				with tempInst {
					instance_destroy();
				}
				
				break;
			}
		}
	}
	
	if collision_point(bbox_left-10,y+10,obj_editor_terrain,false,true) { // Merge leftward
		for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
			tempInst = instance_find(obj_editor_terrain,i);
			
			if tempInst.zfloor = self.zfloor && tempInst.zcieling = self.zcieling && tempInst.y = self.y && tempInst.x = self.x - tempInst.width*20 {
				x = tempInst.x;
				width += tempInst.width;
				resetArray = true;
				
				with tempInst {
					instance_destroy();
				}
				
				break;
			}
		}
	}
	
	canMerge = false;
}

// Dimensional manipulation
if spawnButtons {
	#region
	
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_finite_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	
	#endregion
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

// Tile array
if resetArray && obj_editor_gui.mode != 3 {
	#region
	
	resetArray = false;
	calculateSub = true;
	sprMaterial = spr_tls_rectangle_default // Reset material
	tileRowWidth = width + 2;
	tileLayerCount = 0;
	
	surface_resize(tileSurfaceDraw, (width + 2) * 20, (height + zfloor - zcieling + 1) * 20);
	
	for (i = 0; i < width + 2; i += 1) {
		for (j = 0; j < zfloor - zcieling + 2; j += 1) {
			hasTile[scr_array_xy(i,j,tileRowWidth),0] = true;
			hasTile[scr_array_xy(i,j,tileRowWidth),1] = false;
			
			// Default to the designated coordinates of an empty tile
			tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 0;
			tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 120;
			
			if i = 1 && j = 1 {
				if width > 1 && height > 1 {
					// Top left floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 20;
				} else if width > 1 {
					// Left beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 0;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 220;
				} else if height > 1 {
					// Vertical top beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 80;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 180;
				} else {
					// Center edge
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 0;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 100;
				}
			}
			if i = width && j = 1 {
				if height > 1 && width > 1 {
					// Top right floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 20;
				} else if width > 1 {
					// Right beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 220;
				}
			}
			if i = 1 && j = height {
				if height > 1 && width > 1 {
					// Bottom left floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 60;
				} else if height > 1 {
					// Vertical bottom beam edge
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 80;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 220;
				}
			}
			if i = width && j = height {
				if width > 1 && height > 1 {
					// Bottom right floor corner index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 60;
				}
			}
			if i > 1 && i < width && j = 1 {
				if height > 1 {
					// Top floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 20;
				}
			}
			if i > 1 && i < width && j = height {
				if width > 1 {
					if height > 1 {
						// Bottom floor edge index
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 60;
					} else {
						// Center horizontal beam center edge index
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 220;
					}
				}
			}
			if j > 1 && j < height && i = 1 {
				if width > 1 && height > 1 {
					// Left floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 40;
				} else if height > 1 {
					// Center vertical beam edge index
					tileArrayDrawX[1,j] = 80;
					tileArrayDrawY[1,j] = 200;
				}
			}
			if height = 1 && width >= 2 {
				// Right horizontal beam edge index
				tileArrayDrawX[width,1] = 40;
				tileArrayDrawY[width,1] = 220;
			}
			if j > 1 && j < height && i = width {
				if width > 1 {
					// Right floor edge index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 60;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 40;
				}
			}
			if i > 1 && i < width && j > 1 && j < height {
				if width > 1 && height > 1 {
					// Center floor index
					tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
					tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 40;
				}
			}
			
			if j > height {
				if i = 1 {
					if width > 1 {
						// Left wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 100;
					} else {
						// Vertical beam center wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 80;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 100;
					}
				}
				if i = width {
					if width > 1 {
						// Right wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 60;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 100;
					}
				}
				if i > 1 && i < width && j = image_yscale {
					if width > 1 {
						// Bottom wall edge
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 120;
					}
				}
				if i > 1 && i < width && j < image_yscale {
					if width > 1 {
						// Center wall
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 40;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 100;
					}
				}
				if i = 1 && j = image_yscale {
					if width > 1 {
						// Bottom left wall corner
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 20;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 120;
					}
				}
				if i = width && j = image_yscale {
					if width > 1 {
						// Bottom right wall corner
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 60;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 120;
					}
				}
				if i = 1 && j = image_yscale {
					if width = 1 && image_yscale > 1 {
						// Vertical beam bottom edge
						tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),0] = 80;
						tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),0] = 120;
					}
				}
			}
		}
	}
	
	#endregion
	
	// Update the minimap
	with obj_panel_bot {
		scr_editor_map(other.x, other.y, other.x + other.width * 20, other.y + (other.zfloor - other.zcieling + other.height) * 20);
	}
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
		
		if tempInst.id != self.id {
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
							show_debug_message("y: " + string(transfusedSampleY[j]));
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
				show_debug_message(string(id) + " Read: " + string(transfuseIterate));
				
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
					show_debug_message(string(id) + " Write: " + string(edgeStreakCountWrite));
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
		scr_marble_draw_streak(marblePixelX[i],marblePixelY[i],marbleSampleGirth[i],marbleStreakDir[i],marblePixelValue[i]);
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
					
					//tempColInd = scr_marblecol_inverse( surface_getpixel(marbleSurfaceSide,ii,jj) );
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
		for (j = 0; j < height * 20; j += 1) {
			marblePixelCol[i,j] -= 2;
		}
	}
	
	// If the terrain is not flat
	if zfloor - zcieling > 0 {
		for (i = 0; i < width * 20; i += 1) {
			// Bevel top edge
			marblePixelCol[i,19] -= 1;
			
			// Occlude bottom edge
			if marblePixelCol[i,height * 19 + (zfloor - zcieling) * 20] < 6 {
				marblePixelCol[i,height * 19 + (zfloor - zcieling) * 20] += 1;
			}
		}
		
		// Bevel side edges
		for (j = 0; j < height * 20 - 1; j += 1) {
			if !hasAdjacentLeft {
				marblePixelCol[0, j] -= 1;
			}
			if !hasAdjacentRight {
				marblePixelCol[width * 20 - 1, j] -= 1;
			}
		}
	}
	
	#endregion
	
	#endregion
}

if bakeMarble {
	// Draw texture to surface
	#region
	
	surface_resize(marbleSurfaceSide,width*20,(height + zfloor - zcieling)*20);
	surface_set_target(marbleSurfaceSide);
	
	for (i = 0; i < width * 20; i += 1) {
		for (j = 0; j < ( height + zfloor - zcieling) * 20; j += 1) {
			draw_set_color( marbleCol[marblePixelCol[i,j]] );
			draw_rectangle( i, j, i, j, false);
		}
	}
	
	surface_reset_target();
	calculateSub = true;
	
	#endregion
}

// Bake tile surfaces
if calculateSub {
	#region
	
	calculateSub = false; // Recalculating the surface
	
	surface_set_target(tileSurfaceDraw);
	draw_clear_alpha(c_white,0);
	surface_reset_target();
	
	tileSurfaceCalc = surface_create((width + 2) * 20,(height + zfloor - zcieling + 1) * 20);
	surface_set_target(tileSurfaceCalc);
	draw_clear_alpha(c_white,0);
	
	for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
		if layerVisible[k] {
			if layerType[k] = 0 { // Tiles layer
				for (i = 0; i < width + 2; i += 1) {
					for (j = 0; j < height + zfloor - zcieling + 1; j += 1) {
						if hasTile[scr_array_xy(i,j,tileRowWidth),k] {
							draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k],20,20,i*20,j*20);
							
							// Subtract sub-layer
							if hasTile[scr_array_xy(i,j,tileRowWidth),k+1] {
								gpu_set_blendmode(bm_subtract);
								draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1],20,20,i*20,j*20);
								gpu_set_blendmode(bm_normal);
							}
						}
					}
				}
			}
			
			if layerType[k] = 1 { // Marble layer
				draw_surface(marbleSurfaceSide,20,20);
				
				for (i = 1; i < width + 1; i += 1) {
					for (j = 1; j < height + zfloor - zcieling + 1; j += 1) {
						// Subtract sub-layer
						if hasTile[scr_array_xy(i,j,tileRowWidth),k+1] {
							gpu_set_blendmode(bm_subtract);
							draw_sprite_part(tileDrawSpr,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1],20,20,i*20,j*20);
							gpu_set_blendmode(bm_normal);
						}
					}
				}
			}
			
			// Add layer to the drawing surface
			surface_copy(tileSurfaceDraw, 0, 0, tileSurfaceCalc);
		}
	}
	
	surface_reset_target();
	surface_free(tileSurfaceCalc);
	
	#endregion
}

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
}

// Tile array
if resetArray && obj_editor_gui.mode != 3 {
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
	
	// Bake marble map
	marbleNetPixels = 0;
	randomize();
	
	for (i = 0; i < marbleSamplesLight + marbleSamplesDark; i += 1) {
		marbleSampleLength = round( (width * 20) / ( (marbleSamplesDark + marbleSamplesLight) / 2 ) * 20 * random_range(0.85,1.15));
		
		marbleSampleX = random_range(10, width * 20);
		marbleSampleY = random_range(20, (height*2 + zfloor - zcieling) * 20);
		marbleSampleDir = floor(random(360));
		marbleSampleGirth[marbleNetPixels] = 1;
		
		for (j = 0; j < marbleSampleLength; j += 1) {
			// Develop streak
			marbleSampleDir += random_range(-38,38);
			marbleSampleX += lengthdir_x(1,marbleSampleDir);
			marbleSampleY += lengthdir_y(1,marbleSampleDir);
			
			// Develop girth
			marbleSampleGirth[marbleNetPixels] = 1;
			
			if j < marbleSampleLength - marbleSampleGirth[marbleNetPixels] {
				marbleSampleGirth[marbleNetPixels] += random_range(-0.45,1.25);
			} else {
				marbleSampleGirth[marbleNetPixels] -= 1;
			}
			
			marbleSampleGirth[marbleNetPixels + 1] = marbleSampleGirth[marbleNetPixels];
			
			if marbleSampleGirth[marbleNetPixels] < 1 {
				marbleSampleGirth[marbleNetPixels] = 1;
			}
			
			marblePixelX[marbleNetPixels] = marbleSampleX;
			marblePixelY[marbleNetPixels] = marbleSampleY;
			
			if marblePixelY[marbleNetPixels] < height *20 - 1 {
				if i < marbleSamplesLight {
					// Light streaks
					//marblePixelValue[marbleNetPixels] = 2;
					marblePixelValue[marbleNetPixels] = 4;
				} else {
					// Dark streaks
					//marblePixelValue[marbleNetPixels] = 4;
					marblePixelValue[marbleNetPixels] = 5;
				}
			} else {
				if i < marbleSamplesLight {
					// Light streaks
					marblePixelValue[marbleNetPixels] = 4;
				} else {
					// Dark streaks
					marblePixelValue[marbleNetPixels] = 5;
				}
			}
			
			// Store color value for anti-aliasing
			/*if marblePixelX[marbleNetPixels] >= 0 && marblePixelY[marbleNetPixels] >= 0 {
				marblePixelValueCol[marblePixelX[marbleNetPixels],marblePixelY[marbleNetPixels]] = marblePixelValue[marbleNetPixels];
			}*/
			
			marbleNetPixels += 1;
		}
	}
	
	surface_resize(marbleSurfaceSide,width*20,(height + zfloor-zcieling)*20);
	surface_resize(marbleSurfaceTop,width*20,height*2*20);
	
	surface_set_target(marbleSurfaceSide);
	
	draw_clear(marbleCol[2]);
	//draw_rectangle_color(0,height*20,width*20,(height + zfloor - zcieling)*20,marbleCol[2],marbleCol[2],marbleCol[2],marbleCol[2],false);
	
	// Draw marble streaks
	for (i = 0; i < marbleNetPixels; i += 1) {
		draw_set_color(marbleCol[marblePixelValue[i]]);
		draw_line_width(marblePixelX[i]-marbleSampleGirth[i]/2,marblePixelY[i]-marbleSampleGirth[i]/2,marblePixelX[i]+marbleSampleGirth[i]/2,marblePixelY[i]+marbleSampleGirth[i]/2,marbleSampleGirth[i]);
	}
	
	// Bake details
	var antialiasCount = 0;
	buffer = buffer_getpixel_begin(marbleSurfaceSide);
	bufferWidth = surface_get_width(marbleSurfaceSide);
	bufferHeight = surface_get_height(marbleSurfaceSide);
	
	// Generate buffer-compatible color data
	/*for (k = 0; k <= 5; k += 1) {
		draw_set_color(marbleCol[k]);
		draw_rectangle(k,0,k,0,false);
		
		var r = buffer_getpixel_r(buffer,k,0,bufferWidth,bufferHeight);
		var g = buffer_getpixel_g(buffer,k,0,bufferWidth,bufferHeight);
		var b = buffer_getpixel_b(buffer,k,0,bufferWidth,bufferHeight);
		bufferMarbleCol[k] = make_color_rgb(r,g,b);
	}*/
	
	// Lighten top surface
	for (i = 0; i < width*20; i += 1) {
		for (j = 0; j < height * 20; j += 1) {
			for (k = 2; k <= 5; k += 1) {
				var bufferCol = surface_getpixel(marbleSurfaceSide,i,j);
				
				if bufferCol = marbleCol[k] {
					draw_set_color(marbleCol[k-2]);
					draw_rectangle(i,j,i,j,false);
					
					break;
				}
			}
		}
	}
	
	// Blend corners with anti-aliasing
	for (jj = 0; jj <= 1; jj += 1) {
		for (i = 0; i < width*20; i += 1) {
			for (j = 0; j < (height + zfloor - zcieling) * 20; j += 1) {
				// Focus on either dark or light streaks
				if j < height * 20 {
					if jj = 0 {
						k = 2;
					} else {
						k = 3;
					}
				} else {
					if jj = 0 {
						k = 4;
					} else {
						k = 5;
					}
				}
				
				var adjacentCount = 0;
				var ii = 0;
				
				if surface_getpixel(marbleSurfaceSide,i,j) = marbleCol[k] {
					continue;
				}
				
				repeat(4) {
					ii += 1;
					
					if ii = 1 {
						var bufferi = i - 1;
						var bufferj = j;
					}
					if ii = 2 {
						var bufferi = i + 1;
						var bufferj = j;
					}
					if ii = 3 {
						var bufferi = i;
						var bufferj = j - 1;
					}
					if ii = 4 {
						var bufferi = i;
						var bufferj = j + 1;
					}
					
					clamp(bufferi,0,bufferWidth);
					clamp(bufferj,0,bufferHeight);
					
					//show_debug_message("i: " + string(i) + ", j: " + string(j));
					//var r = buffer_getpixel_r(buffer,bufferi,bufferj,bufferWidth,bufferHeight);
					//var g = buffer_getpixel_g(buffer,bufferi,bufferj,bufferWidth,bufferHeight);
					//var b = buffer_getpixel_b(buffer,bufferi,bufferj,bufferWidth,bufferHeight);
					//var bufferCol = make_color_rgb(r,g,b);
					
					bufferCol = surface_getpixel(marbleSurfaceSide,bufferi,bufferj);
					
					if bufferCol = marbleCol[k] {
						
						adjacentCount += 1;
					}
				}
				
				if adjacentCount > 1 && adjacentCount < 4 {
					antialiasCount += 1;
					
					antialiasX[antialiasCount] = i;
					antialiasY[antialiasCount] = j;
					antialiasVal[antialiasCount] = marbleCol[k-1];
					
					show_debug_message(string(adjacentCount) + ", antialiasCount: " + string(antialiasCount));
				}
			}
		}
	}
	
	for (i = 1; i < antialiasCount; i += 1) {
		draw_set_color(antialiasVal[i]);
		draw_rectangle(antialiasX[i],antialiasY[i],antialiasX[i],antialiasY[i],false);
	}
	
	buffer_delete(buffer);
	surface_reset_target();
	surface_copy_part(marbleSurfaceTop,0,0,marbleSurfaceSide,0,0,width*20,height*2*20);
}

// Bake surfaces
if calculateSub {
	surface_set_target(tileSurfaceDraw);
	draw_clear_alpha(c_white,0);
	surface_reset_target();
	
	tileSurfaceCalc = surface_create((width + 2) * 20,(height + zfloor - zcieling + 1) * 20);
	surface_set_target(tileSurfaceCalc);
	
	for (i = 0; i < width + 2; i += 1) {
		for (j = 0; j < height + zfloor - zcieling + 1; j += 1) {
			for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
				//if layerVisible[k] {
					for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Arbitrary
						if hasTile[scr_array_xy(i,j,tileRowWidth),k] {
							draw_sprite_part(sprMaterial,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k],20,20,i*20,j*20);
							
							if hasTile[scr_array_xy(i,j,tileRowWidth),k+1] {
								gpu_set_blendmode(bm_subtract);
								draw_sprite_part(sprMaterial,0,tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1],tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1],20,20,i*20,j*20);
								gpu_set_blendmode(bm_normal);
							}
							
							// Add subtracted layer to a surface
							surface_copy(tileSurfaceDraw, 0, 0, tileSurfaceCalc);
						}
					}
				//}
			}
		}
	}
	
	surface_reset_target();
	surface_free(tileSurfaceCalc);
	
	calculateSub = false;
}

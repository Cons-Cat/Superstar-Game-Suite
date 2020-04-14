/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Dimensional manipulation
if spawnButtons {
	#region
	
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_staircase) {
		trg = other.id;
		image_angle = other.angle;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z2) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_info_editor) {
		trg = other.id;
		str2 = "flip";
	}
	
	with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 0;
		buttonType = 1;
		label = "Angle";
		viewOn = 5;
		
		panelId = obj_subpanel_left.id;
		other.angleTrg = self.id;
		trg = other.id;
		angle = other.angle;
		sprWidth = (string_width(label) + 5) * 2;
	}
	/*with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 1;
		viewOn = 5;
		label = "Minor Radius";
		buttonType = 2;
		arbitraryVal = string(other.minorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		other.minorId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(x,y,"Instances",obj_subpanel_button) {
		sortIndex = 2;
		viewOn = 5;
		label = "Major Radius";
		buttonType = 2;
		arbitraryVal = string(other.majorRadius / 20);
		valueLength = string_width(arbitraryVal)*2 + 4;
		other.majorId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}*/
	
	#endregion
}

if placed < 2 {
	event_user(0);
}

if select {
	if instance_exists(angleTrg) {
		if angleTrg.select {
			angle = angleTrg.angle;
			
			if tempAngle != angle {
				angleRun = lengthdir_x(20,angle);
				angleRise = lengthdir_y(20,angle);
				
				if angleRun != 0 {
					angleRise /= abs(angleRun);
					angleRun /= abs(angleRun);
				} else {
					angleRise /= abs(angleRise);
				}
				
				if abs(angleRise) > 1 {
					angleRun /= abs(angleRise);
					angleRise /= abs(angleRise);
				}
				
				normalAngle = (angle + 90 + 360) % 360;
				obj_arrow_editor_staircase.image_angle = self.angle;
				
				stepCount = 5;
				stepLength = staircaseN / stepCount;
				altW = lengthdir_x( stepLength, angle );
				altH = lengthdir_y( stepLength, angle );
				
				stepPriority = angle > 180 && angle < 360;
				
				resetArray = true;
				tempAngle = angle;
			}
		}
	}
}

// Bake staircase
if resetArray {
	resetArray = false;
	calculateSub = true;
	tilingWidth = ceil(staircaseW / 20) + 2;
	tilingHeight = ceil(staircaseH / 20) + 1;
	tileArrayHeight = tilingHeight;
	tileLayerCount = 0;
	
	event_user(0); // Calculate coordinates
	
	// Clear staircase raster.
	for ( var i = 0; i < staircaseW; i++ ) {
		for ( var j = 0; j < staircaseH; j++ ) {
			staircaseRasterInd[i,j] = -1; // Empty pixel
			staircaseRasterTempInd[i,j] = -1;
		}
	}
	
	scr_draw_staircase(x - staircaseRasterX0, y - staircaseRasterY0, angleRun, angleRise, staircaseN, stepCount, obj_editor_gui.mode == 1 ? false : true);
	
	surface_resize(bakedStaircase, staircaseW, staircaseH);
	surface_resize(bakedStaircaseSelect, staircaseW, staircaseH);
	surface_resize(bakedStaircaseWireframe, staircaseW, staircaseH);
	surface_resize(bakedStaircaseWireframeSelect, staircaseW, staircaseH);
	
	// Bake solid staircase
	#region
	
	if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4 {
		surface_set_target(bakedStaircase);
		draw_clear_alpha(c_white, 0);
		
		for( var i = zfloor; i >= zcieling; i-- ) {
			if i > 0 && obj_editor_gui.mode = 0 {
				staircaseLayerColor[i] = col[ (i - 1) % 9 ];
				staircaseLayerColorWall[i] = colDark[ (i - 1) % 9 ];
			} else {
				staircaseLayerColor[i] = c_white;
				staircaseLayerColorWall[i] = c_dkgray;
			}
		}
		
		for ( var i = 0; i < staircaseW; i++ ) {
			for ( var j = 0; j < staircaseH; j++ ) {
				if staircaseRasterInd[i,j] != -1 {
					var lerpVal = staircaseRasterInd[i, j] / 9;
					var stepHeight = ( zfloor - zcieling) * 20 / stepCount;
					
					var k = floor(staircaseRasterInd[i, j]/2)*2 / (stepCount - 1)*2;
					var ezfloor = ( (zfloor)*20 - k*stepHeight ) / 20;
					ezfloor = ceil ( ezfloor );
					
					var stepCol;
					
					if staircaseRasterInd[i,j] % 2 = 0 {
						if zfloor - zcieling > 0 {
							stepCol = make_color_rgb(
								lerp( color_get_red(staircaseLayerColor[ezfloor]), color_get_red(staircaseLayerColor[ezfloor - 1]), lerpVal ),
								lerp( color_get_green(staircaseLayerColor[ezfloor]), color_get_green(staircaseLayerColor[ezfloor - 1]), lerpVal ),
								lerp( color_get_blue(staircaseLayerColor[ezfloor]), color_get_blue(staircaseLayerColor[ezfloor - 1]), lerpVal ),
							);
						} else {
							stepCol = staircaseLayerColor[zcieling];
						}
					} else {
						if zfloor - zcieling > 0 {
							stepCol = make_color_rgb(
								lerp( color_get_red(staircaseLayerColorWall[ezfloor]), color_get_red(staircaseLayerColorWall[ezfloor - 1]), lerpVal ),
								lerp( color_get_green(staircaseLayerColorWall[ezfloor]), color_get_green(staircaseLayerColorWall[ezfloor - 1]), lerpVal ),
								lerp( color_get_blue(staircaseLayerColorWall[ezfloor]), color_get_blue(staircaseLayerColorWall[ezfloor - 1]), lerpVal ),
							);
						} else {
							stepCol = staircaseLayerColorWall[zcieling];
						}
					}
					
					draw_set_color(stepCol);
					draw_point(i, j);
				}
			}
		}
		
		surface_reset_target();
	}
	
	#endregion
	
	// Bake highlighted solid staircase
	#region
	
	if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 3 {
		surface_set_target(bakedStaircaseSelect);
		draw_clear_alpha(c_white, 0);
	
		for ( var i = 0; i < staircaseW; i++ ) {
			for ( var j = 0; j < staircaseH; j++ ) {
				if staircaseRasterInd[i,j] != -1 {
					if staircaseRasterInd[i,j] % 2 = 0 {
						draw_set_color(obj_editor_gui.colOrange);
					} else {
						draw_set_color(obj_editor_gui.colOrangeShadow);
					}
				
					draw_point(i, j);
				}
			}
		}
		
		surface_reset_target();
	}
	
	#endregion
	
	// Bake wireframe staircase
	#region
	
	if obj_editor_gui.mode = 1 {
		surface_set_target(bakedStaircaseWireframe);
		draw_clear_alpha(c_white, 0);
		
		if zcieling > 0 {
			staircaseLayerColor[0] = col[ (zcieling - 1) % 9 ];
			staircaseLayerColorWall[0] = colDark[ (zcieling - 1) % 9 ];
		} else {
			staircaseLayerColor[0] = c_white;
			staircaseLayerColorWall[0] = c_gray;
		}
		
		for ( var i = 0; i < staircaseW; i++ ) {
			for ( var j = 0; j < staircaseH; j++ ) {
				if staircaseRasterInd[i,j] != -1 {
					if staircaseRasterInd[i,j] % 2 = 0 {
						draw_set_color(staircaseLayerColor[0]);
					} else {
						draw_set_color(staircaseLayerColorWall[0]);
					}
					
					draw_point(i, j);
				}
			}
		}
		
		surface_reset_target();
	}
	
	#endregion
	
	// Bake highlighted wireframe staircase
	#region
	
	if obj_editor_gui.mode = 1 {
		surface_set_target(bakedStaircaseWireframeSelect);
		draw_clear_alpha(c_white, 0);
		
		staircaseLayerColor[0] = obj_editor_gui.colOrange;
		staircaseLayerColorWall[0] = obj_editor_gui.colOrangeShadow;
		
		for ( var i = 0; i < staircaseW; i++ ) {
			for ( var j = 0; j < staircaseH; j++ ) {
				if staircaseRasterInd[i,j] != -1 {
					if staircaseRasterInd[i,j] % 2 = 0 {
						draw_set_color(staircaseLayerColor[0]);
					} else {
						draw_set_color(staircaseLayerColorWall[0]);
					}
					
					draw_point(i, j);
				}
			}
		}
		
		surface_reset_target();
	}
	
	#endregion
	
	//sprMaterial = sprite_create_from_surface(bakedStaircase, 20, 20, (tilingWidth-2)*20, (tilingHeight-2)*20, false, false, 0, 0);
	tileDrawSpr = sprite_create_from_surface(bakedStaircase, -20, -20, tilingWidth*20, tilingHeight*20, false, false, 0, 0);
	
	for (i = 0; i < tilingWidth; i += 1) {
		for (j = 0; j < tilingHeight; j += 1) {
			hasTile[scr_array_xy(i,j,tileArrayHeight),0] = true;
			hasTile[scr_array_xy(i,j,tileArrayHeight),1] = false;
			
			tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),0] = i*20;
			tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),0] = j*20;
		}
	}
}

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
	
	#endregion
}

// Trigger manipulation
if spawnTriggers {
	#region
	
	spawnTriggers = false;
	
	with instance_create_layer(x,y,"Instances",obj_panel_button_wheel) {
		sortIndex = 0;
		viewOn = 5;
		label = "Angle";
		buttonType = 1;
		angle = other.angle;
		
		other.angleTrg = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		sortIndex = 1;
		viewOn = 5;
		label = "Rise";
		buttonType = 2;
		arbitraryVal = string(other.angleRise);
		valueLength = string_width(arbitraryVal)*2 + 4;
		
		other.riseId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		sortIndex = 2;
		viewOn = 5;
		label = "Run";
		buttonType = 2;
		arbitraryVal = string(other.angleRun);
		valueLength = string_width(arbitraryVal)*2 + 4;
		
		other.runId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(x,y,"Instances",obj_panel_buton_input_num) {
		sortIndex = 3;
		viewOn = 5;
		label = "Steps";
		buttonType = 2;
		arbitraryVal = string(other.stepCount);
		valueLength = string_width(arbitraryVal)*2 + 4;
		
		other.stepsId = self.id;
		panelId = obj_subpanel_left.id;
		trg = other.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	#endregion
}

if placed < 1 {
	event_user(1);
}

if select {
	if instance_exists(riseId) {
		if riseId != -1 {
			if riseId.select {
				if riseId.arbitraryVal != "" {
					angleTrg.angle = point_direction(0, 0, real(runId.arbitraryVal), real(riseId.arbitraryVal));
					recalcAngle = true;
				}
			}
		}
	}
	
	if instance_exists(runId) {
		if runId != -1 {
			if runId.select {
				if runId.arbitraryVal != "" {
					angleTrg.angle = point_direction(0, 0, real(runId.arbitraryVal), real(riseId.arbitraryVal));
					recalcAngle = true;
				}
			}
		}
	}
	
	if instance_exists(angleTrg) {
		if angleTrg.select {
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
			
			riseId.arbitraryVal = string(angleRise);
			runId.arbitraryVal = string(angleRun);
		
			riseId.valueLength = string_width(riseId.arbitraryVal)*2 + 4;
			runId.valueLength = string_width(runId.arbitraryVal)*2 + 4;
			
			recalcAngle = true;
		}
	}
	
	if instance_exists(stepsId) {
		if stepsId != -1 {
			if stepsId.select {
				if stepsId.arbitraryVal != "" {
					if stepsId.arbitraryVal > 0 {
						stepCount = floor(real(stepsId.arbitraryVal));
						
						bakeRaster = true;
						resetArray = true;
					}
				}
			}
		}
	}
	
	if recalcAngle {
		recalcAngle = false;
		angle = angleTrg.angle;
		
		//if !angleTrg.select {
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
			//}
			
			obj_arrow_editor_staircase.image_angle = self.angle;
			
			stepLength = staircaseN / stepCount;
			altW = lengthdir_x( stepLength, angle );
			altH = lengthdir_y( stepLength, angle );
			
			stepPriority = angle > 180 && angle < 360;
			
			bakeRaster = true;
			resetArray = true;
			tempAngle = angle;
		}
	}
}

// Bake staircase
if bakeRaster {
	#region
	
	bakeRaster = false;
	
	event_user(1); // Calculate coordinates
	
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
	
	// Bake colored staircase
	#region
	
	surface_set_target(bakedStaircase);
	draw_clear_alpha(c_white, 0);
	
	for( var i = zfloor; i >= zcieling; i-- ) {
		if i > 0 && obj_editor_gui.mode = 0 {
			staircaseLayerColor[i] = col[ (i - 1) % 9 ];
			staircaseLayerColorWall[i] = colDark[ (i - 1) % 9 ];
		} else {
			staircaseLayerColor[i] = c_white;
			staircaseLayerColorWall[i] = colDarkSel;
		}
	}
	
	var stepHeight = (zfloor - zcieling) * 20 / stepCount;
	var stepCol;
	var colSpan;
	var colX;
	var lerpVal;
	
	for ( var i = 0; i < staircaseW; i++ ) {
		for ( var j = 0; j < staircaseH; j++ ) {
			if staircaseRasterInd[i, j] != -1 {
				var k = stepCount - (staircaseRasterInd[i, j] div 2);
				colSpan = zfloor - zcieling;
				colX = colSpan * (stepHeight * k) / ( (zfloor - zcieling) * 20 ) + zcieling;
				lerpVal = colX % 1;
					
				if staircaseRasterInd[i, j] % 2 = 0 {
					stepCol = make_color_rgb(
						lerp( color_get_red(staircaseLayerColor[floor(colX)]), color_get_red(staircaseLayerColor[ceil(colX)]), lerpVal ),
						lerp( color_get_green(staircaseLayerColor[floor(colX)]), color_get_green(staircaseLayerColor[ceil(colX)]), lerpVal ),
						lerp( color_get_blue(staircaseLayerColor[floor(colX)]), color_get_blue(staircaseLayerColor[ceil(colX)]), lerpVal ),
					)
				} else {
					stepCol = make_color_rgb(
						lerp( color_get_red(staircaseLayerColorWall[floor(colX)]), color_get_red(staircaseLayerColorWall[ceil(colX)]), lerpVal ),
						lerp( color_get_green(staircaseLayerColorWall[floor(colX)]), color_get_green(staircaseLayerColorWall[ceil(colX)]), lerpVal ),
						lerp( color_get_blue(staircaseLayerColorWall[floor(colX)]), color_get_blue(staircaseLayerColorWall[ceil(colX)]), lerpVal ),
					)
				}
					
				draw_set_color(stepCol);
				draw_point(i, j);
			}
		}
	}
		
	surface_reset_target();
	
	#endregion
	
	// Bake highlighted staircase
	#region
	
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
	
	#endregion
	
	// Bake backdrop sprite.
	if obj_editor_gui.mode = 3 {
		if sprite_exists(backdropSpr) {	sprite_delete(backdropSpr); }
		backdropSpr = sprite_create_from_surface(bakedStaircase, -20, -20, tilingWidth*20, tilingHeight*20, false, false, 0, 0);
	}
	
	#endregion
}

// Tile array
if resetArray && obj_editor_gui.mode != 3 {
	#region
	
	resetArray = false;
	calculateSub = true;
	
	tilingWidth = ceil(staircaseW / 20) + 2;
	tilingHeight = ceil(staircaseH / 20) + 1;
	tileArrayHeight = tilingHeight;
	tileLayerCount = 0;
	tileDefaultSpr = "spr_tls_rectangle_default";
	
	if sprite_exists(backdropSpr) {	sprite_delete(backdropSpr); }
	backdropSpr = sprite_create_from_surface(bakedStaircase, -20, -20, tilingWidth*20, tilingHeight*20, false, false, 0, 0);
	
	for (i = 0; i < tilingWidth; i += 1) {
		for (j = 0; j < tilingHeight; j += 1) {
			hasTile[scr_array_xy(i,j,tileArrayHeight),0] = false;
			hasTile[scr_array_xy(i,j,tileArrayHeight),1] = false;
		}
	}
	
	#endregion
}

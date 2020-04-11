/// @description Manipulating dimensions
event_inherited();

if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
	modeForSelectVal = obj_editor_gui.mode;
}

// Dimensional manipulation
if spawnButtons {
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
	
	with instance_create_layer(x,y,"Instances",obj_staircase_button_angle) {
		sortIndex = 0;
		viewOn = 5;
		
		panelId = obj_subpanel_left.id;
		other.angleTrg = self.id;
		trg = other.id;
		angle = other.angle;
		sprWidth = (string_width(label) + 5) * 2;
	}
}

// Initialize and update dimensional variables
if obj_editor_gui.mode != 2 {
	// See obj_editor_gui (Step) for comments on what these variables do
	if staircaseType = 0 {
		widthIterateCollisionOff = 1;
		
		#region
		zIterate = 2;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			
			widthIterate = 3;
			heightIterate = width + 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = width + 1;
			
			staircaseRun = 0;
			staircaseRise = -1;
			
			#endregion
		}
		if staircaseRotation = 4 {
			#region
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
					
			widthIterate = width + 2;
			heightIterate = width + 2;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y;
			
			staircaseRun = 0.5;
			staircaseRise = 0.5;
			
			rayXComponent = 21;
			rayYComponent = 21;
			
			#endregion
		}
		#endregion
	}
	if staircaseType = 1 {
		widthIterateCollisionOff = 2;
		
		#region
		zIterate = 2;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = 4;
			heightIterate = width + 1;
			
			if staircaseRotation = 2 {
				staircaseRun = 0.5;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x - 2;
			} else {
				staircaseRun = -0.5;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + 40;
			}
			
			staircaseRise = 0;
			collisionMaskRise = 1;
			rayYComponent = 0;
			slopeOriginOffsetY = y+20;
			widthIterateCollisionOff = 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = 2;
			
			staircaseRun = 0;
			staircaseRise = -0.5;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y+20;
			
			rayXComponent = 0;
			rayYComponent = -45;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			#region
			
			widthIterate = round(width/2) + 4;
			heightIterate = width + 2;
			
			if staircaseRotation = 3 {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.4;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = -0.4;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + width * 10 + 40;
			}
			
			staircaseRise = 0.2;
			collisionMaskRise = 2;
			rayYComponent = 25;
			slopeOriginOffsetY = y;
			
			#endregion
		}
		if staircaseRotation = 4 || staircaseRotation = 8 {
			#region
			
			widthIterate = width + 4;
			heightIterate = width + 3;
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
			
			if staircaseRotation = 4 {
				staircaseRun = 0.25;
				collisionMaskRun = 1;
				slopeOriginOffsetX = x;
				rayXComponent = 42;
			} else {
				staircaseRun = -0.25;
				collisionMaskRun = -1;
				slopeOriginOffsetX = x + width * 20 + 40;
				rayXComponent = -42;
			}
			
			staircaseRise = 0.25;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y - 20;
			rayYComponent = 42;
			
			#endregion
		}
		if staircaseRotation = 5 || staircaseRotation = 7 {
			#region
			
			sprCreate[4] = spr_solid;
			
			widthIterate = width + 3;
			heightIterate = floor(width/2) + 3;
			
			if staircaseRotation = 5 {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.2;
				rayXComponent = 25;
				collisionMaskRun = 2;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				staircaseRun = -0.2;
				rayXComponent = -25;
				collisionMaskRun = -2;
				slopeOriginOffsetX = x + width * 20 + 20;
			}
			
			staircaseRise = 0.4;
			rayYComponent = 45;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y - 20;
			
			#endregion
		}
		if staircaseRotation = 6 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			
			widthIterate = width + 2;
			heightIterate = 3;
			
			staircaseRun = 0;
			staircaseRise = 0.5;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y - 26;
			
			rayXComponent = 0;
			rayYComponent = 45;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		
		#endregion
	}
	if staircaseType = 2 {
		widthIterateCollisionOff = 1;
		
		#region
		zIterate = 3;
		
		if staircaseRotation = 0 || staircaseRotation = 2 {
			#region
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = 3;
			heightIterate = width + 2;
			
			if staircaseRotation = 0 {
				// Cast westward
				staircaseRun = -2;
				collisionMaskRun = 0;
				rayXComponent = -25;
				slopeOriginOffsetX = x+22; // IDK it just works .. largely
			} else {
				// Cast eastward
				staircaseRun = 2;
				collisionMaskRun = 0;
				rayXComponent = 22;
				slopeOriginOffsetX = x-1;
			}
			
			staircaseRise = 0;
			collisionMaskRise = 1;
			slopeOriginOffsetY = y+20;
			rayYComponent = 0;
			widthIterateCollisionOff = 1;
			
			#endregion
		}
		if staircaseRotation = 1 {
			#region
			
			sprCreate[0] = spr_solid;
			sprCreate[1] = -1;
			sprCreate[2] = -1;
			sprCreate[3] = -1;
			sprCreate[4] = -1;
			
			widthIterate = width + 2;
			heightIterate = 2;
			
			staircaseRun = 0;
			staircaseRise = -2;
			
			collisionMaskRun = 1;
			collisionMaskRise = 0;
			
			// Origin varies for every staircase variant
			slopeOriginOffsetX = x;
			slopeOriginOffsetY = y+20;
			
			rayXComponent = 0;
			rayYComponent = -25;
			
			widthIterateCollisionOff = 2;
			
			#endregion
		}
		if staircaseRotation = 3 || staircaseRotation = 9 {
			#region
			
			widthIterate = round(width/2) + 2;
			heightIterate = floor(width/2) * 2 + 1;
			
			if staircaseRotation = 3 {
				sprCreate[0] = spr_slopeL_05x_bot;
				sprCreate[1] = spr_slopeR_2x_bot;
				sprCreate[2] = spr_slopeR_05x;
				sprCreate[3] = spr_slopeL_2x;
				sprCreate[4] = spr_solid;
				staircaseRun = 0.8;
				collisionMaskRun = 1;
				rayXComponent = 45;
				slopeOriginOffsetX = x;
			} else {
				sprCreate[0] = spr_slopeL_2x_bot;
				sprCreate[1] = spr_slopeR_05x_bot;
				sprCreate[2] = spr_slopeR_2x;
				sprCreate[3] = spr_slopeL_05x;
				sprCreate[4] = spr_solid;
				staircaseRun = -0.8;
				collisionMaskRun = -1;
				rayXComponent = -45;
				slopeOriginOffsetX = x + width * 10 + 40;
			}
			
			staircaseRise = 0.4;
			collisionMaskRise = 2;
			rayYComponent = 25;
			slopeOriginOffsetY = y;
			
			#endregion
		}
		if staircaseRotation = 4 {
			#region
			
			sprCreate[0] = spr_slopeL_1x_bot;
			sprCreate[1] = spr_slopeR_1x_bot;
			sprCreate[2] = spr_slopeR_1x;
			sprCreate[3] = spr_slopeL_1x;
			sprCreate[4] = -1;
					
			widthIterate = width + 2;
			heightIterate = width + 2;
			
			staircaseRun = 1;
			staircaseRise = 1;
			
			#endregion
		}
		
		#endregion
	}
}

if placed < 2 {
	event_user(0);
}

if select {
	if instance_exists(angleTrg) {
		if angleTrg.select {
			if tempAngle != angle {
				angleRun = lengthdir_x(staircaseL,angle);
				angleRise = lengthdir_y(staircaseL,angle);
				
				if angleRun != 0 {
					angleRise /= abs(angleRun);
					angleRun /= abs(angleRun);
				} else {
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
	sprMaterial = spr_tls_staircase_default // Reset material
	
	staircaseL = width * 20 + width*2;
	
	event_user(0); // Calculate coordinates
	
	staircaseW = ceil(max(x1, x2, x3, x4)) - staircaseRasterX0 + 2;
	staircaseH = ceil(max(y1, y2, y3, y4, yy1, yy2, yy3, yy4)) - staircaseRasterY0 + 1;
	
	// Clear staircase raster.
	for ( var i = 0; i < staircaseW; i++ ) {
		for ( var j = 0; j < staircaseH; j++ ) {
			staircaseRasterInd[i,j] = -1; // Empty pixel
			staircaseRasterTempInd[i,j] = -1;
		}
	}
	
	surface_resize(bakedStaircase, staircaseW, staircaseH);
	surface_resize(bakedStaircaseSelect, staircaseW, staircaseH);
	
	// Bake colored staircase
	#region
	surface_set_target(bakedStaircase);
	
	scr_draw_staircase_alt(x - staircaseRasterX0, y - staircaseRasterY0, zfloor, zcieling, angleRun, angleRise, staircaseL, stepCount);
	draw_clear_alpha(c_white, 0);
	
	draw_set_color(c_white);
	for( var i = zfloor; i >= zcieling; i-- ) {
		if i > 0 {
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
	
	#endregion
	
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

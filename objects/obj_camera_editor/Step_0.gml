/// @description Move camera
camera_set_view_target(view_camera[0],-1);

if obj_editor_gui.mode != 2 {
	placeX = x;
	placeY = y;
	panX = 0;
	panY = 0;
	//placeZ = 0;
	zoomLevel = 1;
	anchored = false;
	cutscenePan = false;
	i = 0;
	
	// Keyboard movement
	if keyboard_check(vk_right) && !keyboard_check(vk_left) {
		if curAtX = gridAtX {
			gridAtX += 1;
			consecutiveMovesHor += 1;
		}
	}
	
	// Movement
	if gridAtX > curAtX {
		curAtX += gridSpeedHor;
		
		if curAtX > gridAtX {
			curAtX = gridAtX;
		}
	}
	
	if keyboard_check(vk_left) && !keyboard_check(vk_right) {
		if curAtX = gridAtX {
			gridAtX -= 1;
			consecutiveMovesHor += 1;
		}
	}
	
	// Movement
	if gridAtX < curAtX {
		curAtX -= gridSpeedHor;
		
		if curAtX < gridAtX {
			curAtX = gridAtX;
		}
	}
	
	if keyboard_check(vk_down) && !keyboard_check(vk_up) {
		if curAtY = gridAtY {
			gridAtY += 1;
			consecutiveMovesVer += 1;
		}
	}
	
	// Movement
	if gridAtY > curAtY {
		curAtY += gridSpeedVer;
		
		if curAtY > gridAtY {
			curAtY = gridAtY;
		}
	}
	
	if keyboard_check(vk_up) && !keyboard_check(vk_down) {
		if curAtY = gridAtY {
			gridAtY -= 1;
			consecutiveMovesVer += 1;
		}
	}
	
	// Movement
	if gridAtY < curAtY {
		curAtY -= gridSpeedVer;
		
		if curAtY < gridAtY {
			curAtY = gridAtY;
		}
	}
	
	// Barriers
	barrierHor = ceil( (room_width - obj_panel_left.baseX) / obj_editor_gui.realPortScaleHor );
	barrierVer = ceil( (-obj_panel_top.baseY) / obj_editor_gui.realPortScaleVer );
	
	if gridAtX < 0 {
		gridAtX = 0;
	}
	if curAtX < 0 {
		curAtX = 0;
	}
	
	if gridAtX > room_width div 20 - 16 {
		gridAtX = room_width div 20 - 16;
	}
	if curAtX > room_width div 20 - 16 {
		curAtX = room_width div 20 - 16;
	}
	
	if gridAtY < 0 {
		gridAtY = 0;
	}
	if curAtY < 0 {
		curAtY = 0;
	}
	
	if gridAtY > room_height div 20 - 9 {
		gridAtY = room_height div 20 - 9;
	}
	if curAtY > room_height div 20 - 9 {
		curAtY = room_height div 20 - 9;
	}
	
	// Consecutive moves
	if ( keyboard_check(vk_left) && keyboard_check(vk_right) ) || ( !keyboard_check(vk_left) && !keyboard_check(vk_right) ) {
		consecutiveMovesHor = 0;
	}
	if ( keyboard_check(vk_up) && keyboard_check(vk_down) ) || ( !keyboard_check(vk_up) && !keyboard_check(vk_down) ) {
		consecutiveMovesVer = 0;
	}
	
	// Default horizontal speed
	gridSpeedHor = 0.07;
	
	if consecutiveMovesHor >= 4 {
		// Faster speed
		gridSpeedHor = 0.15;
	}
	
	if consecutiveMovesHor >= 15 {
		// Super fast speed
		gridSpeedHor = 0.22;
	}
	
	// Default vertical speed
	gridSpeedVer = 0.07;
	
	if consecutiveMovesVer >= 4 {
		// Faster speed
		gridSpeedVer = 0.15;
	}
	
	if consecutiveMovesVer >= 15 {
		// Super fast speed
		gridSpeedVer = 0.22;
	}
	
	// Easing
	if gridAtX % 1 = 0 { gridGravX = 0; }
	if gridAtY % 1 = 0 { gridGravY = 0; }
	
	gridGravX = (power( 2 * ( (curAtX % 1) - 0.5 ), 3) * 2 + 2) / 4;
	gridGravY = (power( 2 * ( (curAtY % 1) - 0.5 ), 3) * 2 + 2) / 4;
	
	// Move camera view
	camera_set_view_pos(view_camera[0],barrierHor + floor(curAtX) * 20 + (gridGravX * 20), barrierVer + floor(curAtY) * 20 + (gridGravY * 20));
} else {
	// In play mode
	
	// Follow player
	if instance_exists(obj_player_overworld) {
		xTo = obj_player_overworld.x;
		yTo = obj_player_overworld.y;
		zTo = obj_player_overworld.jumpHeight;
		
		rightQuarter = x + 32;
		leftQuarter = x - 32;
		upQuarter = y - 22;
		downQuarter = y + 22;
		
		centerX = leftQuarter + (rightQuarter - leftQuarter)/2;
		centerY = upQuarter + (downQuarter - upQuarter)/2;
		
		if obj_player_overworld.x > rightQuarter {
			// Player is a quarter-screen rightward of center
			if accelX < 1 {
				accelX += 0.05;
			} else {
				accelX = 1;
			}
		} else if obj_player_overworld.x < leftQuarter {
			// Player is a quarter-screen leftward of center
			if accelX < 1 {
				accelX += 0.05;
			} else {
				accelX = 1;
			}
		}
		
		if obj_player_overworld.y > downQuarter {
			// Player is a quarter-screen downward of center
			if accelY < 1 {
				accelY += 0.05;
			} else {
				accelY = 1;
			}
		} else if obj_player_overworld.y < upQuarter {
			// Player is a quarter-screen upward of center
			if accelY < 1 {
				accelY += 0.05;
			} else {
				accelY = 1;
			}
		}
		
		// Update Z dimension when player lands on floor
		if obj_player_overworld.onGround {
			if placeZ != obj_player_overworld.jumpHeight {
				if accelZ < 1 {
					accelZ += 0.05;
				} else {
					accelZ = 1;
				}
				
				placeZ += (zTo - placeZ)/10*accelZ;
			}
		} else {
			// Fall down
			if obj_player_overworld.jumpHeight - obj_player_overworld.trgFinal < 65 {
				if obj_player_overworld.isFalling  {
					// Light fall
					if accelZ < 1 {
						accelZ += 0.05;
					} else {
						accelZ = 1;
					}
					
					placeZ += (zTo - placeZ)/10*accelZ;
				}
			} else {
				// Heavy fall
				placeZ = zTo + 65;
			}
		}
		
		if obj_player_overworld.x >= leftQuarter && obj_player_overworld.x <= rightQuarter {
			// Decelerate horizontal motion
			if accelX > 0 {
				accelX -= 0.06;
			} else {
				accelX = 0;
			}
		}
		if obj_player_overworld.y >= upQuarter && obj_player_overworld.y <= downQuarter {
			// Decelerate vertical motion
			if accelY > 0 {
				accelY -= 0.06;
			} else {
				accelY = 0;
			}
		}
		
		// 16:10 ratio
		if xTo > centerX {
			placeX += (xTo - rightQuarter)/16*accelX;
		} else {
			placeX += (xTo - leftQuarter)/16*accelX;
		}
		
		if yTo > centerY {
			placeY += (yTo - downQuarter)/10*accelY;
		} else {
			placeY += (yTo - upQuarter)/10*accelY;
		}
		
		// Update place
		x = placeX;
		y = placeY - placeZ;
		
		// Update zooming
		if zoomLevel != tempZoomLevel {
			// Get current size
			view_w = camera_get_view_width(view_camera[0]);
			view_h = camera_get_view_height(view_camera[0]);
			
			// Get new sizes by interpolating current and target zoomed size
			new_w = lerp(view_w, baseZoomWidth / zoomLevel, zoomSpd);
			new_h = lerp(view_h, baseZoomHeight / zoomLevel, zoomSpd);
			
			// Prevent zooming out of the world
			if new_w > room_width {
				new_w = room_width;
				new_h = room_width/16 * 9;
				
				zoomLevel = baseZoomWidth / new_w;
			}
			if new_h > room_height {
				new_h = room_height;
				new_w = room_height/9 * 16;
				
				zoomLevel = baseZoomHeight / new_h;
			}
			
			// Apply the new size
			//camera_set_view_size(view_camera[0], new_w, new_h);
			
			// Update temp value once the zooming finishes interpolation
			if abs(new_w - view_w) < 0.5 && abs(new_h - view_h) < 0.5 {
				tempZoomLevel = zoomLevel;
			}
		}
		
		// Cutscene panning
		if cutscenePan {
			if magnitudeTemp < 1 {
				magnitudeTemp += cutscenePanSpd;
			} else {
				magnitudeTemp = 1;
				cutscenePan = false;
			}
			
			anchorId.magnitude = ( dsin( magnitudeTemp / 1  * 180 - 90) + 1 ) / 2;
		}
		
		// Update view
		if !anchored {
			camera_set_view_pos(view_camera[0],x + panX - camera_get_view_width(view_camera[0])/2,y + panY - camera_get_view_height(view_camera[0])/2);
		} else {
			camera_set_view_pos(view_camera[0],( (x + panX) * (1 - anchorId.magnitude) ) + (anchorId.trgX * anchorId.magnitude) - camera_get_view_width(view_camera[0])/2, ( (y + panY) * (1 - anchorId.magnitude) ) + (anchorId.trgY * anchorId.magnitude) - placeZ - camera_get_view_height(view_camera[0])/2);
		}
	}
}

// Boundaries
/*if x < 260 {
	x = 260;
}
if x > room_width - 264 {
	x = room_width - 264;
}
if y < 174 {
	y = 174;
}
if y > room_height - 162 {
	y = room_height - 162;
}
if placeX < 260 {
	placeX = 260;
}
if placeX > room_width - 264 {
	placeX = room_width - 264;
}
if placeY < 174 {
	placeY = 174;
}
if placeY > room_height - 162 {
	placeY = room_height - 162;
}

if camera_get_view_x(view_camera[0]) < 4 {
	camera_set_view_pos(view_camera[0],4,camera_get_view_y(view_camera[0]));
}
if camera_get_view_x(view_camera[0]) > room_width - camera_get_view_width(view_camera[0]) {
	camera_set_view_pos(view_camera[0],room_width - camera_get_view_width(view_camera[0]),camera_get_view_y(view_camera[0]));
}
if camera_get_view_y(view_camera[0]) < 30 {
	camera_set_view_pos(view_camera[0],camera_get_view_x(view_camera[0]),30);
}*/

depth = obj_editor_gui.depth - 1;

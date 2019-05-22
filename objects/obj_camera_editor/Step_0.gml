/// @description Move camera
if obj_editor_gui.mode != 2 {
	x -= lengthdir_x(panMagnitudeTemp,panAngleTemp)*20;
	y -= lengthdir_y(panMagnitudeTemp,panAngleTemp)*20;
	placeX = x;
	placeY = y;
	//placeZ = 0;
	
	panMagnitudeTemp = 0;
	panMagnitudeSpd = 0;
	panMagnitudeDecelDistance = 0;
	panAngleTemp = 0
	i = 0;
	
	/*if mouse_check_button_pressed(mb_right) {
		tempX = mouse_x;
		tempY = mouse_y;
		spasmFix = false;
		spasmX[0] = 0;
		spasmX[2] = 1;
		spasmI = 0;
	}
	if mouse_check_button(mb_right) && spasmFix = false {
		if mouse_x != tempX {
			x += tempX - mouse_x;
			tempX = mouse_x;
			spasmX[spasmI] = x;
			
			if spasmI < 2 {
				spasmI += 1;
			} else {
				spasmI = 0;
			}
		}
		if mouse_y != tempY {
			y += tempY - mouse_y;
			tempY = mouse_y;
		}
	}
	if spasmX[0] = spasmX[2] {
		if spasmFix = false {
			spasmFix = true;
			alarm[0] = 20;
		}
	}*/
	
	// Arrow key movement
	if keyboard_check(vk_right) {
		x += 7;
	}
	if keyboard_check(vk_left) {
		x -= 7;
	}
	if keyboard_check(vk_down) {
		y += 7;
	}
	if keyboard_check(vk_up) {
		y -= 7;
	}
} else {
	// In play mode
	
	// Follow player
	if instance_exists(obj_player_overworld) {
		xTo = obj_player_overworld.x;
		yTo = obj_player_overworld.y;
		zTo = obj_player_overworld.jumpHeight;
		
		rightQuarter = camera_get_view_x(obj_editor_gui.cameraRealGame) + camera_get_view_width(obj_editor_gui.cameraRealGame)/2 + 32;
		leftQuarter = camera_get_view_x(obj_editor_gui.cameraRealGame) + camera_get_view_width(obj_editor_gui.cameraRealGame)/2 - 32;
		upQuarter = camera_get_view_y(obj_editor_gui.cameraRealGame) + 120 + placeZ;
		downQuarter = camera_get_view_y(obj_editor_gui.cameraRealGame) + 160 + placeZ;
		
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
		
		/*if trgRegion != -1 {
			if moving[i] {
					x = placeX + lengthdir_x(panMagnitudeTemp,panAngle[i])*20;
					y = placeY + lengthdir_y(panMagnitudeTemp,panAngle[i])*20 - obj_player_overworld.platOn;
				}
			
			panAngleTemp = panAngle[i];
			
			// Pan
			if panMagnitudeTemp <= panMagnitude[i] - panMagnitudeSpd {
				panMagnitudeTemp += panMagnitudeSpd;
			} else {
				// Snap to end
				panMagnitudeTemp = panMagnitude[i];
				//show_debug_message("snapped");
			}
			
			// Accelerate / Decelerate
			panMagnitudeDecelDistance = sqr(panMagnitudeSpdMax[i]) / (2*panEaseOut[i]) / 60;
			
			if panMagnitudeTemp < panMagnitude[i] - panMagnitudeDecelDistance {
				// Accelerate
				if panMagnitudeSpd < panMagnitudeSpdMax[i] && panEaseIn[i] != -1 {
					panMagnitudeSpd += panEaseIn[i];
				} else {
					// Max speed
					panMagnitudeSpd = panMagnitudeSpdMax[i];
				}
			} else {
				// Deccelerate
				if panMagnitudeSpd > 0.0075 && panEaseOut[i] != -1 {
					panMagnitudeSpd -= panEaseOut[i];
				} else {
					// Min speed
					panMagnitudeSpd = 0.0075;
				}
			}
		} else {
			if i < trgRegion.timeIndexCalc {
				while i < trgRegion.timeIndexCalc {
					moving[i] = false;
					i += 1;
				}
			} else {
				moving[i] = true;
			}
		}*/
		
		// Update place
		x = placeX;
		y = placeY - placeZ;
	}
}

// Boundaries
if x < 260 {
	x = 260;
}
if x > room_width - 264 {
	x = room_width - 264;
}
if y < 580 + 170 {
	y = 580 + 170;
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
if placeY < 580 + 170 {
	placeY = 580 + 170;
}
if placeY > room_height - 162 {
	placeY = room_height - 162;
}

depth = obj_editor_gui.depth - 1;

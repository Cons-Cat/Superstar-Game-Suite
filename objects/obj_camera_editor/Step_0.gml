/// @description Move camera
if obj_editor_gui.mode != 2 {
	x -= lengthdir_x(panMagnitudeTemp,panAngleTemp)*20;
	y -= lengthdir_y(panMagnitudeTemp,panAngleTemp)*20;
	
	panMagnitudeTemp = 0;
	panAngleTemp = 0;
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
	if trgRegion != -1 {
		if moving[i] {
			// Follow player
			if instance_exists(obj_player_overworld) {
				x = obj_player_overworld.x + lengthdir_x(panMagnitudeTemp,panAngle[i])*20;
				y = obj_player_overworld.y + lengthdir_y(panMagnitudeTemp,panAngle[i])*20 - obj_player_overworld.platOn;
			}
			panAngleTemp = panAngle[i];
			
			// Pan
			if panMagnitudeTemp <= panMagnitude[i] - panMagnitudeSpd {
				panMagnitudeTemp += panMagnitudeSpd;
			} else {
				panMagnitudeTemp = panMagnitude[i];
			}
			
			// Accelerate / Decelerate
			if panMagnitudeSpd < panMagnitudeSpdMax[i] && panMagnitudeSpdMax[i] != -1 {
				panMagnitudeSpd += panEaseIn[i];
			} else {
				panMagnitudeSpd = panMagnitudeSpdMax[i];
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
		}
	}
}

// Boundaries
if x < 260 {
	x = 260;
}
if x > room_width - 264 {
	x = room_width - 264;
}
if y < 576 + 174 {
	y = 576 + 174;
}
if y > room_height - 162 {
	y = room_height - 162;
}

depth = obj_editor_gui.depth - 1;

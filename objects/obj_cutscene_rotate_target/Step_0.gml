/// @description Insert description here
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 && ((relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20)) {
	mouseHover = true;
	
	if mouse_check_button_pressed(mb_left) {
		if mouse_y < obj_panel_bot.y {
			canDel = false;
			canPlace = true;
			calcAngleVals = true;
		}
	}
} else {
	mouseHover = false;
}

tempActionTime = 0;
j = 1;
originX[timeIndex] = originX[0];
originY[timeIndex] = originY[0];

// originX[0] and originY[0] are passed in externally

while tempActionTime < obj_panel_bot.longestRowLength {
	for (i = 1; i <= obj_panel_bot.totalActions; i += 1) {
		if obj_panel_bot.actionRowInd[i] = rowIndex {
			if obj_panel_bot.actionTime[i] = tempActionTime {
				if obj_panel_bot.actionInd[i] = 0 {
					show_debug_message(i);
					originX[j] = obj_panel_bot.xNode[i];
					originY[j] = obj_panel_bot.yNode[i];
					
					j += 1;
					
					break;
				}
				
				if obj_panel_bot.actionInd[i] = 1 {
					originX[j] = originX[j-1];
					originY[j] = originY[j-1];
					
					j += 1;
					if i = timeIndex {
						tempActionTime = obj_panel_bot.longestRowLength + 1;
					}
				}
			}
		}
	}
	
	tempActionTime += 1;
}

// Point angle at mouse
if gone {
	angle = point_direction(originX[j-1],originY[j-1] - (zfloor * 20),relativeMouseX,relativeMouseY - (zfloor * 20));
}

// Update angle for calculation
if calcAngleVals {
	calcAngleVals = false;
	
	// Keep >= 0 and < 360
	while angle >= 360 {
		angle -= 360;
	}
	while angle < 0 {
		angle += 360;
	}
	
	if angle <= (angle div 22.5)*22.5 + 15 && angle > (angle div 22.5)*22.5 - 15 {
		angleCalc = (angle div 22.5)*22.5;
	}
	
	// Top right quadrant
	if angleCalc >= 0 && angleCalc <= 90 {
		mirror = 1;
		flip = 1;
	}
	// Top left quadrant
	if angleCalc > 90 && angleCalc <= 180 {
		mirror = -1;
		flip = 1;
	}
	// Bottom left quadrant
	if angleCalc > 180 && angleCalc < 270 {
		mirror = -1;
		flip = -1;
	}
	// Bottom right quadrant
	if angleCalc >= 270 && angleCalc <= 360 {
		mirror = 1;
		flip = -1;
	}
	
	if abs(angleCalc % 90) = 0 {
		run = 2;
		rise = 0;
	}
	if abs(angleCalc % 90) = 22.5 {
		if mirror = flip {
			run = 2;
			rise = 1;
		} else {
			run = 1;
			rise = 2;
		}
	}
	if abs(angleCalc % 90) = 45 {
		run = 1;
		rise = 1;
	}
	if abs(angleCalc % 90) = 67.5 {
		if mirror = flip {
			run = 1;
			rise = 2;
		} else {
			run = 2;
			rise = 1;
		}
	}
	if abs(angleCalc % 180) = 90 {
		run = 0;
		rise = 2;
	}
	
	// Initialize x-y co-ordinates
	if initPosition {
		initPosition = false;
		
		xTo = originX[j-1] + run*radius*mirror;
		yTo = originY[j-1] - rise*radius*flip;
		angleExport = angleFormConv(angleCalc,mirror,flip);
	}
}

// Dragging
if canPlace {
	if placed {
		image_index = 3;
	} else {
		image_index = 1;
	}
	
	if mouse_y < obj_panel_bot.y || placed {
		// Update position
		angleExport = angleFormConv(angleCalc,mirror,flip);
		
		xTo = originX[j-1] + run*radius*mirror;
		yTo = originY[j-1] - rise*radius*flip;
		calcAngleVals = true
		
		// Pass values out
		with trg {
			angle = other.angle;
			trg.dirIsoDef = other.angleExport;
		}
		if instance_exists(obj_actor_button_rotate) {
			obj_actor_button_rotate.angle = self.angle;
		}
	}
} else {
	if mouseHover {
		image_index = 2;
	} else {
		image_index = 0;
	}
}

x = xTo;
y = yTo;
gone = true;

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			if trg = -1 {
				obj_panel_bot.angleRot[timeIndex] = self.angleCalc;
				obj_panel_bot.angleRotExport[timeIndex] = self.angleExport;
			} else {
				with trg {
					trg.dirIsoDef = other.angleExport;
				}
			}
			
			if instance_exists(obj_trigger_region_parent) {
				obj_trigger_region_parent.alarm[2] = 2;
				
				with obj_cutscene_actor_dummy_lucy {
					instance_destroy();
				}
			}
			
			instance_destroy();
		} else {
			canDrag = true;
			canPlace = false;
			
			alarm[0] = 18;
		}
	} else {
		// The first mouse button release does not count
		canRelease = true;
	}
}

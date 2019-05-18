/// @description Insert description here
relativeMouseX = floor((mouse_x + 195 - 23) / 10) * 5 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
relativeMouseY = floor((mouse_y + 576) / 10) * 5 - 320 + 41 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20;

if mouse_check_button_pressed(mb_left) {
	if mouse_y < obj_panel_bot.y {
		if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 {
			if (relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20) {
				if canDrag {
					canDel = true;
					canPlace = true;
				} else {
					image_index = 1;
				}
			}
		}
		
		alarm[1] = 20;
	}
}

tempActionTime = 0;
j = 1;
originX[timeIndex] = originX[0];
originY[timeIndex] = originY[0];

// originX[0] and originY[0] are transmitted from obj_panel_bot

while tempActionTime < obj_panel_bot.longestRowLength {
	for (i = 1; i <= obj_panel_bot.totalActions; i += 1) {
		if obj_panel_bot.actionRowInd[i] = rowIndex {
			if obj_panel_bot.actionTime[i] = tempActionTime {
				if obj_panel_bot.actionInd[i] = 0 {
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

angle = point_direction(originX[j-1],originY[j-1],relativeMouseX,relativeMouseY);
angleCalc = round(angle/22.5)*22.5;

if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		if angleCalc >= 0 && angleCalc <= 90 {
			mirror = 1;
			flip = 1;
		}
		if angleCalc > 90 && angleCalc <= 180 {
			mirror = -1;
			flip = 1;
		}
		if angleCalc > 180 && angleCalc <= 270 {
			mirror = -1;
			flip = -1;
		}
		if angleCalc > 270 && angleCalc < 360 {
			mirror = 1;
			flip = -1;
		}
		
		if abs(angle % 90) = 0 {
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
		
		angleExport = angleFormConv(angleCalc,mirror,flip);
	}
} else {
	image_index = 0;
}

x = originX[j-1] + run*radius*mirror;
y = originY[j-1] - rise*radius*flip;
gone = true;

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			if trg = -1 {
				obj_panel_bot.angleRot[timeIndex] = self.angleCalc;
				obj_panel_bot.angleRotExport[timeIndex] = self.angleExport;
				obj_panel_bot.runRot[timeIndex] = self.run;
				obj_panel_bot.riseRot[timeIndex] = self.rise;
				obj_panel_bot.mirrorRot[timeIndex] = self.mirror;
				obj_panel_bot.flipRot[timeIndex] = self.flip;
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

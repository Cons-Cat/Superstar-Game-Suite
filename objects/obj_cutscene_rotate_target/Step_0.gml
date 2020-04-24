/// @description Insert description here
tempActionTime = 0;
j = 1;
originX[timeIndex] = originX[0];
originY[timeIndex] = originY[0];

// originX[0] and originY[0] are passed in externally

while tempActionTime < obj_panel_bot.longestRowLength {
	for (i = 1; i <= obj_panel_bot.totalActions; i += 1) {
		if obj_panel_bot.actionRowInd[i] = rowIndex {
			if obj_panel_bot.actionTime[i] = tempActionTime {
				// Walk action.
				if obj_panel_bot.actionInd[i] = 0 {
					originX[j] = obj_panel_bot.xNode[i];
					originY[j] = obj_panel_bot.yNode[i] - zfloor*20;
					
					j++;
					
					break;
				}
				
				// Rotation action.
				if obj_panel_bot.actionInd[i] = 1 {
					originX[j] = originX[j-1];
					originY[j] = originY[j-1];
					
					j++;
					if i = timeIndex {
						tempActionTime = obj_panel_bot.longestRowLength + 1;
					}
				}
			}
		}
	}
	
	tempActionTime++;
}

originXNet = originX[j-1];
originYNet = originY[j-1];

event_inherited();

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			obj_panel_bot.angleRot[timeIndex] = self.angleCalc;
			obj_panel_bot.angleRotExport[timeIndex] = self.angleExport;
			
			with obj_trigger_region_parent {
				if select {
					obj_trigger_region_parent.alarm[2] = 2;
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

/// @description Insert description here

// Point angle at mouse
if gone {
	angle = point_direction(originXNet,originYNet,relativeMouseX,relativeMouseY - mouseYOff);
}

// Update angle for calculation
if calcAngleVals {
	#region
	
	calcAngleVals = false;
	
	if angle <= (angle div 22.5)*22.5 + 15 && angle > (angle div 22.5)*22.5 - 15 {
		angleCalc = (angle div 22.5)*22.5;
	}
	
	// Keep >= 0 and < 360
	while angleCalc >= 360 {
		angleCalc -= 360;
	}
	while angleCalc < 0 {
		angleCalc += 360;
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
	if angleCalc >= 270 && angleCalc < 360 {
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
		
		xTo = originXNet + run*radius*mirror;
		yTo = originYNet - rise*radius*flip;
		angleExport = angleFormConv(angleCalc,mirror,flip);
	}
	
	#endregion
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
		
		xTo = originXNet + run*radius*mirror;
		yTo = originYNet - rise*radius*flip;
		calcAngleVals = true
		
		// Pass values out
		with trg {
			angle = other.angle;
			trg.dirIsoDefault = other.angleExport;
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

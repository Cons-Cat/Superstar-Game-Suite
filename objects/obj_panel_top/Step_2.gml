/// @description Insert description here
x = room_width + view_wport[1] / 2;
baseY = 60/576 * view_hport[1] - 1;
relativeMouseX = window_mouse_get_x();
relativeX = x - room_width;

if relativeMouseX <= relativeX + 60 && relativeMouseX >= relativeX - 60 {
	if mouse_y >= y && mouse_y <= y + 21 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = true;
			mouseClickOff = mouse_y - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if select {
	if !mouse_check_button(mb_left) {
		select = false;
		
		moveToY = round((mouse_y - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToY < baseY - 20 {
			moveToY = 0;
		}
		if moveToY >= baseY - 20 {
			moveToY = baseY;
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToY - y) / 2;
		
		image_index = 0;
	}
} else {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if y != baseY {
			moveToY = baseY;
		} else {
			moveToY = 0;
		}
		
		moveToSpd = abs(y - baseY) / 7;
		
		// Minimum speed
		if moveToSpd < 13 {
			moveToSpd = 13;
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
	}
	
	if y != moveToY {
		if abs(moveToY - y) < moveToSpd * 1.8 {
			if moveToSpd > moveToSpdMin {
				moveToSpd /= moveToDeccel;
			} else {
				moveToSpd = moveToSpdMin;
			}
		}
		
		if moveDirection = -1 {
			if y > moveToY + moveToSpd {
				y -= moveToSpd;
			} else {
				y = moveToY;
				moveToSpd = 0;
			}
		} else {
			if y < moveToY - moveToSpd  {
				y += moveToSpd;
			} else {
				y = moveToY;
				moveToSpd = 0;
			}
		}
	}
}

if select {
	dragY = mouse_y - mouseClickOff - 0;
	dragYTemp = dragY;
	
	y = dragY;
}

// On base
if floor(y) = floor(baseY) {
	onBase = 1;
} else {
	onBase = 0;
}

if y = 0 {
	onBase = 2;
}

// Boundaries
if y < 0 {
	y = 0;
}
if y > baseY {
	y = baseY;
}

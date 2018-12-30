/// @description Insert description here
baseY = 420;
x = 512;

if mouse_x <= x + 60 && mouse_x >= x - 60 {
	if mouse_y >= y - 21 && mouse_y <= y {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = mouse_y - y;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

if !mouse_check_button(mb_left) {
	if select = 1 {
		select = 0;
		
		moveToY = round((mouse_y - mouseClickOff + 1) / 10) * 10 + 1;
		if moveToY > 400 && moveToY < 480 {
			moveToY = 420;
		}
		if moveToY >= 480 {
			moveToY = 576;
		}
		
		if y > moveToY {
			moveDirection = -1;
		} else {
			moveDirection = 1;
		}
		
		moveToSpd = abs(moveToY - y) / 2;
		
		image_index = 0;
	}
}

if !select {
	// Double clicking
	alarm[0] = 12;
	
	if doubleClickCounter >= 2 {
		doubleClickCounter = 0;
		
		if y != baseY {
			moveToY = baseY;
		} else {
			moveToY = 576;
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
	dragY = mouse_y - mouseClickOff;
	dragYTemp = dragY;
	
	y = dragY;
}

// Boundaries
if y < 300 {
	y = 300;
}
if y > 576 {
	y = 576;
}

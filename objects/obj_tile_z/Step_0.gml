/// @description Arrow buttons

// Click arrow buttons
if mouse_x >= self.x + 71 && mouse_x <= self.x + 95 {
	// Top arrow
	if mouse_y >= 1 && mouse_y <= 23 {
		if mouse_check_button_pressed(mb_left) {
			z += 1;
			buttonIndex[0] = 1;
			
			alarm[0] = 14;
		}
		if clicked = 1 {
			z += 0.35;
		}
	}
	
	// Bottom arrow
	if mouse_y >= 44 && mouse_y <= self.y + 45 {
		if mouse_check_button_pressed(mb_left) {
			if z > -1 {
				z -= 1;
			}
			buttonIndex[1] = 1;
			
			alarm[0] = 14;
		}
		if clicked = 1 {
			if z > -1 {
				z -= 0.35;
			}
		}
		
		// Prevent z from going beyond -1
		if z < 0 {
			z = -1;
		}
	}
}

// Release arrow buttons
if clicked = 0 {
	z = floor(z);
}
if mouse_check_button_released(mb_left) {
	clicked = 0;
	buttonIndex[0] = 0;
	buttonIndex[1] = 0;
}

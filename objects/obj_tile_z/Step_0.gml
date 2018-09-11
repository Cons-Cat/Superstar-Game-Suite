/// @description Arrow buttons

// Click arrow buttons
if mouse_x >= self.x + 15 && mouse_x <= self.x + 25 {
	// Top arrow
	if mouse_y >= self.y - 9 && mouse_y <= self.y {
		if mouse_check_button_pressed(mb_left) {
			z += 1;
			col1 = c_orange;
			alarm[0] = 8;
		}
		if clicked = 1 {
			z += 0.35;
		}
	}
	// Bottom arrow
	if mouse_y >= self.y + 22 && mouse_y <= self.y + 29 {
		if mouse_check_button_pressed(mb_left) {
			if z > -1 {
				z -= 1;
			}
			col2 = c_orange;
			alarm[0] = 8;
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
	col1 = c_white;
	col2 = c_white;
}

/// @description Activate special

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	alarm[0] = 2;
}

if select = 1 {
	if mouse_x > self.x && mouse_x < self.x + sprite_width && mouse_y > self.y && mouse_y < self.y+sprite_height {
		if mouse_check_button_released(mb_left) {
			with trg {
				finite = !finite;
			}
			select = 0;
			col = c_white;
			
			image_index += 1;
		}
	} else {
		select = 0;
		col = c_white;
	}
}

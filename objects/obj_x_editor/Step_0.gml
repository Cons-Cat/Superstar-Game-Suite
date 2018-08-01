/// @description Delete terrain

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	alarm[0] = 2;
}

if mouse_x > self.x && mouse_x < self.x + sprite_width && mouse_y > self.y && mouse_y < self.y+sprite_height {
	if canDelete {
		if mouse_check_button_released(mb_left) {
			with trg {
				instance_destroy();
			}
		}
	} else {
		if mouse_check_button_pressed(mb_left) {
			canDelete = true;
		}
	}
} else {
	select = 0;
	col = c_white;
	
	if mouse_check_button_released(mb_left) {
		canDelete = false;
	}
}

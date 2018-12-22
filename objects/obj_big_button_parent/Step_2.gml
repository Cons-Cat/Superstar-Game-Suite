/// @description Insert description here
if mouse_x >= x && mouse_x <= x + sprWidth {
	if mouse_y >= y && mouse_y <= y + sprHeight {
		if mouse_check_button_pressed(mb_left) {
			if !select {
				imgIndex = 1;
				select = true;
			}
		}
	}
}

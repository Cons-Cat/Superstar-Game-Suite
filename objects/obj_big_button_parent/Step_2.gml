/// @description Insert description here
scale = view_hport[1] / 1152;

if mouse_x >= x - (sprite_get_width(spr_editor_big_button) * scale / 2) && mouse_x <= x + (sprite_get_width(spr_editor_big_button) * scale / 2) {
	if mouse_y >= y - (sprite_get_height(spr_editor_big_button) * scale) && mouse_y <= y {
		if mouse_check_button_pressed(mb_left) {
			if !select {
				imgIndex = 1;
				select = true;
			}
		}
	}
}

if !mouse_check_button(mb_left) {
	imgIndex = 0;
	select = false;
}

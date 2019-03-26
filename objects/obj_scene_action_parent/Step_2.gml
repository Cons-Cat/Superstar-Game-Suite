/// @description Insert description here
if !mouse_check_button(mb_left) {
	if select {
		if mouse_x >= x && mouse_x <= x + sprWidth && mouse_y >= y && mouse_y <= y + sprHeight {
			if obj_editor_gui.selectInstance != -1 {
				obj_panel_bot.addClick = value;
			}
		}
	}
	
	imgIndex = 0;
	select = false;
} else {
	if mouse_x >= x && mouse_x <= x + sprWidth && mouse_y >= y && mouse_y <= y + sprHeight {
		if mouse_check_button_pressed(mb_left) {
			select = true;
		}
		if select {
			imgIndex = 1;
		}
	} else {
		imgIndex = 0;
	}
}

if (mouse_x >= x && mouse_x <= x + sprWidth && mouse_y >= y && mouse_y <= y + sprHeight) {
	canSelect = true;
} else {
	canSelect = false;
}

y = obj_panel_bot.y + 6;

/// @description Insert description here
if (mouse_x <= scrollHorRightBound && mouse_x >= scrollHorLeftBound) || (mouse_x >= scrollHorLeftBound && mouse_x <= scrollHorRightBound) {
	if mouse_y >= y - 60 && mouse_y <= y + 60 {
		if mouse_check_button_pressed(mb_left) {
			// Dragging
			select = 1;
			mouseClickOff = mouse_x - x;
			
			// Double clicking
			doubleClickCounter += 1;
			
			image_index = 1;
		}
	}
}

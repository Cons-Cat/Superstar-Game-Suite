/// @description Activate special
if select {
	if mouseCheckX >= self.x + 3 && mouseCheckX <= self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY <= self.y + 3 + sprite_height {
		if mouse_check_button_released(mb_left) {
			with trg {
				finite = !finite;
			}
			select = false;
			
			image_index += 1;
		}
	}
}

event_inherited();

// Selecting
if mouseCheckX >= self.x + 3 && mouseCheckX <= self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY <= self.y + 3 + sprite_height {
	if mouse_check_button_pressed(mb_left) {
		select = true;
	}
}

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	alarm[0] = 2;
}

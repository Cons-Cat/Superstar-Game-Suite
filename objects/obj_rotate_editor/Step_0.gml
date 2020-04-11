/// @description Activate special
if select = 1 {
	if mouseCheckX >= self.x + 3 && mouseCheckX < self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY < self.y+sprite_height + 3 {
		if mouse_check_button_released(mb_left) {
			with trg {
				angleVal += 1;
				
				if angleVal > 4 {
					angleVal = 0;
				}
			}
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

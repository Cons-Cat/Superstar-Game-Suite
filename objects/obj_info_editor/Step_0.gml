/// @description Activate special
if select {
	if mouseCheckX >= self.x + 3 && mouseCheckX < self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY < self.y+sprite_height + 3 {
		if mouse_check_button_released(mb_left) {
			with trg {
				if str = "door" {
					roomStr = get_string("What is the room name?",string(roomStr));
				}
				if str = "slope1" || str = "slope2" || str = "slope3" {
					if other.str2 = "mirror" {
						mirror = !mirror;
					}
					if other.str2 = "flip" {
						flip = !flip;
						
						if flip {
							depthOffset = 3;
						} else {
							depthOffset = 0;
						}
					}
					
					resetArray = true;
					other.select = 0;
					other.col = c_white;
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

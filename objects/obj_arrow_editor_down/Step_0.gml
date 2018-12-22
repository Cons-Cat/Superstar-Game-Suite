/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x - sprite_width/2 && mouseCheckX <= self.x + sprite_width/2 && mouseCheckY >= self.y && mouseCheckY <= self.y + sprite_height {
	if mouse_check_button_pressed(mb_left) {
		select = true;
	}
}

if instance_exists(trg) {
	x = trg.x + trg.width*10; // Halfway down the width

	if select {
		if mouseCheckY - 4 <= trg.y + 20 {
			self.y = trg.y + 20;
			trg.height = 1;
		} else {
			y = floor(mouseCheckY/20)*20 - 4;
		
			if self.y > trg.y + trg.height*20 {
				trg.height += 1;
			}
			if self.y < trg.y + trg.height*20 {
				trg.height -= 1;
			}
		}
		
		trg.resetArray = true;
	}
}

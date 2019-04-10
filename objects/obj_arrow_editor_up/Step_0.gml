/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x - sprite_height/2 && mouseCheckX <= self.x + sprite_height/2 && mouseCheckY >= self.y - sprite_width && mouseCheckY <= self.y {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
		}
	}
}

if instance_exists(trg) {
	x = trg.x + trg.width*10; // Halfway down the width

	if select {
		if mouseCheckY < trg.y + trg.height*20 - 20 {
			y = floor(mouseCheckY/20)*20 + 20 - 4;
		
			if self.y < trg.y {
				tempHeight = trg.y + trg.height*20;
				trg.y = self.y;
				trg.height = (tempHeight - trg.y)/20;
			}
			if self.y > trg.y {
				tempHeight = trg.y + trg.height*20;
				trg.y = self.y;
				trg.height = (tempHeight - trg.y)/20;
			}
			trg.resetArray = true;
		}
	}
}

/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x - sprite_width/2 && mouseCheckX <= self.x + sprite_width/2 && mouseCheckY >= self.y - sprite_height + 4 && mouseCheckY <= self.y + 4 {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
		}
	}
}

if instance_exists(trg) {
	if select {
		if selectYOff = 0 {
			selectYOff = mouseCheckY - y;
		}
		
		y = floor((mouseCheckY - selectYOff)/20)*20 + 6;
		
		if y > trg.y + trg.height*10 && trg.zcieling = 0 {
			y = trg.y + trg.height*10;
		}
		
		if self.y < trg.y {
			trg.zfloor += 1;
			trg.y -= 20;
		}
		if self.y > trg.y + 20 && trg.zcieling > 0 {
			trg.zfloor -= 1;
			trg.y += 20;
		}
	}
}

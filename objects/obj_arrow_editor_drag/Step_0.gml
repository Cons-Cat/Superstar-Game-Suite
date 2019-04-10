/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x && mouseCheckX <= self.x + sprite_width + 2 && mouseCheckY >= self.y && mouseCheckY <= self.y + sprite_height + 2 {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
		}
	}
}

// Dragging terrain
if instance_exists(trg) {
	if select = 1 {
		x = floor(mouseCheckX / 20) * 20;
		y = floor(mouseCheckY / 20) * 20 - 4;
		trg.x = self.x;
		trg.y = self.y;
		trg.lastX = x;
		trg.lastY = y;
	}
}

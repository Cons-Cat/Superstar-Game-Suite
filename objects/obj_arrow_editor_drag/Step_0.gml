/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x && mouseCheckX <= self.x + sprite_width && mouseCheckY >= self.y && mouseCheckY <= self.y + sprite_height {
	if mouse_check_button_pressed(mb_left) {
		select = true;
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

/// @description 
event_inherited();

// Selecting
if mouseCheckX >= bbox_left && mouseCheckX <= bbox_right && mouseCheckY >= bbox_top && mouseCheckY <= bbox_bottom {
	if visible {
		if mouse_check_button_pressed(mb_left) {
			if canSelect {
				select = true;
			}
		}
	}
}

// Dragging terrain
if instance_exists(trg) {
	if select {
		x = floor(mouseCheckX / 20) * 20;
		y = floor(mouseCheckY / 20) * 20;
		
		trg.x = self.x;
		trg.y = self.y;
		trg.lastX = x;
		trg.lastY = y;
	}
}

/// @description Activate special
if select {
	if visible {
		if mouseCheckX >= self.x + 3 && mouseCheckX <= self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY <= self.y + 3 + sprite_height {
			if mouse_check_button_released(mb_left) {
				obj_editor_gui.canChangeSelect = true;
				
				/*with obj_subpanel_button {
					instance_destroy();
				}*/
			
				with trg {
					instance_destroy();
				}
			}
		}
	}
}

event_inherited();

// Selecting
if mouseCheckX >= self.x + 3 && mouseCheckX <= self.x + 3 + sprite_width && mouseCheckY >= self.y + 3 && mouseCheckY <= self.y + 3 + sprite_height {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
		}
	}
}

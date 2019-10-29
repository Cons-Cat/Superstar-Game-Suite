/// @description Mouse hovering
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 && ((relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20)) {
	mouseHover = true;
	
	if mouse_check_button_pressed(mb_left) {
		if mouse_y < obj_panel_bot.y {
			if canDrag {
				mouseXOff = self.x - relativeMouseX;
				mouseYOff = self.y - relativeMouseY - zfloor*20;
				
				canDel = true;
				canPlace = true;
			}
		}
		
		alarm[1] = 2;
	}
} else {
	mouseHover = false;
}

// Disable obstructing interface
if instance_exists(obj_editor_button_parent) {
	if mouseHover {
		with obj_editor_button_parent {
			if !select {
				canSelect = false;
			}
		}
	}
}

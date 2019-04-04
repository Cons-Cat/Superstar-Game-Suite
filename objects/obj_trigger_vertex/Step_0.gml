///@description Manipulate placement
relativeMouseX = floor((mouse_x + 195 - 23) / 10) * 5 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
relativeMouseY = floor((mouse_y + 576) / 10) * 5 - 320 + 41 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20;

if instance_exists(trg) {
	zfloor = trg.zfloor;
	
	if trg.select {
		canDrag = true;
		visible = true;
		
		// Select
		if mouse_check_button_pressed(mb_left) {
			if mouse_y < obj_panel_bot.y {
				if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 {
					if (relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20) {
						if canDrag {
							canPlace = true;
						}
					}
				}
			}
		}
		
		// De-select
		if (mouse_check_button_released(mb_left)) {
			canDrag = true;
			canPlace = false;
		}
	} else {
		canDrag = false;
		visible = false;
	}
} else {
	instance_destroy();
}

if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = relativeMouseX;
		y = relativeMouseY;
	}
} else {
	image_index = 0;
}

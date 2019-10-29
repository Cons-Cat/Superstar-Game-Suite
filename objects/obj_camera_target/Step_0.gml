///@description Manipulate placement
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if instance_exists(obj_region_button_target) {
	if obj_region_button_target.select {
		if trg.select {
			visible = true;
			canDrag = true;
		}
	}
}

if instance_exists(trg) {
	if canDrag {
		if trg.select {
			if instance_exists(obj_region_button_target) {
				if obj_region_button_target.select {
					visible = true;
					
					// Select
					if mouse_y < obj_panel_bot.y {
						if relativeMouseX >= bbox_left && relativeMouseX <= bbox_right {
							if (relativeMouseY >= bbox_top - (zfloor * 20) && relativeMouseY <= bbox_bottom - (zfloor * 20)) {
								if mouse_check_button_pressed(mb_left) {
									if canDrag { // Can select to drag
										mouseXOff = self.x - relativeMouseX;
										mouseYOff = self.y - relativeMouseY;
								
										canPlace = true; // Can release to place
									}
								}
							}
						}
					}
					
					// De-select
					if mouse_check_button_released(mb_left) {
						canDrag = true;
						canPlace = false;
					}
				} else {
					canDrag = false;
					canPlace = false;
					visible = false;
				}
			}
		} else {
			canDrag = false;
			canPlace = false;
			visible = false;
		}
	}
} else {
	instance_destroy();
}

// Dragging
if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = floor((relativeMouseX + mouseXOff)/5)*5;
		y = floor((relativeMouseY + (zfloor * 20) + mouseYOff)/5)*5 - (zfloor * 20);;
		trg.trgX = self.x;
		trg.trgY = self.y;
	}
} else {
	image_index = 0;
}

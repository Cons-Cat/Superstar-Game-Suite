/// @description Manipulating position
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 && ((relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20)) {
	mouseHover = true;
	
	if mouse_check_button_pressed(mb_left) {
		if mouse_y < obj_panel_bot.y {
			if canDrag {
				mouseXOff = self.x - relativeMouseX;
				mouseYOff = self.y - relativeMouseY;
				
				canDel = true;
				canPlace = true;
			}
		}
		
		alarm[1] = 2;
	}
} else {
	mouseHover = false;
}

if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = floor((relativeMouseX + mouseXOff)/5)*5;
		y = floor((relativeMouseY + (zfloor * 20) + mouseYOff)/5)*5 + 1;
	}
} else {
	if mouseHover {
		image_index = 2;
	} else {
		image_index = 0;
	}
}

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			obj_panel_bot.xNode[timeIndex] = self.x;
			obj_panel_bot.yNode[timeIndex] = self.y;
			obj_trigger_region_parent.alarm[2] = 2;
			
			with obj_cutscene_actor_dummy_lucy {
				instance_destroy();
			}
			
			instance_destroy();
		} else {
			canDrag = true;
			canPlace = false;
			alarm[0] = 18;
		}
	} else {
		// The first mouse button release does not count
		canRelease = true;
	}
}

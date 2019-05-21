/// @description Manipulating position
relativeMouseX = floor((mouse_x + 195 - 23) / 10) * 5 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
relativeMouseY = floor((mouse_y + 576) / 10) * 5 - 320 + 41 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20;

if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 && ((relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 - zfloor*20 && relativeMouseY <= self.y+5 - zfloor*20)) {
	mouseHover = true;
	
	if mouse_check_button_pressed(mb_left) {
		if mouse_y < obj_panel_bot.y {
			if canDrag {
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
		x = relativeMouseX;
		y = relativeMouseY;
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

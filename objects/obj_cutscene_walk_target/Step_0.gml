/// @description Manipulating position
if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = floor((relativeMouseX + mouseXOff)/5)*5;
		y = floor((relativeMouseY + mouseYOff)/5)*5 + zfloor*20;
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
			
			with obj_cutscene_actor_dummy_player {
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

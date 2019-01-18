/// @description Manipulating position
relativeMouseX = floor((mouse_x + 195 - 23) / 10) * 5 - 80 + floor(camera_get_view_x(obj_editor_gui.cameraRealGame)/20)*20;
relativeMouseY = floor((mouse_y + 576) / 10) * 5 - 320 + 41 + floor(camera_get_view_y(obj_editor_gui.cameraRealGame)/20)*20;

if mouse_y < obj_panel_bot.y {
	if canDrag {
		if canPlace {
			if mouse_check_button(mb_left) {
				x = relativeMouseX;
				y = relativeMouseY;
			}
		}
	} else {
		x = relativeMouseX;
		y = relativeMouseY;
	}
}

if (mouse_check_button_pressed(mb_left) && !canDrag) || (mouse_check_button_released(mb_left) && canDrag && canPlace) {
	if mouse_y <= obj_panel_bot.y {
		obj_panel_bot.xNode[timeIndex] = self.x;
		obj_panel_bot.yNode[timeIndex] = self.y;
		obj_trigger_dialogue_region_editor.alarm[2] = 2;
		
		with obj_cutscene_actor_dummy_lucy {
			instance_destroy();
		}
		
		instance_destroy();
	}
}

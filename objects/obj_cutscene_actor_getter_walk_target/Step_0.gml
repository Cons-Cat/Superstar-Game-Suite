/// @description Manipulating position
if canDrag {
	if canPlace {
		if mouse_check_button(mb_left) {
			x = mouse_x;
			y = mouse_y;
		}
	}
} else {
	x = mouse_x;
	y = mouse_y;
}
depth = -room - 230;

if (mouse_check_button_pressed(mb_left) && !canDrag) || (mouse_check_button_released(mb_left) && canDrag && canPlace) {
	obj_dialogue_region_interface.xNode[i] = self.x;
	obj_dialogue_region_interface.yNode[i] = self.y + obj_dialogue_region_interface.zfloor*20;
	obj_dialogue_region_interface.menuAlpha = 1;
	
	with obj_cutscene_actor_dummy_lucy {
		instance_destroy();
	}
	instance_destroy();
}

if mouse_check_button_released(mb_left) {
	canPlace = true;
}

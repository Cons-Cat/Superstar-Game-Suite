/// @description 
x = mouse_x;
y = mouse_y;
depth = -room_height - 230; // Draw on top of cutscene interface

if mouse_check_button_pressed(mb_left) {
	if canClick {
		if collision_point(mouse_x,mouse_y,obj_actor_parent,false,false) {
			if collision_point(mouse_x,mouse_y,obj_actor_parent,false,false).object_index = obj_cutscene_actor_dummy_lucy.object_index {
				obj_dialogue_region_interface.actor[i] = 0;
			} else {
				obj_dialogue_region_interface.actor[i] = collision_point(mouse_x,mouse_y,obj_actor_parent,false,false).id;
			}
			activated = true;
		}
	}
}

if mouse_check_button_pressed(mb_right) {
	obj_dialogue_region_interface.menuAlpha = 1;
	instance_destroy();
}

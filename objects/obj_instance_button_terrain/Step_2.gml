/// @description Insert description here
event_inherited();

if placing {
	if mouse_check_button_pressed(mb_left) {
		instance_create_layer(floor(mouse_x / 20) * 40, floor(mouse_y / 20) * 40 + 566, "Instances",objIndex);
		
		placing = false;
	}
}

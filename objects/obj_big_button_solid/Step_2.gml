/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_terrain) {
		sortIndex = 0;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope1) {
		sortIndex = 1;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope2) {
		sortIndex = 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope3) {
		sortIndex = 3;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_staircase) {
		sortIndex = 4;
	}
	
	spawnButtons = false;
}

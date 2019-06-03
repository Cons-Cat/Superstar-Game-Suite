/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_actor) {
		sortIndex = 0;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_scene) {
		sortIndex = 1;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_pan) {
		sortIndex = 2;
		viewOn = 3
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_anchor) {
		sortIndex = 3;
		viewOn = 3
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	event_user(0);
	
	spawnButtons = false;
}

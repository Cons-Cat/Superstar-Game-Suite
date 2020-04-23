/// scr_spawn_actions();

with instance_create_layer(x,y,"Instances",obj_scene_button_walk) {
	sortIndex = 0;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}
with instance_create_layer(x,y,"Instances",obj_scene_button_rotate) {
	sortIndex = 1;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}
with instance_create_layer(x,y,"Instances",obj_scene_button_dialogue) {
	sortIndex = 2;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}
with instance_create_layer(x,y,"Instances",obj_scene_button_camera) {
	sortIndex = 3;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}
with instance_create_layer(x,y,"Instances",obj_scene_button_speed) {
	sortIndex = 4;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}
with instance_create_layer(x,y,"Instances",obj_scene_button_arbitrary) {
	sortIndex = 5;
	viewOn = 5;
	panelId = obj_subpanel_left.id;
	sprWidth = (string_width(label) + 5) * 2;
}

scr_panel_calc(obj_subpanel_left.id);

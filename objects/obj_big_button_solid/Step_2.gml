/// @description Insert description here
event_inherited();

x = obj_panel_left.baseX + 10;

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_terrain) {
		sortIndex = 0;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope1) {
		sortIndex = 1;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope2) {
		sortIndex = 2;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_slope3) {
		sortIndex = 3;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_staircase) {
		sortIndex = 4;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_staircase) {
		sortIndex = 5;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_instance_button_staircase) {
		sortIndex = 6;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	
	spawnButtons = false;
	obj_panel_left.scrollPanelHorDefined = false;
	obj_panel_left.scrollPanelVerDefined = false;
	obj_panel_right.scrollPanelHorDefined = false;
	obj_panel_right.scrollPanelVerDefined = false;
}

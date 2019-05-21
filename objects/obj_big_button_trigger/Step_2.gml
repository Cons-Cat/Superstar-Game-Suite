/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_actor) {
		sortIndex = 0;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_scene) {
		sortIndex = 1;
		viewOn = 3;
		panelId = obj_panel_right.id;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_pan) {
		sortIndex = 2;
		viewOn = 3
		panelId = obj_panel_right.id;
	}
	
	obj_panel_right.panelHeight = 291;
	
	spawnButtons = false;
	obj_panel_left.scrollPanelHorDefined = false;
	obj_panel_left.scrollPanelVerDefined = false;
	obj_panel_right.scrollPanelHorDefined = false;
	obj_panel_right.scrollPanelVerDefined = false;
}

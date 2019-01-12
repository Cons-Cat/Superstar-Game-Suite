/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_dialogue) {
		sortIndex = 0;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_scene) {
		sortIndex = 1;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_cutscene) {
		sortIndex = 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_actor) {
		sortIndex = 3;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_trigger_button_door) {
		sortIndex = 4;
	}
	
	obj_panel_right.panelHeight = 291;
	
	spawnButtons = false;
	obj_panel_left.scrollPanelHorDefined = false;
	obj_panel_left.scrollPanelVerDefined = false;
	obj_panel_right.scrollPanelHorDefined = false;
	obj_panel_right.scrollPanelVerDefined = false;
}

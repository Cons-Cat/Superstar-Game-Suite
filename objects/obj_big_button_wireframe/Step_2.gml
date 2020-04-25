/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Square";
		sprite_index = spr_editor_instance_terrain;
		objIndex = obj_editor_terrain;
		
		sortIndex = 0;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Slope 1";
		sprite_index = spr_editor_instance_slope1;
		objIndex = obj_editor_slope1;
		
		sortIndex = 1;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Slope 2";
		sprite_index = spr_editor_instance_slope2;
		objIndex = obj_editor_slope2;
		
		sortIndex = 2;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Slope 3";
		sprite_index = spr_editor_instance_slope3;
		objIndex = obj_editor_slope3;

		sortIndex = 3;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Staircase";
		sprite_index = spr_editor_instance_staircase;
		objIndex = obj_editor_staircase;
		
		sortIndex = 4;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	scr_panel_calc(obj_panel_right.id);
	
	spawnButtons = false;
}

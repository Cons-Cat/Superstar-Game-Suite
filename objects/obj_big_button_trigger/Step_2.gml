/// @description Insert description here
event_inherited();

if spawnButtons {
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Actor";
		sprite_index = spr_editor_trigger_actor;
		objIndex = obj_npc_editor;
		
		sortIndex = 0;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Region";
		sprite_index = spr_editor_trigger_scene;
		objIndex = obj_trigger_cutscene_region_editor;
		
		sortIndex = 1;
		viewOn = 3;
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Cam. Pan";
		sprite_index = spr_scene_camera;
		objIndex = obj_trigger_pan_region_editor;
		
		sortIndex = 2;
		viewOn = 3
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	with instance_create_layer(obj_panel_right.x,78,"Instances",obj_panel_button_place) {
		label = "Cam. Anchor";
		sprite_index = spr_scene_camera;
		objIndex = obj_trigger_anchor_region_editor;
		
		sortIndex = 3;
		viewOn = 3
		panelId = obj_panel_right.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	scr_panel_calc(obj_panel_right.id);
	
	spawnButtons = false;
}

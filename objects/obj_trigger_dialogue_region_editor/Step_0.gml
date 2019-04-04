/// @description Manipulating dimensions
event_inherited();

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_vertex) {
		sortIndex = 0;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_edge) {
		sortIndex = 1;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
}

zcieling = zfloor;

if select {
	if !trgGone {
		// Import metadata
		importCutscene(obj_panel_bot,self.id);
		
		if !instance_exists(obj_cutscene_actor_dummy_lucy) {
			// Generate stand-in for Minerva
			with instance_create_layer(x+10,y+10,"Instances",obj_cutscene_actor_dummy_lucy) {
				trg = other.id;
				zfloor = other.zfloor;
			}
		}
		
		trgGone = true;
	}
} else {
	trgGone = false;
}

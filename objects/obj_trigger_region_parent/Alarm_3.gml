/// @description Generate cutscene interface.
if !instance_exists(obj_cutscene_actor_dummy_player) {
	// Generate stand-in for Minerva
	with instance_create_layer(x+30,y+10,"Instances",obj_cutscene_actor_dummy_player) {
		trg = other.id;
		zfloor = other.zfloor;
	}
}

// Delete current actions.	
with obj_panel_button {
	if viewOn = 5 {
		instance_destroy();
	}
}

scr_import_cutscene(obj_panel_bot, self.id, eventIndex);
scr_spawn_actions();

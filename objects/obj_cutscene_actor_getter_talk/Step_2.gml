/// @description 
event_inherited();

if activated {
	str = get_string("Dialogue Input:",str);
	obj_dialogue_region_interface.str[i] = self.str;
	obj_dialogue_region_interface.menuAlpha = 1;
	
	// Destroy the Lucy dummy
	with obj_cutscene_actor_dummy_lucy {
		instance_destroy();
	}
	instance_destroy();
}

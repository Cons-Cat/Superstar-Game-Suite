/// @description 
event_inherited();

if select {
	select = false;
	
	trg.eventsCount++;
	eventsCount = trg.eventsCount;
	
	with instance_create_layer(x,y,"Instances",obj_actor_button_scene) {
		sprite_index = spr_editor_trigger_scene;
		
		with other {
			other.label = "Event " + string(trg.eventsCount);
			other.eventIndex = trg.eventsCount - 1;
			other.sortIndex = self.sortIndex + trg.eventsCount;
			other.trg = trg;
			trg.totalActions[other.eventIndex] = 0;
		}
		
		viewOn = 2;
		panelId = obj_panel_left.id;
		sprWidth = (string_width(label) + 5) * 2;
	}
	
	scr_panel_calc(obj_panel_left.id);
}

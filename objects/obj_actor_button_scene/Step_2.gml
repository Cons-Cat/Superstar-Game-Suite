/// @description 
event_inherited();

if select {
	select = false;
	
	trg.eventIndex = self.eventIndex;
	trg.spawnActions = true;
	
	with obj_panel_bot {
		event_user(0); // Export previously stored data.
		
		cutsceneInstanceId = other.trg;
		eventIndex = other.eventIndex;
	}
	
	scr_import_cutscene(obj_panel_bot, trg, eventIndex);
}

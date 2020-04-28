/// @description 
event_inherited();

if select {
	select = false;
	
	trg.eventIndex = self.eventIndex;
	trg.spawnActions = true;
	obj_panel_bot.cutsceneInstanceId = trg;
}

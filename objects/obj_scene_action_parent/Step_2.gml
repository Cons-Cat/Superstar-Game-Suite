/// @description Add cutscene action
if select {
	if obj_panel_bot.hasRowSelected {
		obj_panel_bot.addClick = value;
	}
	
	select = false;
}

event_inherited();

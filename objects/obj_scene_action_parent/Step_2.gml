/// @description Add cutscene action
if select {
	if obj_panel_bot.hasRowSelected {
		/* Wait for existing interfaces to destruct and pass
		data before creating a new one */
		if instance_exists(obj_cutscene_target_parent) {
			obj_cutscene_target_parent.canDel = true;
		} else {
			obj_panel_bot.addClick = value;
			select = false;
		}
	} else {
		select = false;
	}
}

event_inherited();

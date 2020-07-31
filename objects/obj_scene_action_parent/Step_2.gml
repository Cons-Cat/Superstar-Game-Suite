/// @description Add cutscene action
event_inherited();

if select {
	if obj_panel_bot.hasRowSelected {
		/* Wait for existing interfaces to destruct and pass
		data before creating a new one */
		if instance_exists(obj_trigger_widget_scene_parent) {
			obj_trigger_widget_scene_parent.canDel = true;
		} else {
			obj_panel_bot.addClick = value;
			
			select = false;
		}
	} else {
		select = false;
	}
}

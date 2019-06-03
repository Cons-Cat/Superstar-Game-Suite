/// @description Calculate longest button width
for (i = 0; i < instance_number(obj_panel_button); i += 1) {
	if instance_find(obj_panel_button,i).panelId = obj_panel_right.id {
		if instance_find(obj_panel_button,i).sprWidth + 49 >= obj_panel_right.longestSprWidth {
			obj_panel_right.longestSprWidth = instance_find(obj_panel_button,i).sprWidth + 49;
		}
	}
}
	
with obj_panel_button {
	if panelId = obj_panel_right.id {
		longestSprWidth = obj_panel_right.longestSprWidth;
	}
}

obj_subpanel_left.longestPanelRightButton = obj_panel_right.longestSprWidth;
obj_panel_bot.longestPanelRightButton = obj_panel_right.longestSprWidth;

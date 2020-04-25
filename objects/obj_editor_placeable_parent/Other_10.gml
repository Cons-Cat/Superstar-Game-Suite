/// @description Calculate sub-panel button width
for (i = 0; i < instance_number(obj_panel_button); i += 1) {
	if instance_find(obj_panel_button,i).panelId = obj_subpanel_left.id {
		if instance_find(obj_panel_button,i).sprWidth + 49 >= obj_subpanel_left.longestSprWidth {
			obj_subpanel_left.longestSprWidth = instance_find(obj_panel_button,i).sprWidth + 49;
		}
	}
}

with obj_panel_button {
	if trg = other.id {
		longestSprWidth = obj_subpanel_left.longestSprWidth;
	}
}

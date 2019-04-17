/// @description Calculate longest button width
if longestSprWidth = -1 {
	for (i = 0; i < instance_number(obj_panel_button); i += 1) {
		if instance_find(obj_panel_button,i).panelId = self.panelId {
			if instance_find(obj_panel_button,i).sprWidth + 49 > self.longestSprWidth {
				longestSprWidth = instance_find(obj_panel_button,i).sprWidth + 49;
			}
		}
	}
}

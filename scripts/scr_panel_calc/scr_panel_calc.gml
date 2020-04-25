/// @description 
var argPanelId = argument[0];
var longestSprWidth = 0;

// Calculate panel button width
for (i = 0; i < instance_number(obj_panel_button); i += 1) {
	if instance_find(obj_panel_button,i).panelId = argPanelId {
		if instance_find(obj_panel_button,i).sprWidth + 49 >= longestSprWidth {
			longestSprWidth = instance_find(obj_panel_button,i).sprWidth + 49;
		}
	}
}

with obj_panel_button {
	if panelId = argPanelId {
		longestSprWidth = longestSprWidth;
	}
}

argPanelId.panelWidth = longestSprWidth;

/// @description 
var argPanelId = argument[0];
var longestSprWidth = 0;
var tempHeight = 3;
var buttonsCount = 0;
var trg;

// Calculate panel button width
for (i = 0; i < instance_number(obj_panel_button); i += 1) {
	trg = instance_find(obj_panel_button, i);
	if trg.panelId = argPanelId {
		// Width
		if trg.sprWidth + 49 >= longestSprWidth {
			longestSprWidth = instance_find(obj_panel_button,i).sprWidth + 49;
		}
		
		// Height
		tempHeight += 45;
		buttonsCount++;
	}
}

// Width
with obj_panel_button {
	if panelId = argPanelId {
		longestSprWidth = longestSprWidth;
	}
}

argPanelId.panelWidth = longestSprWidth;

// Height
if buttonsCount > 0 {
	argPanelId.panelHeight = tempHeight - 4;
} else {
	argPanelId.panelHeight = 0;
}

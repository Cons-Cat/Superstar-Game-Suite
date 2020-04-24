/// @description De-select terrain
if trg.buttonSelected = 0 {
	if trg.canDeSelect {
		if !obj_panel_left.select && !obj_panel_right.select && !obj_panel_top.select && !obj_panel_bot.select {
			trg.canSelect = false;
			trg.canMerge = true; // Re-check merging when dimensions are change
			obj_editor_gui.canChangeSelect = true;
			obj_subpanel_left.panelHeight = 0;
			
			with obj_panel_button {
				if panelId = obj_subpanel_left.id || panelId = obj_panel_left.id {
					instance_destroy();
				}
			}
			
			instance_destroy();
		}
	}
}

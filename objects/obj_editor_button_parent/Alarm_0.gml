/// @description De-select terrain
if !trg.buttonSelected {
	if trg.canDeSelect {
		if !obj_panel_left.select && !obj_panel_right.select && !obj_panel_top.select && !obj_panel_bot.select {
			trg.select = false;
			trg.canMerge = true; // Re-check merging when dimensions are changed.
			obj_editor_gui.canChangeSelect = true;
			obj_subpanel_left.panelHeight = 0;
			
			with obj_panel_button {
				if trg = self.trg {
					instance_destroy();
				}
			}
			
			instance_destroy();
		}
	}
}

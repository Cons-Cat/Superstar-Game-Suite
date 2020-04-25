/// @description De-select terrain
if !trg.buttonSelected {
	show_debug_message("DE")
	if trg.canDeSelect {
		show_debug_message("SEL")
		if !obj_panel_left.select && !obj_panel_right.select && !obj_panel_top.select && !obj_panel_bot.select {
			trg.select = false;
			trg.canMerge = true; // Re-check merging when dimensions are changed.
			obj_editor_gui.canChangeSelect = true;
			obj_subpanel_left.panelHeight = 0;
			
			with obj_panel_button {
				if trg = other.trg {
					instance_destroy();
				}
			}
			
			instance_destroy();
		}
	}
}

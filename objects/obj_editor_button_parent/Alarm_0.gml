/// @description Deselect terrain
if trg.buttonSelected = 0 {
	if trg.canDeSelect {
		trg.canSelect = false;
		trg.canMerge = true; // Re-check merging when dimensions are change
		obj_editor_gui.canChangeSelect = true;
		
		with obj_panel_button {
			if panelId = obj_subpanel_left.id {
				instance_destroy();
			}
		}
		
		instance_destroy();
	}
}

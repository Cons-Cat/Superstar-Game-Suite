/// @description Deselect terrain
if trg.buttonSelected = 0 {
	if trg.canDeSelect {
		trg.canSelect = false;
		obj_editor_gui.canChangeSelect = true;
		
		with obj_panel_button {
			if panelId = obj_subpanel_left.id {
				instance_destroy();
			}
		}
		
		instance_destroy();
	}
}

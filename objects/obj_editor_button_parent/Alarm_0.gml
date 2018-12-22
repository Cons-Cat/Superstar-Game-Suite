/// @description Deselect terrain
if trg.buttonSelected = 0 {
	trg.canSelect = false;
	obj_editor_gui.canChangeSelect = true;
	
	instance_destroy();
}

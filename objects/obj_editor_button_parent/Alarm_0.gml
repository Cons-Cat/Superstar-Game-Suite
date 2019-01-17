/// @description Deselect terrain
if trg.buttonSelected = 0 {
	if trg.canDeSelect {
		if !obj_scene_walk.canSelect && !obj_scene_rotate.canSelect && !obj_scene_dialogue.canSelect {
			if !(obj_editor_gui.mode = 4 && mouse_y >= obj_panel_bot.y) {
				trg.canSelect = false;
				obj_editor_gui.canChangeSelect = true;
			
				instance_destroy();
			}
		}
	}
}

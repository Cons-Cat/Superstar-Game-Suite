/// @description Deselection
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

if instance_exists(trg) {
	fromTxt = trg.str;
}

// Release mouse to deselect
if !mouse_check_button(mb_left) && instance_exists(trg) {
	select = false;
	trg.buttonSelected = 0;
	col = c_white;
}

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	if !select {
		alarm[0] = 2;
	}
}

if select {
	col = c_orange;
	
	if instance_exists(trg) {
		trg.buttonSelected = 1;
	}
}

visible = true;

if obj_editor_gui.mode = 4 { // Triggers mode
	if instance_exists(obj_cutscene_actor_getter_target_parent) {
		visible = false;
	} else {
		visible = true;
	}
}

/// @description Deselection

// Release mouse to deselect
if !mouse_check_button(mb_left) && instance_exists(trg) {
	select = 0;
	trg.buttonSelected = 0;
	col = c_white;
}

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	alarm[0] = 2;
}

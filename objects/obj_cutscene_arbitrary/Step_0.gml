/// @description Insert description here
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

if mouse_check_button_pressed(mb_left) {
	if mouseCheckX <= x + 12 && mouseCheckX >= x - 12 {
		// Selecting
		if mouseCheckY <= y - 4 && mouseCheckY >= y - 14 {
			select = true;
		}
	}
	
	// Click outside interface
	if (mouseCheckX < self.x - 20 || mouseCheckX > x + 21) || (mouseCheckY < y - 18 || mouseCheckY >= y) {
		if !select {
			// Pass all persistent values to obj_panel_bot
			obj_panel_bot.arbitraryInd[timeIndex] = string_digits(arbitraryInd);
			
			obj_trigger_cutscene_region_editor.alarm[2] = 2;
			
			instance_destroy();
		} else {
			select = false;
		}
	}
}

if select {
	if !selected {
		arbitraryInd = "";
		selected = true;
	}
	
	// Input numbers
	if string_length(arbitraryInd) < 3 || keyboard_check_pressed(vk_backspace) {
		if keyboard_check_pressed(vk_anykey) {
			arbitraryInd = string_digits(typeText(arbitraryInd)); // Custom script which adds integers to a string argument
		}
	}
}

gone = true;

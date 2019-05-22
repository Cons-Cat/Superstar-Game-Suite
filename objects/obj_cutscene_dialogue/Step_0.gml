/// @description Manipulating position
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if textRows != height {
	textRows = height;
}

for (i = 0; i <= textRows; i += 1) {
	// Initialize new rows
	if i >= array_length_1d(str) {
		canSelectTextRow[i] = false;
		selectTextRow[i] = false;
		str[i] = "";
	}
	if mouse_check_button_pressed(mb_left) {
		selectTextRow[i] = false;
	}
	
	if relativeMouseX >= placex + 5 && relativeMouseX <= placex + width*10 + 5 && relativeMouseY >= placey + 10 + i*10 && relativeMouseY < placey + 20 + i*10 {
		canSelectTextRow[i] = true;
		
		if mouse_check_button_pressed(mb_left) {
			selectTextRow[i] = true;
			select[4] = true; // Generic text row selection flag
		}
	} else {
		canSelectTextRow[i] = false;
	}
	
	if selectTextRow[i] {
		select[4] = true;
		
		if keyboard_check_pressed(vk_anykey) && !keyboard_check_pressed(vk_control) && !keyboard_check_pressed(vk_shift) && !keyboard_check_pressed(vk_alt) && !keyboard_check_pressed(vk_enter) {
			str[i] = typeText(str[i]); // Custom script which adds keyboard characters to a string argument
		}
		if keyboard_check_pressed(vk_enter) {
			// New line
			if canInputEnter {
				if i = textRows - 1 {
					height += 1;
					textRows += 1;
				}
				
				selectTextRow[i] = false;
				canSelectTextRow[i + 1] = true;
				selectTextRow[i + 1] = true;
				canInputEnter = false;
				
				alarm[1] = 2;
			}
		}
	}
}

// Select dimension buttons
if mouse_check_button_pressed(mb_left) {
	// Left drag button
	if relativeMouseX >= placex - 6 && relativeMouseX <= placex && relativeMouseY >= placey - 3 && relativeMouseY <= placey + height*10 + 10 {
		select[0] = true;
	}
	// Right drag button
	if relativeMouseX >= placex+width*10+10 && relativeMouseX <= placex+width*10+16 && relativeMouseY >= placey - 3 && relativeMouseY <= placey + height*10 + 10 {
		select[1] = true;
	}
	// Top drag button
	if relativeMouseX >= placex && relativeMouseX <= placex+width*10+10 && relativeMouseY >= placey - 6 && relativeMouseY <= placey {
		select[2] = true;
	}
}

// Select z button
if relativeMouseX >= placex+width*10-5 && relativeMouseX <= placex+width*10+10 && relativeMouseY >= placey+height*10+10 && relativeMouseY <= placey+height*10+25 {
	canSelect[3] = true;
	
	if mouse_check_button_pressed(mb_left) {
		select[3] = true;
	}
} else {
	canSelect[3] = false;
}

// Drag dimensions
if select[0] {
	selectCol[0] = orange;
	
	if relativeMouseX < placex - 6 {
		width += 1;
		placex -= 10;
	}
	if relativeMouseX > placex {
		if placex + 20 < trg.x+10 {
			if width > 1 {
				width -= 1;
				placex += 10;
			}
		}
	}
}
if select[1] {
	selectCol[1] = orange;
	
	if relativeMouseX > placex+width*10+16 {
		width += 1;
	}
	if relativeMouseX < placex+width*10+10 {
		if placex+width*10-10 > trg.x+10 {
			if width > 1 {
				width -= 1;
			}
		}
	}
}
if select[2] {
	selectCol[2] = orange;
	
	if relativeMouseY < placey - 6 {
		height += 1;
		placey -= 10;
	}
	if relativeMouseY > placey {
		if height > 1 {
			height -= 1;
			placey += 10;
		}
	}
}
if select[3] {
	selectCol[3] = orange;
	
	if relativeMouseY < placey+height*10+10 {
		placey -= 5;
	}
	if relativeMouseY > placey+height*10+25 {
		if placey < trg.y - height*10 - 15 {
			placey += 5;
		}
	}
} else {
	selectCol[3] = blue;
}

if mouse_check_button_released(mb_left) {
	// Delete interface
	if !select[0] && !select[1] && !select[2] && !select[3] && !select[4] {
		if relativeMouseX <= placex || relativeMouseX >= placex+width*10+10 || relativeMouseY <= placey || relativeMouseY >= placey+height*10+10 {
			if canClose {
				instance_destroy();
			}
		}
	}
	
	// Release buttons
	select[0] = false;
	selectCol[0] = blue;
	select[1] = false;
	selectCol[1] = blue;
	select[2] = false;
	selectCol[2] = blue;
	select[3] = false;
	selectCol[3] = blue;
	select[4] = false;
}

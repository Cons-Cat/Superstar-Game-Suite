/// @description Insert description here
relativeMouseX = obj_editor_gui.mouseCheckX;
relativeMouseY = obj_editor_gui.mouseCheckY;

if relativeMouseX >= self.x-5 && relativeMouseX <= self.x+5 && ((relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5) || (relativeMouseY >= self.y-4 && relativeMouseY <= self.y+5)) {
	mouseHover = true;
	
	if mouse_check_button_pressed(mb_left) {
		if mouse_y < obj_panel_bot.y {
			if canDrag {
				mouseXOff = self.x - relativeMouseX;
				mouseYOff = self.y - relativeMouseY;
				
				canDel = true;
				canPlace = true;
			}
		}
		
		alarm[1] = 2;
	}
} else {
	mouseHover = false;
}

if canPlace {
	image_index = 1;
	
	if mouse_y < obj_panel_bot.y {
		x = floor((relativeMouseX + mouseXOff)/5)*5;
		y = floor((relativeMouseY + mouseYOff)/5)*5;
	}
} else {
	if mouseHover {
		image_index = 2;
	} else {
		image_index = 0;
	}
}

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			obj_panel_bot.xNode[timeIndex] = self.x;
			obj_panel_bot.yNode[timeIndex] = self.y;
			obj_panel_bot.zoomVal[timeIndex] = real(self.zoomVal);
			obj_trigger_region_parent.alarm[2] = 2;
			
			instance_destroy();
		} else {
			canDrag = true;
			canPlace = false;
			alarm[0] = 18;
		}
	} else {
		// The first mouse button release does not count
		canRelease = true;
	}
}

if keyboard_check_pressed(vk_anykey) {
	if !keyboard_check_direct(20) { // Caps Lock
		if keyboard_check_pressed(vk_decimal) || keyboard_check_pressed(190) {
			// Add a decimal
			zoomVal = zoomVal + ".";
			decimalPlace = string_length(zoomVal);
		} else {
			// Add an integer
			zoomVal = string_digits(typeText(zoomVal, true));
			
			if decimalPlace != -1 {
				zoomVal = string_insert(".",zoomVal,decimalPlace);
			}
			
			// Delete decimal
			if keyboard_check_pressed(vk_backspace) {
				if string_length(zoomVal) = decimalPlace {
					decimalPlace = -1;
				}
			}
		}
	}
}

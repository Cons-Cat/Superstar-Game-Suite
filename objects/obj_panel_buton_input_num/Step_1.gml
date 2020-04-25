/// @description Number input behavior.
if select {
	if keyboard_check_pressed(vk_anykey) {
		if !keyboard_check_direct(20) { // Caps Lock
			if keyboard_check_pressed(vk_decimal) || keyboard_check_pressed(190) {
				// Add a decimal
				arbitraryVal = arbitraryVal + ".";
				decimalPlace = string_length(arbitraryVal);
			} else {
				// Add an integer
				arbitraryVal = string_digits(typeText(arbitraryVal,true));
					
				if decimalPlace != -1 {
					arbitraryVal = string_insert(".",arbitraryVal,decimalPlace);
				}
				
				// Delete decimal
				if keyboard_check_pressed(vk_backspace) {
					if string_length(arbitraryVal) = decimalPlace {
						decimalPlace = -1;
					}
				}
			}
			
			valueLength = string_width(arbitraryVal)*2 + 4;
		}
	}
}
/// @description String input behavior.
if select {
	if keyboard_check_pressed(vk_anykey) {
		arbitraryVal = typeText(arbitraryVal, true);
	}
		
	valueLength = string_width(arbitraryVal)*2 + 4;
}

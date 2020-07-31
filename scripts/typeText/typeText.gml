// Custom simple keyboard input script
/*
argument[0] is the string inputted
argument[1] declares whether backspace can be expressed
*/

if !keyboard_check_pressed(vk_shift)
&& !keyboard_check_pressed(global.leftInput) && !keyboard_check_pressed(global.rightInput) && !keyboard_check_pressed(global.upInput) && !keyboard_check_pressed(global.downInput)
&& !keyboard_check_pressed(vk_control) && !keyboard_check_pressed(vk_alt) && !keyboard_check_pressed(vk_enter)
&& !keyboard_check_direct(20)
{
	if keyboard_check_pressed(vk_backspace) {
		if argument[1] {
			return string_delete(string(argument[0]),string_length(string(argument[0])),1);
		} else {
			// Do not mutate string
			return string_copy(string(argument[0]), 1, string_length(string(argument[0])));
		}
	} else {
		return string_copy(string(argument[0]) + keyboard_lastchar, 1, string_length(string(argument[0])) + 1);
	}
} else {
	// Do not mutate string
	return string_copy(string(argument[0]), 1, string_length(string(argument[0])));
}

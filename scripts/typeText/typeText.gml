// Custom simple keyboard input script
if !keyboard_check_pressed(vk_shift)
&& !keyboard_check_pressed(vk_left) && !keyboard_check_pressed(vk_right) && !keyboard_check_pressed(vk_up) && !keyboard_check_pressed(vk_down)
&& !keyboard_check_pressed(vk_control) && !keyboard_check_pressed(vk_alt) && !keyboard_check_pressed(vk_enter)
&& !keyboard_check_direct(20)
{
	if keyboard_check_pressed(vk_backspace) {
		return string_delete(string(argument[0]),string_length(string(argument[0])),1);
	} else {
		return string_copy(string(argument[0]) + keyboard_lastchar, 1, string_length(string(argument[0])) + 1);
	}
} else {
	return string_copy(string(argument[0]), 1, string_length(string(argument[0])));
}

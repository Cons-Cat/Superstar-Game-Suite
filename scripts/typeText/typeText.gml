// Custom simple keyboard input script
var backSpace = keyboard_check_pressed(vk_backspace);

if backSpace {
	return string_delete(string(argument[0]),string_length(string(argument[0])),1);
} else {
	return string_copy(string(argument[0]) + keyboard_lastchar, 1, string_length(string(argument[0])) + 1); //argument[0] + string(keyboard_string);
}

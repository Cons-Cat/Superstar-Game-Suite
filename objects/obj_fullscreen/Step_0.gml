/// @description Fullscreen
if keyboard_check_pressed(vk_space) {
	size += 3;
	window_center();
	window_set_size(342*size,192*size);
}
if size > 7 {
	size = 1;
}

if size = 7 {
	window_set_fullscreen(true);
} else {
	window_set_fullscreen(false);
}

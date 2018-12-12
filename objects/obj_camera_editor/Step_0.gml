/// @description Move camera
if obj_editor_gui.mode != 2 && (obj_editor_gui.mode != 3 || global.pieceSelected = -1) {
	if mouse_check_button_pressed(mb_right) {
		tempX = mouse_x;
		tempY = mouse_y;
		spasmFix = false;
		spasmX[0] = 0;
		spasmX[2] = 1;
		spasmI = 0;
	}
	if mouse_check_button(mb_right) && spasmFix = false {
		if mouse_x != tempX {
			x += tempX - mouse_x;
			tempX = mouse_x;
			spasmX[spasmI] = x;
		
			if spasmI < 2 {
				spasmI += 1;
			} else {
				spasmI = 0;
			}
		}
		if mouse_y != tempY {
			y += tempY - mouse_y;
			tempY = mouse_y;
		}
	}
	if spasmX[0] = spasmX[2] {
		if spasmFix = false {
			spasmFix = true;
			alarm[0] = 20;
		}
	}

	// Arrow key movement
	if keyboard_check(vk_right) {
		x += 7;
	}
	if keyboard_check(vk_left) {
		x -= 7;
	}
	if keyboard_check(vk_down) {
		y += 7;
	}
	if keyboard_check(vk_up) {
		y -= 7;
	}
} else {
	// Follow player
	if instance_exists(obj_player_overworld) {
		x = obj_player_overworld.x;
		y = obj_player_overworld.y-obj_player_overworld.platOn;
	}
}

// Boundaries
if x < 170 {
	x = 170;
}
if x > room_width - 170 {
	x = room_width - 170;
}
if y < 80 {
	y = 80;
}
if y > room_height - 168 - 80 {
	y = room_height - 168 - 80;
}

// Debug viewports
if keyboard_check_pressed(ord("1")) {
	room_set_viewport(roomVar,0,true,0,0,460,259);
}
if keyboard_check_pressed(ord("2")) {
	room_set_viewport(roomVar,0,true,0,0,920,518);
}
if keyboard_check(vk_alt) && keyboard_check_pressed(vk_enter) {
	window_set_fullscreen(!window_get_fullscreen());
}

depth = -room_height - 200;

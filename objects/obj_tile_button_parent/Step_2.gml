/// @description Stay on interface
x = camera_get_view_x(obj_editor_gui.camera)+startX;
y = camera_get_view_y(obj_editor_gui.camera)+startY;

if (mouse_x < self.x && mouse_x > self.x - sprite_width && mouse_y > self.y && mouse_y < self.y + sprite_height) {
	depth = -room_height - 310;
	if flagTime > 0 {
		flagTime -= 1;
	} else {
		flagOn = true;
	}
} else {
	depth = -room_height - 300;
	flagTime = flagTimeMax;
	flagOn = false;
}

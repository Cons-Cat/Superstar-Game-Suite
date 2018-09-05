/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 1 {
		x = floor(mouse_x / 20) * 20;
		y = floor(mouse_y / 20) * 20;
		trg.x = self.x;
		trg.y = self.y;
		trg.lastX = x;
		trg.lastY = y;
	}
}

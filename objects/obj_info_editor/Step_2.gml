/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		// Top left corner
		y = trg.y - 20;
		
		if trg.width > 2 {
			x = trg.x;
		} else {
			x = trg.x - 20;
		}
	}
}

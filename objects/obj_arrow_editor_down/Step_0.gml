/// @description 
event_inherited();

if instance_exists(trg) {
	x = trg.x + trg.width*10; // Halfway down the width

	if select = 1 {
		if mouse_y > trg.y + 20 {
			y = floor(mouse_y/20)*20;
		
			if self.y > trg.y + trg.height*20 {
				trg.height += 1;
			}
			if self.y < trg.y + trg.height*20 {
				trg.height -= 1;
			}
			trg.resetArray = true;
		}
	}
}

/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		// Bottom right corner
		y = trg.y + trg.height*20;
		
		if trg.zfloor > trg.zcieling {
			x = trg.x + trg.width*20;
		} else {
			x = trg.x + trg.width*20 + 20;
		}
	}
}

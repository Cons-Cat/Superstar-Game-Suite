/// @description 
event_inherited();


if instance_exists(trg) {
	if select = 1 {
		if selectYOff = 0 {
			selectYOff = mouse_y - y;
		}
		y = floor((mouse_y - selectYOff)/20)*20;
	
		if y > trg.y + trg.height*10 + (trg.zfloor - trg.zcieling) * 20 {
			y = trg.y + trg.height*10 + (trg.zfloor - trg.zcieling) * 20;
		}
	
		if self.y < trg.y + 20 {
			trg.zfloor += 1;
			trg.y -= 20;
		}
		if self.y > trg.y + 20 && trg.zfloor > trg.zcieling {
			trg.zfloor -= 1;
			trg.y += 20;
		}
		trg.resetArray = true;
	}
}

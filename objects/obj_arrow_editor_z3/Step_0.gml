/// @description 
event_inherited();

if select = 1 {
	if selectYOff = 0 {
		selectYOff = mouse_y - y;
	}
	y = floor((mouse_y - selectYOff)/20)*20;
	
	if y > trg.y + trg.height*10 {
		y = trg.y + trg.height*10 - 25;
	}
	
	if self.y + 25 < trg.y + trg.height*10 {
		trg.zfloor += 1;
		trg.zcieling += 1;
		trg.y -= 20;
	}
	if self.y + 25 > trg.y + trg.height*10 {
		if trg.zfloor > 0 {
			trg.zfloor -= 1;
			trg.zcieling -= 1;
			trg.y += 20;
		}
	}
}

/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 1 {
		y = floor(mouse_y/20)*20;
	
		if y < trg.y + trg.height*20 {
			y = trg.y + trg.height*20;
		}
		if trg.zcieling = 0 {
			if y > trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
				y = trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20;
			}
		}
	
		if self.y < trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
			trg.zcieling += 1;
		}
		if self.y > trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
			if trg.zcieling > 0 {
				trg.zcieling -= 1;
			}
		}
		trg.resetArray = true;
	}
}

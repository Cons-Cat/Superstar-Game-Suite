/// @description 
event_inherited();

if instance_exists(trg) {
	y = trg.y + trg.height*10; // Halfway down the height
	
	if select = 1 {
		if mouse_x > trg.x + 20 && trg.str != "slope2" && trg.str != "slope3" {
			x = floor(mouse_x/20)*20;
			
			if self.x > trg.x + trg.width*20 {
				trg.width += 1;
			}
			if self.x < trg.x + trg.width*20 {
				trg.width -= 1;
			}
			
			trg.resetArray = true;
		}
		if mouse_x > trg.x + 40 && trg.str = "slope2" && trg.str != "slope3" {
			x = floor(mouse_x/40)*40 + x % 40;
			if self.x > trg.x + trg.width*20 {
				trg.width += 2;
			}
			if self.x < trg.x + trg.width*20 {
				trg.width -= 2;
			}
			
			trg.resetArray = true;
		}
	}
}

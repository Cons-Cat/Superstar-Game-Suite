/// @description 
event_inherited();

if instance_exists(trg) {
	y = trg.y + trg.height*10; // Halfway down the height

	if select = 1 {
		if mouse_x < trg.x + trg.width*20 - 20 {
			x = floor(mouse_x/20)*20 + 20;
		
			if self.x < trg.x {
				tempWidth = trg.x + trg.width*20;
				trg.x = self.x;
				trg.width = (tempWidth - trg.x)/20;
				limitOn = false;
			
				if trg.str = "slope1" {
					trg.y = trg.lastY + trg.width*20 - (trg.zfloor-trg.zcieling)*20 - trg.height*20;
				}
				if trg.str = "slope2" {
					trg.y = trg.lastY + trg.width*20 - (trg.zfloor-trg.zcieling)*20 - trg.height*20;
				}
			}
			if self.x > trg.x {
				tempWidth = trg.x + trg.width*20;
				trg.x = self.x;
				trg.width = (tempWidth - trg.x)/20;
				limitOn = false;
			
				if trg.str = "slope1" {
					trg.y = trg.lastY + trg.width*20 - (trg.zfloor-trg.zcieling)*20 - trg.height*20;
				}
				if trg.str = "slope2" {
					trg.y = trg.lastY + trg.width*20 - (trg.zfloor-trg.zcieling)*20 - trg.height*20;
				}
			}
			trg.resetArray = true;
		}
	}
}

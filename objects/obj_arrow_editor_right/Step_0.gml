/// @description 
event_inherited();

y = trg.y + trg.height*10; // Halfway down the height

if select = 1 {
	if mouse_x > trg.x + 20 {
		x = floor(mouse_x/20)*20;
		
		if self.x > trg.x + trg.width*20 {
			trg.width += 1;
		}
		if self.x < trg.x + trg.width*20 {
			trg.width -= 1;
		}
		trg.resetArray = true;
	}
}

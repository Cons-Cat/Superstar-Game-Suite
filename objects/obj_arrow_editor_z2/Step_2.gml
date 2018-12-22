/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		selectYOff = 0
		
		if trg.width = 1 {
			x = trg.x+trg.width*10 + 20; // Halfway down width
		} else if trg.width = 2 {
			x = trg.x+trg.width*10 + 10; // Halfway down width
		} else {
			x = trg.x+trg.width*10; // Halfway down width
		}
		
		y = trg.y+trg.height*20+(trg.zfloor - trg.zcieling)*20; // Bottom edge of wall
	}
}

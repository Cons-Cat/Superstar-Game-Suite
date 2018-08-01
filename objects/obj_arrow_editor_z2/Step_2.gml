/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		x = trg.x+trg.width*10 + 20; // Halfway down width
		y = trg.y+trg.height*20+(trg.zfloor - trg.zcieling)*20; // Bottom edge of wall
	}
}

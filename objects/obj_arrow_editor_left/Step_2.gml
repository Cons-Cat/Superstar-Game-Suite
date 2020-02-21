/// @description 
event_inherited();

if instance_exists(trg) {
	if !select {
		x = trg.x; // Left edge
		y = trg.floorY + trg.height*10; // Halfway down the height
	}
}

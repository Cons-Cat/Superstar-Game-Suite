/// @description 
event_inherited();

// Staying on terrain
if instance_exists(trg) {
	if select = 0 {
		// Top left corner
		x = trg.x;
		y = trg.floorY;
	}
}

/// @description 
event_inherited();

if instance_exists(trg) {
	if select = 0 {
		y = trg.y + trg.height*20; // Bottom edge
	}
}

/// @description 
event_inherited();

if instance_exists(trg) {
	if !select {
		y = trg.y + trg.height*20; // Bottom edge
	}
}

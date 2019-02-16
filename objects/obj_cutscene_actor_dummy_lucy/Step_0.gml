/// @description 
if !instance_exists(trg) {
	instance_destroy();
} else {
	if trg.select {
		depth = trg.depth - 1;
	} else {
		instance_destroy();
	}
}

event_inherited();

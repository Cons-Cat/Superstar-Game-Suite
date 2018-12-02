/// @description Follow coordinates
if instance_exists(trg) {
	x = floor(trg.x);
	y = floor(trg.y);
} else {
	instance_destroy();
}

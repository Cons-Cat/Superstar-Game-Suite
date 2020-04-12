/// @description 
event_inherited();

if instance_exists(trg) {
	x = trg.x + ( (magnitude) * 20 * trg.angleRun)
	+ ( trg.width * 20 * trg.angleRise / 2 );
	y = trg.y + ( (magnitude) * 20 * trg.angleRise) + ( trg.zfloor - trg.zcieling ) * 20
	+ ( trg.width * 20 * -trg.angleRun / 2 );
}

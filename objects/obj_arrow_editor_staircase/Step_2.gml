/// @description 
event_inherited();

if instance_exists(trg) {
	x = trg.x + lengthdir_x(trg.staircaseN, trg.angle) + lengthdir_x(trg.staircaseL, trg.normalAngle) / 2;
	y = trg.y + lengthdir_y(trg.staircaseN, trg.angle) + lengthdir_y(trg.staircaseL, trg.normalAngle) / 2
	+ ( trg.zfloor - trg.zcieling ) * 20;
}

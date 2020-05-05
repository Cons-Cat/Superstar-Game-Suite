var instActor = argument[0];
var instColl = argument[1];
var zDisplace = clamp(instColl.zfloor*20 - ceil( point_distance(instColl.actorXOrigin, instColl.actorYOrigin, instActor.x, instActor.y) / instColl.staircaseN * instColl.zfloor*20 ), instColl.zcieling*20, instColl.zfloor*20) - (instColl.zfloor * 20);

if (instColl.zfloor*20 + zDisplace > instActor.jumpHeight && instColl.zcieling*20 <= instActor.jumpHeight) || (!instColl.finite && instColl.zcieling*20 <= instActor.jumpHeight) {
	return true;
} else {
	return false;
}

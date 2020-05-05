var instActor = argument[0];
var instColl = argument[1];

if (instColl.zfloor*20 > instActor.jumpHeight && instColl.zcieling*20 <= instActor.jumpHeight) || (!instColl.finite && instColl.zcieling*20 <= instActor.jumpHeight) {
	return true;
} else {
	return false;
}

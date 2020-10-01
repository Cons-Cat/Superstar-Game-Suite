function scr_cancollide_stairsrail() {
	var instActor = argument[0];
	var instColl = argument[1];
	// var zDisplace = clamp(instColl.zfloor*20 - ceil( point_distance(instColl.actorXOrigin, instColl.actorYOrigin, instActor.x, instActor.y) / instColl.staircaseN * instColl.zfloor*20 ), instColl.zcieling*20, instColl.zfloor*20) - (instColl.zfloor * 20);

	var zDisplace = clamp(
	ceil( point_distance(instColl.actorXOrigin, instColl.actorYOrigin, instActor.x, instActor.y) / (instColl.staircaseN - instActor.maskRadius) * (instColl.zfloor - instColl.zcieling)*20 ),
	0,
	(instColl.zfloor - instColl.zcieling)*20
	)
		
	//var zDisplace = clamp(instColl.zfloor*20 - ceil( point_distance(instColl.actorXOrigin, instColl.actorYOrigin, instActor.x, instActor.y) / instColl.staircaseN * instColl.zfloor*20 ), instColl.zcieling*20, instColl.zfloor*20) - (instColl.zfloor * 20);
	show_debug_message(" ")
	show_debug_message(string(instColl)+" "+string(zDisplace));
	show_debug_message(string(instColl)+" "+string(instActor.jumpHeight));
	////show_debug_message(string(instColl)+" "+string(instColl.zcieling*20 - zDisplace));
	//show_debug_message(string(instColl)+" "+string(instColl.actorXOrigin));
	//show_debug_message(string(instColl)+" "+string(instColl.actorYOrigin));

	if (instColl.zcieling*20 + zDisplace > instActor.jumpHeight && instColl.zcieling*20 <= instActor.jumpHeight) || (!instColl.finite && instColl.zcieling*20 <= instActor.jumpHeight) {
		return true;
	} else {
		return false;
	}



}

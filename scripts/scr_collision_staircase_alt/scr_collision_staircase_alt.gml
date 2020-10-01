/// scr_collision_staircase()
function scr_collision_staircase_alt() {
	var stairsId = argument[0];
	var run;
	var rise;
	var actorXOrigin;
	var actorYOrigin;

	// Staircase collision
#region

	run  = stairsId.angleRise;
	rise = -stairsId.angleRun;

	// Check for intersections with the actor.
	for (var i = 0; i < stairsId.width * 20; i += 0.5) {
		stairsId.lineX1[i] = stairsId.xStairs + i*run;
		stairsId.lineY1[i] = stairsId.yStairs + i*rise + (stairsId.zfloor - stairsId.zcieling)*20 + self.zfloor*20;
		stairsId.lineX2[i] = stairsId.xStairs + i*run + stairsId.angleRun*stairsId.staircaseN;
		stairsId.lineY2[i] = stairsId.yStairs + i*rise + stairsId.angleRise*stairsId.staircaseN + (stairsId.zfloor - stairsId.zcieling)*20 + self.zfloor*20;
	
		if collision_line(stairsId.lineX1[i], stairsId.lineY1[i], stairsId.lineX2[i], stairsId.lineY2[i],obj_collision_handler, false, false) {
			// Iterating across the tall and wide edge of the staircase, and casting a ray down the steps.
			actorXOrigin = stairsId.xStairs + i*run + stairsId.angleRun*stairsId.staircaseN;
			actorYOrigin = stairsId.yStairs + i*rise + stairsId.zfloor*20  + stairsId.angleRise*stairsId.staircaseN;
		
			zDisplace = clamp(
			ceil( point_distance(actorXOrigin, actorYOrigin, x, y) / (stairsId.staircaseN - maskRadius) * (stairsId.zfloor - stairsId.zcieling)*20 ),
			0,
			(stairsId.zfloor - stairsId.zcieling)*20
			)
		
			// Pass these into the floor collision object, which passes them into its wall collision objects.
			stairsId.actorXOrigin = actorXOrigin;
			stairsId.actorYOrigin = actorYOrigin;
		
			return true;
		}
	}

#endregion

	return false;



}

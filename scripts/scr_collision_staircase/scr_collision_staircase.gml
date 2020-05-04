/// scr_collision_staircase()
var run;
var rise;
var actorXOrigin;
var actorYOrigin;

// Staircase collision
#region

onStaircase = false;

if collision_rectangle(x, y, x + 1, y + 1, obj_staircase_collision, true, false) {
	if !onStaircase {
		staircaseId = collision_rectangle(x, y, x + 1, y + 1, obj_staircase_collision, true, false);
		
		run  = staircaseId.angleRise;
		rise = -staircaseId.angleRun;
		
		for (var i = 0; i <= staircaseId.width * 20; i += 0.5) {
			staircaseId.lineX1[i] = staircaseId.xStairs + i*run;
			staircaseId.lineY1[i] = staircaseId.yStairs + i*rise + (staircaseId.zfloor - staircaseId.zcieling)*20 + self.zfloor*20;
			staircaseId.lineX2[i] = staircaseId.xStairs + i*run + staircaseId.angleRun*staircaseId.staircaseN;
			staircaseId.lineY2[i] = staircaseId.yStairs + i*rise + staircaseId.angleRise*staircaseId.staircaseN + (staircaseId.zfloor - staircaseId.zcieling)*20 + self.zfloor*20;
			
			if collision_line(staircaseId.lineX1[i], staircaseId.lineY1[i], staircaseId.lineX2[i], staircaseId.lineY2[i],obj_collision_handler, false, false) {
				// Iterating across the tall and wide edge of the staircase, and casting a ray down the steps.
				if !onStaircase {
					actorXOrigin = staircaseId.xStairs + i*run + staircaseId.angleRun*staircaseId.staircaseN;
					actorYOrigin = staircaseId.yStairs + i*rise + staircaseId.zfloor*20  + staircaseId.angleRise*staircaseId.staircaseN;
					
					onStaircase = true; // Used to over ride depth algorithm
				}
				
				//zDisplace = clamp(staircaseId.zcieling*20 + ( point_distance(actorXOrigin, actorYOrigin, x, y) / staircaseId.staircaseN * staircaseId.zfloor*20 ), staircaseId.zcieling*20, staircaseId.zfloor*20);
				//zDisplace = clamp(staircaseId.zcieling*20 + ceil( point_distance(actorXOrigin, actorYOrigin, x, y) / staircaseId.staircaseN * staircaseId.zfloor*20 ), staircaseId.zcieling*20, staircaseId.zfloor*20 + 1);
				zDisplace = clamp(staircaseId.zfloor*20 - ceil( point_distance(actorXOrigin, actorYOrigin, x, y) / staircaseId.staircaseN * staircaseId.zfloor*20 ), staircaseId.zcieling*20, staircaseId.zfloor*20) - (staircaseId.zfloor * 20);
				
				break;
			}
			
			if i = staircaseId.width*20 {
				actorXOrigin = -1;
				actorYOrigin = -1;
				
				onStaircase = false;
			}
		}
		
		staircaseId.lineX1[i] = -1;
		staircaseId.xOrigina = actorXOrigin;
		staircaseId.yOrigina = actorYOrigin;
	}
}

#endregion

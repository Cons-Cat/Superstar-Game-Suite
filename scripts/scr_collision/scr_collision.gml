var colNorth = false;
var colSouth = false;
var colWest = false;
var colEast = false;
var trgColl;

var slopeOffset;
var j;
var run;
var rise;
var actorXOrigin;
var actorYOrigin;
var ax = floor(x);
var ay = floor(y);

// Staircase collision
onStaircase = false;

if collision_rectangle(ax, ay, ax + 1, ay + 1, obj_staircase_collision, false, false) {
	if !onStaircase {
		staircaseId = collision_rectangle(ax, ay, ax + 1, ay + 1, obj_staircase_collision, false, false);
		
		run  = staircaseId.angleRise;
		rise = -staircaseId.angleRun;
		
		for (var i = 0; i <= staircaseId.width * 20; i += 0.5) {
			staircaseId.lineX1[i] = staircaseId.xStairs + i*run;
			staircaseId.lineY1[i] = staircaseId.yStairs + i*rise + (staircaseId.zfloor - staircaseId.zcieling)*20 + self.zfloor*20;
			staircaseId.lineX2[i] = staircaseId.xStairs + i*run + staircaseId.angleRun*staircaseId.staircaseN;
			staircaseId.lineY2[i] = staircaseId.yStairs + i*rise + staircaseId.angleRise*staircaseId.staircaseN + (staircaseId.zfloor - staircaseId.zcieling)*20 + self.zfloor*20;
			
			if collision_line(staircaseId.lineX1[i], staircaseId.lineY1[i], staircaseId.lineX2[i], staircaseId.lineY2[i],obj_staircase_collision_mask, false, false) {
				// Iterating across the tall and wide edge of the staircase, and casting a ray down the steps.
				if !onStaircase {
					actorXOrigin = staircaseId.xStairs + i*run + staircaseId.angleRun*staircaseId.staircaseN;
					actorYOrigin = staircaseId.yStairs + i*rise + staircaseId.zfloor*20  + staircaseId.angleRise*staircaseId.staircaseN;
					onStaircase = true; // Used to over ride depth algorithm
				}
				
				jumpHeight = clamp(staircaseId.zcieling*20 + ( point_distance(actorXOrigin, actorYOrigin, x, y) / staircaseId.staircaseN * staircaseId.zfloor*20 ), staircaseId.zcieling*20, staircaseId.zfloor*20);
				
				break;
			}
			
			if i = staircaseId.width*20 {
				onStaircase = false;
				actorXOrigin = -1;
				actorYOrigin = -1;
			}
		}
		
		staircaseId.lineX1[i] = -1;
		staircaseId.xOrigina = actorXOrigin;
		staircaseId.yOrigina = actorYOrigin;
	}
}

for (var i = 0; i < instance_number(obj_solid_parent); i++) {
	trgColl = instance_find(obj_solid_parent, i).id;
	trgColl.DRAWC = 0;
	
	if place_meeting(x, y, trgColl) {
		// Bresnham line inteprolation across the collision vector.
		var x1 = trgColl.collX1;
		var y1 = trgColl.collY1;
		var x2 = trgColl.collX2;
		var y2 = trgColl.collY2;
		
		var dx = abs(x2 - x1);
		var sx = (x1 < x2) ? 1 : -1;
		var dy = -abs(y2 - y1);
		var sy = (y1 < y2) ? 1 : -1;
		var err = dx + dy;
		var e2;
		
		var leftward;
		if x1 > x2 { leftward = 1; }
		else if x1 < x2 { leftward = 0; }
		else { leftward = 2; }
		
		var upward;
		if y1 > y2 { upward = 1; }
		else if y1 < y2 { upward = 0; }
		else { upward = 2; }
		
		var ang = point_direction(x1, y1, x2, y2);
		var normalAng;
		var breakBool;
		
		while (true) {
			breakBool = false;
			
			// Collision.
			with trgColl {
				DRAWC++;
				DRAWX[DRAWC] = x1;
				DRAWY[DRAWC] = y1;
				
				if position_meeting(x1, y1, other.id) {
					if other.y > y1 {
						// Actor is below collision.
						normalAng = ang - 90;
					} else {
						// Actor is above collision.
						normalAng = ang + 90;
					}
					
					normalAng = (normalAng + 360) % 360;
					
					if (other.c_hspeed != 0 || other.c_vspeed != 0) {
						while position_meeting(x1, y1, other.id) {
							other.x += lengthdir_x(other.c_hspeed, normalAng);
							other.y += lengthdir_y(other.c_vspeed, normalAng);
						}
					}
					
					breakBool = true;
				}
			}
			
			if breakBool { break; }
			
			if
			(  ( x1 >= x2 && leftward = 0) || ( x1 <= x2 && leftward = 1 ) || ( x1 = x2 && leftward = 2)  )
			&& (  ( y1 >= y2 && upward = 0) || ( y1 <= y2 && upward = 1 ) || (y1 = y2 && upward = 2)  )
			{
				break;
			}
			
			e2 = 2 * err;
			
			if e2 >= dy {
				err += dy;
				x1 += sx;
			}
			
			if e2 <= dx {
				err += dx;
				y1 += sy;
			}
		}
	}
}

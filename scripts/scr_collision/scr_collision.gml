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
		var x0 = x1;
		var y0 = y1;
		
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
		var actorAngle = point_direction(0, 0, other.c_hspeed, other.c_vspeed);
		var normalAng = ang - 90;
		var actorAngleReflect;
		var actorReflectX;
		var actorReflectY;
		var quadrant;
		var breakBool;
		
		while (true) {
			breakBool = false;
			
			// Collision.
			with trgColl {
				DRAWC++;
				DRAWX[DRAWC] = x1;
				DRAWY[DRAWC] = y1;
				
				if position_meeting(x1, y1, other.id) {
					/*
					// Find the point of intersection.
					var breakBool2 = false;
					
					for(var i = 0; i < sprite_get_width(other.mask_index); i++) {
						for(var j = 0; j < sprite_get_height(other.mask_index); j++) {
							if round(other.bbox_left) + i = x1 && round(other.bbox_top) + j = y1 {
								// Find the quadrant of intersection.
								show_debug_message("I, J: " + string(i) + ", " + string(j));
								actorVector = point_direction(x1, y1, other.bbox_left + i - other.c_hspeed*2, other.bbox_top + j - other.c_vspeed*2 );
								show_debug_message("DIRECT: " + string(actorVector));
								quadrant = actorVector div 90;
								show_debug_message("QUAD: " + string(quadrant));
								show_debug_message("SPEED: " + string(other.c_hspeed) + ", " + string(other.c_vspeed));
								
								breakBool2 = true;
								break;
							}
						}
						
						if breakBool2 {
							break;
						}
					}
					
					while normalAng div 90 != quadrant {
						normalAng = (normalAng + 90 + 360) % 360;
					}
					show_debug_message(string(normalAng) + ", " + string(quadrant));
					*/
					
					if (other.c_hspeed != 0 || other.c_vspeed != 0) {
						var VAx = other.c_hspeed;
						var VAy = other.c_vspeed;
						var VNx = y2 - y0;
						var VNy = x0 - x2;
						
						var vDist = point_distance(0, 0, VNx, VNy);
						
						// Normalize VN
						var VNHatx = VNx / vDist;
						var VNHaty = VNy / vDist;
						
						// Find dot product
						var dotProduct = (other.c_hspeed * VNHatx) + (other.c_vspeed * VNHaty);
						var VXx =  dotProduct * VNHatx * 2;
						var VXy =  dotProduct * VNHaty * 2;
						
						var xOff = VAx - VXx;
						var yOff = VAy - VXy
						show_debug_message("OFF: " + string(xOff) + ", " + string(yOff) + " ... " + string(id));
						
						while position_meeting(x1, y1, other.id) {
							other.x += xOff;
							other.y += yOff;
						}
					}
					
					breakBool = true;
				}
			}
			
			if
			(  ( x1 >= x2 && leftward = 0) || ( x1 <= x2 && leftward = 1 ) || ( x1 = x2 && leftward = 2 )  )
			&& (  ( y1 >= y2 && upward = 0) || ( y1 <= y2 && upward = 1 ) || (y1 = y2 && upward = 2 )  )
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

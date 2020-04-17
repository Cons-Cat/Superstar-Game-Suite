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
var projectDir;

var normalAngleListX;
var normalAngleListY;
var intersectionCount = 0;
var intersectionX;
var intersectionY;
var summedAngleX = 0;
var summedAngleY = 0;

// Staircase collision
#region

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

#endregion

// Loop through collision vectors
#region

for (var i = 0; i < instance_number(obj_solid_parent); i++) {
	trgColl = instance_find(obj_solid_parent, i).id;
	trgColl.DRAWC = 0;
	
	if point_distance(x, y, trgColl.collX1 + (trgColl.collX2 - trgColl.collX1)/2, trgColl.collY1 + (trgColl.collY2 - trgColl.collY1)/2) < point_distance(trgColl.collX1,trgColl.collY1,trgColl.collX2,trgColl.collY2) + max(collisionCoeffX, collisionCoeffY) {
		for (var j = 0; j <= 1; j++) {
			if trgColl.projectState != 2 {
				if j = 1 { break; }
				projectDir = trgColl.projectState;
			} else {
				projectDir = j;
			}
			
			// Bresnham line inteprolation across the collision vector.
			var x1 = trgColl.collX1;
			var y1 = trgColl.collY1;
			var x2 = trgColl.collX2;
			var y2 = trgColl.collY2;
			
			var ang = point_direction(x1, y1, x2, y2);
			var normalAng = (ang - 90 + 360) % 360;
			//var actorAngle = point_direction(0, 0, other.c_hspeed, other.c_vspeed);
			
			if projectDir = 0 {
				x1 -= ceil(lengthdir_x(collisionCoeffX, normalAng + 45));
				y1 -= ceil(lengthdir_y(collisionCoeffY, normalAng + 45));
				x2 -= ceil(lengthdir_x(collisionCoeffX, normalAng - 45));
				y2 -= ceil(lengthdir_y(collisionCoeffY, normalAng - 45));
			} else if projectDir = 1 {
				x1 += ceil(lengthdir_x(collisionCoeffX, normalAng - 45));
				y1 += ceil(lengthdir_y(collisionCoeffY, normalAng - 45));
				x2 += ceil(lengthdir_x(collisionCoeffX, normalAng + 45));
				y2 += ceil(lengthdir_y(collisionCoeffY, normalAng + 45));
				//x1 -= lengthdir_x(collisionCoeffX, normalAng - 45)
				//y1 -= lengthdir_y(collisionCoeffY, normalAng - 45);
				//x2 -= lengthdir_x(collisionCoeffX, normalAng + 45);
				//y2 -= lengthdir_y(collisionCoeffY, normalAng + 45);
			}
			
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
			
			var breakBool = false;
			
			// Loop across line.
			while (true) {
				// Collision.
				with trgColl {
					DRAWC++;
					DRAWX[DRAWC] = x1;
					DRAWY[DRAWC] = y1;
					
					if collision_point(x1, y1, other.id, false, true)
					//if floor(x) = x1 && floor(y) = y1
					{
						// Assigned here, because this is more precise than the actor's X or Y.
						intersectionX = x1;
						intersectionY = y1;
						
						if (other.c_hspeed != 0 || other.c_vspeed != 0) {
							//var VAx = other.c_hspeed;
							//var VAy = other.c_vspeed;
							var VNx = y2 - y0;
							var VNy = x0 - x2;
							
							// Prevent walking directly into a vector.
							/*var testAngle = ( actorAngle - normalAng + 360 ) % 360;
							if (testAngle = 270) || (testAngle = 90) {
								break;
							}*/
							
							// Normalize VN
							var vDist = point_distance(0, 0, VNx, VNy);
							
							var VNHatx = VNx / vDist;
							var VNHaty = VNy / vDist;
							
							normalAngleListX[intersectionCount] = VNHatx;
							normalAngleListY[intersectionCount] = VNHaty;
							
							/*
							// Find dot product
							var dotProduct = (other.c_hspeed * VNHatx) + (other.c_vspeed * VNHaty);
							var VXx =  dotProduct * VNHatx * 2;
							var VXy =  dotProduct * VNHaty * 2;
							
							var xOff = VAx - VXx;
							var yOff = VAy - VXy
							show_debug_message("OFF: " + string(xOff) + ", " + string(yOff) + " ... " + string(id));
							show_debug_message("");
							reflectionAngleListX[intersectionCount] = VXx;
							reflectionAngleListY[intersectionCount] = VXy;
							intersectionCount++;
							breakBool = true;
							*/
							
							//while collision_point(x1, y1, other.id, false, true)
							//{
							//	other.x += xOff;
							//	other.y += yOff;
							
							intersectionCount++;
							breakBool = true;
						}
					}
				}
				
				if breakBool {
					break;
				}
				
				// Break at the end of the line.
				if
				(  ( x1 >= x2 && leftward = 0) || ( x1 <= x2 && leftward = 1 ) || ( x1 = x2 && leftward = 2 )  )
				&& (  ( y1 >= y2 && upward = 0) || ( y1 <= y2 && upward = 1 ) || (y1 = y2 && upward = 2 )  )
				{
					break;
				}
				
				// Iterate across the line.
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
}

#endregion

// Sum angles
if intersectionCount > 0 {
	show_debug_message("COUNT: " + string(intersectionCount));
	// Sum normal angles.
	for (i = 0; i < intersectionCount; i++) {
		summedAngleX += normalAngleListX[i];
		summedAngleY += normalAngleListY[i];
	}
	
	// Normalize summed angle.
	var vDist = point_distance(0, 0, summedAngleX, summedAngleY);
	
	var VNHatx = summedAngleX / vDist;
	var VNHaty = summedAngleY / vDist;
	
	// Find dot product
	var dotProduct = (c_hspeed * VNHatx) + (c_vspeed * VNHaty);
	var VXx =  dotProduct * VNHatx * 2;
	var VXy =  dotProduct * VNHaty * 2;
	
	//var xOff = VAx - VXx;
	//var yOff = VAy - VXy
	//reflectionAngleListX[intersectionCount] = VXx;
	//reflectionAngleListY[intersectionCount] = VXy;
	//intersectionCount++;
	//breakBool = true;
	
	var xOff = c_hspeed - VXx;
	var yOff = c_vspeed - VXy;
	show_debug_message("OFF: " + string(xOff) + ", " + string(yOff) + " ... " + string(id));
	show_debug_message("");
	
	while collision_point(intersectionX, intersectionY, self, false, false)
	//while floor(x) = intersectionX && floor(y) = intersectionY
	{
		x += xOff;
		y += yOff;
	}
	
	//x = round(x);
	//y = round(y);
}
	
/// @description 
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode != 2 {
		activated = false;
	}
	
	// Adapting visible state to editor mode
	if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 4 {
		visible = true;
	} else {
		visible = false;
	}
}

if !activated {
	// Not in play mode
	if instance_exists(trg) {
		zfloor = trg.zfloor;
		x = trg.x + 10;
		y = trg.y + 10;
		depth = trg.depth - 1;
	} else {
		instance_destroy();
	}
	
	direction = 270;
	speed = 0; // move_towards_point() sets a speed value
	spd = 0;
	
	i = 0;
	moving = false;
	trgRegion = -1;
	dirIso = 4;
	spr = sprD;
} else {
	// In play mode
	
	// Walking
	if (xNode[i] != -1 && yNode[i] != -1) {
		if (x <= xNode[i]-speed || x >= xNode[i]+speed) || (y <= yNode[i]-speed || y >= yNode[i]+speed) {
			if point_distance(x,y,xNode[i],yNode[i]) <= 3 {
				// Decelerate
				if endWalk[i] {
					if spd > 0.1 {
						spd -= 0.165;
					} else {
						spd = 0.1;
					}
				}
			} else if point_distance(x,y,xNode[i],yNode[i]) > 3 {
				// Accelerate
				if spd < maxSpd {
					spd += 0.24;
				} else {
					spd = maxSpd;
				}
			} else {
				// Static speed for moving short distances
				spd = 0.75;
			}
			
			// Move to coordinate
			//move_towards_point(xNode[i],yNode[i],spd);
			speed = spd;
			direction = point_direction(x,y,xNode[i],yNode[i]);
		}
		
		if x > xNode[i]-speed && x < xNode[i]+speed && y > yNode[i]-speed && y < yNode[i]+speed {
			// Stop at coordinate
			x = xNode[i];
			y = yNode[i];
			
			xNode[i] = -1;
			yNode[i] = -1;
			
			//if endWalk[i] {
				speed = 0; // move_towards_point() sets a speed value
				spd = 0;
			//}
		}
	}
	
	// Rotate sprite
	/*rotFin = scr_rotateAngle(direction);
	rotDir = scr_rotateDirection(direction,dirIso,rotFin);
		
	if dirIso != rotFin {
		dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
	}
	spr = scr_spriteDir(dirIso);*/
	
	// Increment along timeline
	if trgRegion != -1 {
		while xNode[i] = -1 && yNode[i] = -1 && i < trgRegion.timeIndexCalc {
			i += 1; // Increment 1/10'th second for walking
		}
		/*while dialogueStr[i2] = -1 && i2 < trgRegion.timeIndexCalc {
			i2 += 1; // Increment 1/10'th second for talking
		}*/
	}
}

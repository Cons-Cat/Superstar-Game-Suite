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
	speed = 0;
	spd = 0;
	
	i = 0;
	moving = false;
	trgRegion = -1;
	dirIso = dirIsoDef;
	spr = scr_spriteDir(dirIso);
} else {
	// In play mode
	
	// Walking
	if xNode[i] != -1 && yNode[i] != -1 {
		moving = true;
		
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
			
			// Rotate towards direction
			if dir != -1 {
				if abs(angle_difference(dir,point_direction(x,y,xNode[i],yNode[i]))) > 20 {
					dir -= angle_difference(dir,point_direction(x,y,xNode[i],yNode[i]))/4.82;
				} else {
					dir = point_direction(x,y,xNode[i],yNode[i]);
				}
			} else {
				dir = point_direction(x,y,xNode[i],yNode[i]);
			}
			
			// Move to coordinate
			speed = spd;
			direction = dir;
			rotationInputDirection = floor(point_direction(x,y,xNode[i],yNode[i])/45)*45;
		}
		
		if x > xNode[i]-speed && x < xNode[i]+speed && y > yNode[i]-speed && y < yNode[i]+speed {
			// Stop at coordinate
			x = xNode[i];
			y = yNode[i];
			tempX = x;
			tempY = y;
			moving = false;
			
			xNode[i] = -1;
			yNode[i] = -1;
			
			if endWalk[i] {
				speed = 0; // move_towards_point() sets a speed value
				spd = 0;
			}
		}
		
		// Rotate sprite
		rotFin = scr_rotateAngle(rotationInputDirection);
		rotDir = scr_rotateDirection(rotationInputDirection,dirIso,rotFin);
	
		if dirIso != rotFin {
			dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
		}
	}
	
	// Rotating
	if angleRot[i] != -1 {
		rotFin = angleRot[i];
		rotDir = scr_rotateDirection(angleRot[i],dirIso,rotFin);
		
		if dirIso = rotFin {
			angleRot[i] = -1;
		} else {
			dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
		}
	}
	
	spr = scr_spriteDir(dirIso);
	
	// Increment along timeline
	if trgRegion != -1 {
		while xNode[i] = -1 && yNode[i] = -1 && angleRot[i] = -1 && i < trgRegion.timeIndexCalc {
			i += 1; // Increment 1/10'th second for walking
		}
		
		if spd = 0 || point_distance(tempX,tempY,xNode[i],yNode[i]) <= 10 {
			dir = -1;
		}
	}
}

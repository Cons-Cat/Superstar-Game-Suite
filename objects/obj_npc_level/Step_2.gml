/// @description 
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode != 2 {
		// Not in play mode
		if instance_exists(trg) {
			x = trg.x + 10;
			y = trg.y + 10;
			depth = trg.depth - 1;
		} else {
			instance_destroy();
		}
		
		direction = 270;
		speed = 0;
		
		i = 1;
		canIncrement = false;
		moving = false;
		xNode[i] = -1;
		yNode[i] = -1;
		dirIso = 4;
		spr = sprD;
	} else {
		// In play mode
		if xNode[i] != -1 && yNode[i] != -1 {
			if (x <= xNode[i]-spd || x >= xNode[i]+spd) || (y <= yNode[i]-spd || y >= yNode[i]+spd) {
				if point_distance(x,y,xNode[i],yNode[i]) <= 6 {
					// Decelerate
					if endWalk[i] {
						if spd > 0.2 {
							spd -= 0.325;
						} else {
							spd = 0.2;
						}
					}
				} else if point_distance(x,y,xNode[i],yNode[i]) > 6 {
					// Accelerate
					if spd < maxSpd {
						spd += 0.75;
					} else {
						spd = maxSpd;
					}
				} else {
					// Static speed for moving short distances
					spd = 1.5;
				}
				
				// Move to coordinate
				move_towards_point(xNode[i],yNode[i],spd);
				direction = point_direction(x,y,xNode[i],yNode[i]);
			}
			if x > xNode[i]-spd && x < xNode[i]+spd && y > yNode[i]-spd && y < yNode[i]+spd {
				// Stop at coordinate
				x = xNode[i];
				y = yNode[i];
				
				xNode[i] = -1;
				yNode[i] = -1;
				
				if endWalk[i] {
					speed = 0;
					spd = 0;
				}
				
				if i < trgRegion.timeIndex {
					i += 1;
				}
			}
		} else {
			if canIncrement {
				if i < trgRegion.timeIndex {
					i += 1;
				}
			}
		}
		
		// Rotate sprite
		rotFin = scr_rotateAngle(direction);
		rotDir = scr_rotateDirection(direction,dirIso,rotFin);
		
		if dirIso != rotFin {
			dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
		}
		spr = scr_spriteDir(dirIso);
	}
	
	// Adapting visibility to editor mode
	if obj_editor_gui.mode = 0 || obj_editor_gui.mode = 1 || obj_editor_gui.mode = 3 {
		visible = false;
	} else {
		visible = true;
	}
}

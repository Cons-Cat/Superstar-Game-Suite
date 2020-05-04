/// @description Insert description here
if instance_exists(obj_editor_gui) {
	if obj_editor_gui.mode != 2 {
		activeInScene = false;
	}
	
	// Trigger or play mode.
	if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 4 {
		visible = true;
	} else {
		visible = false;
	}
}

if !activeInScene {
	// Inactive
	#region
	
	if obj_editor_gui.mode != 2 {
		// Not in play mode
		if object_index != obj_player_overworld {
			// Not the player object
			if instance_exists(trg) {
				zfloor = trg.zfloor;
				x = trg.x + 10;
				y = trg.y + 10 + trg.zfloor*20;
				depth = trg.depth - 1;
				
				if depthPriority { depth -= 1; }
			} else {
				instance_destroy();
			}
			
			direction = 270;
			speed = 0;
			spd = 0;
			
			sceneStep = 0;
			moving = false;
			slowSpd = false;
			trgRegion = -1;
			dirIso = dirIsoDefault;
			spr = scr_spriteDir(dirIso);
		}
	}
	
	#endregion
} else {
	// Active
	
	// Walking
	if xNode[sceneStep] != -1 && yNode[sceneStep] != -1 {
		moving = true;
		
		if (x <= xNode[sceneStep]-speed || x >= xNode[sceneStep]+speed) || (y <= yNode[sceneStep]-speed || y >= yNode[sceneStep]+speed) {
			if point_distance(x,y,xNode[sceneStep],yNode[sceneStep]) <= 3 {
				// Decelerate
				if endWalk[sceneStep] {
					if spd > 0.1 {
						spd -= 0.165;
					} else {
						spd = 0.1;
					}
				}
			} else if point_distance(x,y,xNode[sceneStep],yNode[sceneStep]) > 3 {
				// Accelerate
				if spd < max_speed {
					spd += 0.24;
				} else {
					spd = max_speed;
				}
			} else {
				// Static speed for moving short distances
				spd = 0.75;
			}
			
			// Rotate towards direction
			if dir != -1 {
				if abs(angle_difference(dir,point_direction(x,y,xNode[sceneStep],yNode[sceneStep]))) > 20 {
					dir -= angle_difference(dir,point_direction(x,y,xNode[sceneStep],yNode[sceneStep]))/4.82;
				} else {
					dir = point_direction(x,y,xNode[sceneStep],yNode[sceneStep]);
				}
			} else {
				dir = point_direction(x,y,xNode[sceneStep],yNode[sceneStep]);
			}
			
			// Move to coordinate
			speed = spd;
			direction = dir;
			rotationInputDirection = floor(point_direction(x,y,xNode[sceneStep],yNode[sceneStep])/45)*45;
		}
		
		if x > xNode[sceneStep]-speed && x < xNode[sceneStep]+speed && y > yNode[sceneStep]-speed && y < yNode[sceneStep]+speed {
			// Stop at coordinate
			x = xNode[sceneStep];
			y = yNode[sceneStep];
			tempX = x;
			tempY = y;
			moving = false;
			
			xNode[sceneStep] = -1;
			yNode[sceneStep] = -1;
			
			if endWalk[sceneStep] {
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
	if angleRot[sceneStep] != -1 {
		rotFin = angleRot[sceneStep];
		rotDir = scr_rotateDirection(angleRot[sceneStep],dirIso,rotFin);
		
		if dirIso = rotFin {
			angleRot[sceneStep] = -1;
		} else {
			dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
		}
	}
	
	spr = scr_spriteDir(dirIso);
	
	// Arbitrary
	if arbitraryInd[sceneStep] != -1 {
		script_execute(scr_arbitrary,arbitraryInd[sceneStep]);
	}
	
	// Increment along timeline
	if trgRegion != -1 {
		while (xNode[sceneStep] = -1 && yNode[sceneStep] = -1 && angleRot[sceneStep] = -1 && arbitraryInd[sceneStep] = -1) {
			if sceneStep < sceneLength {
				sceneStep += 1; // Increment 1/10'th second for walking
			} else {
				activeInScene = false;
				break; // End scene
			}
		}
		
		obj_panel_bot.currentAction[rowOn] = sceneStep;
		
		if spd = 0 || point_distance(tempX,tempY,xNode[sceneStep],yNode[sceneStep]) <= 10 {
			dir = -1;
		}
	}
}

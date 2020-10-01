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
	
	phy_acceleration_imp = phy_acceleration
	phy_deceleration_imp = phy_deceleration
	
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
	#region
	
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
					dir -= angle_difference(dir,point_direction(x,y,xNode[sceneStep],yNode[sceneStep])) / 4.82;
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
	}
	
	// Finish rotation.
	if dirIso = rotFin {
		angleRot[sceneStep] = -1;
	}
	
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
	
	#endregion
}

// Maximum speed
if slowSpd { // Walking
	max_speed = phy_walkspeed; 
} else { // Running
	max_speed = phy_runspeed;
}

if obj_editor_gui.mode = 2 {
	
// Select a sprite and animate.
#region

rotFin = scr_rotateAngle(rotationInputDirection);
rotDir = scr_rotateDirection(rotationInputDirection,dirIso,rotFin);

if dirIso != rotFin {
	dirIso = scr_spriteRotateTowards(rotFin,rotDir,dirIso); // Update the angle towards the direction
}

spr = scr_spriteDir(dirIso);

if (abs(c_hspeed) + abs(c_vspeed))/2 != 0 && !jumping {
	// Walk animation
	if c_hspeed	= 0 && c_vspeed != 0 {
		imgIndex += abs(c_vspeed)/imgSpd;
	} else if c_hspeed != 0 && c_vspeed = 0 {
		imgIndex += abs(c_hspeed)/imgSpd;
	} else {
		imgIndex += (abs(c_hspeed) + abs(c_vspeed))/(imgSpd*2); // Average of absolute hspeed and vspeed
	}
	
	moving = true;
} else if jumping {
	if !jumpAnim {
		if imgIndex < 5 {
			imgIndex += 0.5;
		} else {
			jumpAnim = true;
		}
	} else {
		imgIndex = 5;
	}
} else {
	//Idle animation
	moving = false;
	imgIndex = 0;
}

#endregion

// Falling.
#region

if !jumping {
	jumpDelay = jumpDelayMax;
	
	// Earth-bound gravity
	if !keyboard_check(global.jumpInput) || glideDelay = 0 {
		if jumpHeight > platOn + jumpGrav/2 {
			falling = true;
			jumpHeight -= 0.25 + jumpGrav/2; // Comment out to disable gravity
			
			if jumpGrav < jumpGravMax {
				jumpGrav += jumpGravVal;
			} else {
				jumpGrav = jumpGravMax;
			}
		} else {
			if falling {
				falling = false;
				jumpHeight = platOn;
				jumpAnim = false;
			}
		}
	} else {
		glideDelay -= 1;
	}
}

#endregion

// Finding viable floor.
#region

fallSearch = true; // Fall down by default
falling = true;
trgFinalTemp = 0;

// Create array of viable landing spots
for (i = 0; i < instance_number(obj_floor); i += 1) {
	trgLayer[i] = -1;
	trgScr[i] = instance_find(obj_floor,i).id;
	
	if collision_circle(x, y, maskRadius, trgScr[i], true, false) {
		if trgScr[i].object_index = obj_staircase_collision {
			if trgScr[i].zcieling * 20 <= self.jumpHeight {
				if scr_collision_staircase_alt(trgScr[i]) {
					trgLayer[i] = trgScr[i].zfloor + 0.5; // Give priority to staircases.
				}
			}
		}
		else if trgScr[i].zfloor*20 <= self.jumpHeight {
			trgLayer[i] = trgScr[i].zfloor; // Spot is viable.
		}
	}
}

// Find the highest-elevated viable landing spot.
for (i = 0; i < instance_number(obj_floor); i += 1) {
	if trgLayer[i] != -1 { // Skip non-viable spots
		if trgLayer[i] >= trgFinalTemp { // If elevation is higher than previous recursions'.
			trgFinal = trgScr[i];
			trgFinalTemp = trgLayer[i];
		}
	}
}

zDisplace = 0;

if trgFinal.object_index = obj_staircase_collision {
	scr_collision_staircase_alt(trgFinal); // Sets zDisplace.
	platOn = trgFinal.zcieling*20 + zDisplace;
	onStaircase = true;
} else {
	platOn = trgFinal.zfloor*20;
	onStaircase = false;
}

#endregion

onGround = false;

if instance_exists(trgFinal) {
	if platOn = self.jumpHeight {
		onGround = true;
		isFalling = true; // Used for camera motion
		fallSearch = false; // Cancel fall if standing on a platform
	}
}

if fallSearch = true {
	jumpAnim = false;
}

// Update x,y coordinates
for (i = 0; i < subSteps; i++) {
	x += c_hspeed / subSteps;
	y += c_vspeed / subSteps;
	
	scr_collision_mask(maskRadius);
}

}

///@description Movement
event_inherited();

// Maximum speed
if slowSpd { // Walking
	//if max_speed > phy_walkspeed {
	max_speed = phy_walkspeed; //-= 0.1;
	/*} else {
		max_speed = phy_walkspeed;
		show_debug_message("walk");
	}*/
} else { // Running
	max_speed = phy_runspeed;
	/*
	if c_hspeed = max_speed {
		show_debug_message("run");
	}*/
}

if !activeInScene {

phy_acceleration_imp = phy_acceleration
phy_deceleration_imp = phy_deceleration

// Momentum
if canMove && (jumpDelay = jumpDelayMax || !onGround) {
	if keyboard_check(_left) && !keyboard_check(_right) {
		c_hspeed = max(c_hspeed - phy_acceleration_imp, -max_speed)
	}
	if keyboard_check(_right) && !keyboard_check(_left) {
		c_hspeed = min(c_hspeed+phy_acceleration_imp, max_speed)
	}
	if keyboard_check(_up) && !keyboard_check(_down) {
		c_vspeed = min(c_vspeed-phy_acceleration_imp, max_speed)
	}
	if keyboard_check(_down) && !keyboard_check(_up) {
		c_vspeed = min(c_vspeed+phy_acceleration_imp, max_speed)
	}
}

// Stopping
if jumpDelay = jumpDelayMax {
	if (!keyboard_check(_left) && !keyboard_check(_right)) && abs(c_hspeed) != 0 {
		if c_hspeed < 0 {
			c_hspeed = min(c_hspeed+phy_deceleration_imp,0);
		}
		if c_hspeed > 0 {
			c_hspeed = max(c_hspeed-phy_deceleration_imp,0);
		}
		
		jumpTempHspd = 0;
	}
	
	if (!keyboard_check(_up) && !keyboard_check(_down)) && abs(c_vspeed) != 0 {
		if c_vspeed < 0 {
			c_vspeed = min(c_vspeed+phy_deceleration_imp,0);
		}
		if c_vspeed > 0 {
			c_vspeed = max(c_vspeed-phy_deceleration_imp,0);
		}
		
		jumpTempVspd = 0;
	}
} else {
	// Decelerate while preparing to jump
	if onGround {
		if c_hspeed < 0 {
			c_hspeed = min(c_hspeed+phy_deceleration_imp/jumpPrepDecel,0);
		}
		if c_hspeed > 0 {
			c_hspeed = max(c_hspeed-phy_deceleration_imp/jumpPrepDecel,0);
		}
		if c_vspeed < 0 {
			c_vspeed = min(c_vspeed+phy_deceleration_imp/jumpPrepDecel,0);
		}
		if c_vspeed > 0 {
			c_vspeed = max(c_vspeed-phy_deceleration_imp/jumpPrepDecel,0);
		}
	}
}

if (keyboard_check(_up) || keyboard_check(_down)) && (keyboard_check(_left) || keyboard_check(_right)) {
	max_speed = phy_walkspeed - 0.015;
} else {
	max_speed = phy_walkspeed;
}

// Maximum speed thresholds
if c_hspeed > max_speed {
	c_hspeed = max_speed;
}
if c_hspeed < -max_speed {
	c_hspeed = -max_speed;
}
if c_vspeed > max_speed {
	c_vspeed = max_speed;
}
if c_vspeed < -max_speed {
	c_vspeed = -max_speed;
}

// Point towards input direction
#region

if moving {
	if keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = 0;
		jumpTempVspd = -max_speed-0.8;
		rotationInputDirection = 90;
	}
	if keyboard_check(_up) && keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.8;
		jumpTempVspd = -max_speed-0.8;
		rotationInputDirection = 45;
	}
	if !keyboard_check(_up) && keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.8;
		jumpTempVspd = 0;
		rotationInputDirection = 0;
	}
	if !keyboard_check(_up) && keyboard_check(_right) && keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.8;
		jumpTempVspd = max_speed+0.8;
		rotationInputDirection = 315;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = 0;
		jumpTempVspd = max_speed+0.8;
		rotationInputDirection = 270;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.8;
		jumpTempVspd = max_speed+0.8;
		rotationInputDirection = 225;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.8;
		jumpTempVspd = 0;
		rotationInputDirection = 180;
	}
	if keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.8;
		jumpTempVspd = -max_speed-0.8;
		rotationInputDirection = 135;
	}
}

#endregion

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

// Jumping.
#region

if canMove {
	if keyboard_check_pressed(_A) {
		// Initiating jump
		if onGround {
			jumpDelay = jumpDelayMax;
			jumpBoost = platOn;
			glideDelay = glideDelayMax;
			jumping = true;
			
			imgIndex = 0;
		}
	}
	
	if jumping {
		isFalling = false; // Used for camera motion
		
		if jumpDelay > 0 {
			if !fallSearch {
				// Pre-jump timer
				jumpDelay -= 0.75;
			} else {
				// Cancel pre-jump if moved off a platform
				jumping = false;
			}
		} else {
			if jumpDelay != -1 {
				// Boost forward in the direction set leaping
				c_hspeed = jumpTempHspd;
				c_vspeed = jumpTempVspd;
			}
			
			// Rising skyward
			if jumpHeight < maxJumpHeight + jumpBoost {
				jumpHeight += jumpSpeed;
				jumpGrav = 0.5;
			} else {
				jumpHeight += jumpSpeed / jumpGrav;
				
				if floor(jumpSpeed / jumpGrav) = 0 {
					jumping = false;
				}
				
				if jumpGrav < jumpGravMax {
					jumpGrav += jumpGravVal;
				} else {
					jumpGrav = 0;
					jumpGrav = jumpGravMax;
				}
			}
		}
	}
}

#endregion

// Falling.
#region

if !jumping {
	jumpDelay = jumpDelayMax;
	
	// Earth-bound gravity
	if !keyboard_check(_A) || glideDelay = 0 {
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
		
		//depth = obj_editor_gui.depth - (trgFinal.y + 20) - trgFinal.zfloor - 3;
		depth = obj_editor_gui.depth - trgFinal.y - 20 - trgFinal.zfloor - 3;
	}
}

// Override depth algorithm.
if onStaircase {
	depth = trgFinal.depth - 1;
}

if fallSearch = true {
	jumpAnim = false;
}

// Update x,y coordinates
subSteps = 2;

for (i = 0; i < subSteps; i++) {
	x += c_hspeed / subSteps;
	y += c_vspeed / subSteps;
	
	scr_collision_mask(maskRadius);
}

}

///@description Movement
phy_acceleration_imp = phy_acceleration
phy_deceleration_imp = phy_deceleration

// Momentum
if canMove && (jumpDelay = jumpDelayMax || !onGround) {
	if keyboard_check(_left) && !keyboard_check(_right) {
		c_hspeed = max(c_hspeed-phy_acceleration_imp, -max_speed)
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
	max_speed = phy_walkspeed - 0.03;
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
if moving {
	if keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = 0;
		jumpTempVspd = -max_speed-0.16;
		rotationInputDirection = 90;
	}
	if keyboard_check(_up) && keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.16;
		jumpTempVspd = -max_speed-0.16;
		rotationInputDirection = 45;
	}
	if !keyboard_check(_up) && keyboard_check(_right) && !keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.16;
		jumpTempVspd = 0;
		rotationInputDirection = 0;
	}
	if !keyboard_check(_up) && keyboard_check(_right) && keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = max_speed+0.16;
		jumpTempVspd = max_speed+0.16;
		rotationInputDirection = 315;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && keyboard_check(_down) && !keyboard_check(_left) {
		jumpTempHspd = 0;
		jumpTempVspd = max_speed+0.16;
		rotationInputDirection = 270;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.16;
		jumpTempVspd = max_speed+0.16;
		rotationInputDirection = 225;
	}
	if !keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.16;
		jumpTempVspd = 0;
		rotationInputDirection = 180;
	}
	if keyboard_check(_up) && !keyboard_check(_right) && !keyboard_check(_down) && keyboard_check(_left) {
		jumpTempHspd = -max_speed-0.16;
		jumpTempVspd = -max_speed-0.16;
		rotationInputDirection = 135;
	}
}

// Select the sprite
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
			imgIndex += 1;
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

// Jumping
if canMove {
	if keyboard_check_pressed(_A) {
		// Initiating jump
		if jumpHeight = platOn {
			jumpDelay = jumpDelayMax;
			jumpBoost = platOn;
			glideDelay = glideDelayMax;
			jumping = true;
			onGround = false;
			
			imgIndex = 0;
		}
	}
	if jumping {
		if jumpDelay > 0 {
			if !fallSearch {
				// Pre-jump timer
				jumpDelay -= 1;
			} else {
				// Cancel pre-jump if moved off a platform
				jumping = false;
			}
		} else {
			if jumpDelay != -1 {
				// Boost forward in the direction set leaping
				onGround = false;
				c_hspeed = jumpTempHspd;
				c_vspeed = jumpTempVspd;
				//jumpDelay = -1;
			}
			
			// Rising skyward
			if jumpHeight < maxJumpHeight + jumpBoost {
				jumpHeight += jumpSpeed;
				jumpGrav = 1;
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
if !jumping {
	jumpDelay = jumpDelayMax;
	// Earth-bound gravity
	if !keyboard_check(_A) || glideDelay = 0 {
		if !boosting {
			if jumpHeight > platOn + jumpGrav/2 {
				jumpHeight -= 0.5 + jumpGrav/2;
				
				if jumpGrav < jumpGravMax {
					jumpGrav += jumpGravVal;
				} else {
					jumpGrav = jumpGravMax;
				}
			} else {
				jumpHeight = platOn;
				jumpAnim = false;
			}
		}
	} else {
		if !boosting {
			glideDelay -= 1;
		}
	}
}

zplace = floor((jumpHeight/20));

// Checking to fall off of platforms
fallSearch = true; // Fall down by default

// Find relevant floor object
trgFinalTemp = 0;
for (i = 0; i < instance_number(obj_floor); i += 1) {
	trgScr = instance_find(obj_floor,i).id;
	if trgScr.zfloor*20 <= self.jumpHeight {
		if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,trgScr,true,true) {
			trgLayer[i] = trgScr.zfloor;
			for (a = 0; a <= i; a += 1) {
				if trgLayer[a] >= trgFinalTemp {
					trgFinal = trgScr;
					trgFinalTemp = trgLayer[a];
				}
			}
			platOn = trgFinal.zfloor*20;
		}
	}
}

if trgFinal.zfloor = self.zplace {
	fallSearch = false; // Cancel fall if standing on a platform
	onGround = true;
	floorA = trgFinal.zfloor;
	
	depth = -(trgFinal.y + 20) - trgFinal.zfloor - 3 - trgFinal.depthOffset/3;
}

if fallSearch = true {
	jumpAnim = false;
}

// Update x,y coordinates
scr_cmove_step(1,0);

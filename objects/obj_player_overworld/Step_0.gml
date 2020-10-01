///@description Movement

if !activeInScene {
	// Momentum
	#region

	if canMove && (jumpDelay = jumpDelayMax || !onGround) {
		if keyboard_check(global.leftInput) && !keyboard_check(global.rightInput) {
			c_hspeed = max(c_hspeed - phy_acceleration_imp, -max_speed)
		}
		if keyboard_check(global.rightInput) && !keyboard_check(global.leftInput) {
			c_hspeed = min(c_hspeed+phy_acceleration_imp, max_speed)
		}
		if keyboard_check(global.upInput) && !keyboard_check(global.downInput) {
			c_vspeed = min(c_vspeed-phy_acceleration_imp, max_speed)
		}
		if keyboard_check(global.downInput) && !keyboard_check(global.upInput) {
			c_vspeed = min(c_vspeed+phy_acceleration_imp, max_speed)
		}
	}

	// Stopping
	if jumpDelay = jumpDelayMax {
		if (!keyboard_check(global.leftInput) && !keyboard_check(global.rightInput)) && abs(c_hspeed) != 0 {
			if c_hspeed < 0 {
				c_hspeed = min(c_hspeed+phy_deceleration_imp,0);
			}
			if c_hspeed > 0 {
				c_hspeed = max(c_hspeed-phy_deceleration_imp,0);
			}
		
			jumpTempHspd = 0;
		}
	
		if (!keyboard_check(global.upInput) && !keyboard_check(global.downInput)) && abs(c_vspeed) != 0 {
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

	if (keyboard_check(global.upInput) || keyboard_check(global.downInput)) && (keyboard_check(global.leftInput) || keyboard_check(global.rightInput)) {
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

	#endregion

	// Point towards input direction
	#region

	if moving {
		if keyboard_check(global.upInput) && !keyboard_check(global.rightInput) && !keyboard_check(global.downInput) && !keyboard_check(global.leftInput) {
			jumpTempHspd = 0;
			jumpTempVspd = -max_speed-0.8;
			rotationInputDirection = 90;
		}
		if keyboard_check(global.upInput) && keyboard_check(global.rightInput) && !keyboard_check(global.downInput) && !keyboard_check(global.leftInput) {
			jumpTempHspd = max_speed+0.8;
			jumpTempVspd = -max_speed-0.8;
			rotationInputDirection = 45;
		}
		if !keyboard_check(global.upInput) && keyboard_check(global.rightInput) && !keyboard_check(global.downInput) && !keyboard_check(global.leftInput) {
			jumpTempHspd = max_speed+0.8;
			jumpTempVspd = 0;
			rotationInputDirection = 0;
		}
		if !keyboard_check(global.upInput) && keyboard_check(global.rightInput) && keyboard_check(global.downInput) && !keyboard_check(global.leftInput) {
			jumpTempHspd = max_speed+0.8;
			jumpTempVspd = max_speed+0.8;
			rotationInputDirection = 315;
		}
		if !keyboard_check(global.upInput) && !keyboard_check(global.rightInput) && keyboard_check(global.downInput) && !keyboard_check(global.leftInput) {
			jumpTempHspd = 0;
			jumpTempVspd = max_speed+0.8;
			rotationInputDirection = 270;
		}
		if !keyboard_check(global.upInput) && !keyboard_check(global.rightInput) && keyboard_check(global.downInput) && keyboard_check(global.leftInput) {
			jumpTempHspd = -max_speed-0.8;
			jumpTempVspd = max_speed+0.8;
			rotationInputDirection = 225;
		}
		if !keyboard_check(global.upInput) && !keyboard_check(global.rightInput) && !keyboard_check(global.downInput) && keyboard_check(global.leftInput) {
			jumpTempHspd = -max_speed-0.8;
			jumpTempVspd = 0;
			rotationInputDirection = 180;
		}
		if keyboard_check(global.upInput) && !keyboard_check(global.rightInput) && !keyboard_check(global.downInput) && keyboard_check(global.leftInput) {
			jumpTempHspd = -max_speed-0.8;
			jumpTempVspd = -max_speed-0.8;
			rotationInputDirection = 135;
		}
	}

	#endregion

	// Jumping.
	#region

	if canMove {
		if keyboard_check_pressed(global.jumpInput) {
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
}

event_inherited();

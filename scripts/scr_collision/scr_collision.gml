var colNorth = false;
var colSouth = false;
var colWest = false;
var colEast = false;
var trgScr;

var slopeOffset;
var j;
var run;
var rise;

repeat(2) {
	// Staircase collision
	if collision_rectangle(floor(x),floor(y),floor(x+1),floor(y+1),obj_staircase_collision,true,false) {
		if !onStaircase {
			onStaircase = true; // Used to over ride depth algorithm
			staircaseId = collision_rectangle(floor(x),floor(y),floor(x+1),floor(y+1),obj_staircase_collision,true,false);
			slopeOriginOffsetX = staircaseId.slopeOriginOffsetX;
			slopeOriginOffsetY = staircaseId.slopeOriginOffsetY;
			
			if staircaseId.staircaseRotation = 0 || staircaseId.staircaseRotation = 2 {
				// Sideways staircase exception
				iterateLengthTemp = staircaseId.iterateLength - staircaseId.widthIterateCollisionOff + 1;
			} else if staircaseId.staircaseRotation = 1 || staircaseId.staircaseRotation = 6 {
				// Vertical staircase exception
				iterateLengthTemp = staircaseId.iterateLength - staircaseId.widthIterateCollisionOff + 2;
			} else if staircaseId.staircaseRotation = 5 {
				iterateLengthTemp = staircaseId.iterateLength - staircaseId.widthIterateCollisionOff - 1;
			} else {
				iterateLengthTemp = staircaseId.iterateLength - staircaseId.widthIterateCollisionOff;
			}
			
			for (var i = -1; i <= iterateLengthTemp * 20; i += 1) {
				run  = staircaseId.collisionMaskRun;
				rise = staircaseId.collisionMaskRise;
				//j = i*rise + 3;
				
				if staircaseId.staircaseRotation = 0 || staircaseId.staircaseRotation = 2 {
					// Sideways staircase
					var j = 1;
				} else if staircaseId.staircaseRotation = 1 {
					// Vertical staircase
					var j = 0;
				} else {
					var j = i*rise + 3;
				}
				
				for (var ii = 0; ii <= 1; ii += 1) {
					for (var jj = 0; jj <= 1; jj += 1) {
						// There must be four horizontally and/or vertically adjacent rays to precisely encompass the entire area
						if staircaseId.staircaseRotation = 0 || staircaseId.staircaseRotation = 2 {
							// Sideways staircase
							if collision_line(slopeOriginOffsetX - ii,slopeOriginOffsetY - j - i*rise + jj,slopeOriginOffsetX + 1 + staircaseId.rayXComponent - ii,slopeOriginOffsetY - j - i*rise + jj,obj_staircasecollision_mask,true,false) {
								// Iterating, across the tall edge of the staircase, a raycast aiming down the staircase
								actorXOrigin = staircaseId.slopeOriginOffsetX + staircaseId.rayXComponent - ii;
								actorYOrigin = self.y;
								
								break;
							}
						} else {
							if collision_line(slopeOriginOffsetX + i*run - ii,slopeOriginOffsetY - j + jj,slopeOriginOffsetX + i*run + 1 + staircaseId.rayXComponent - ii,slopeOriginOffsetY - j + staircaseId.rayYComponent + jj,obj_staircasecollision_mask,true,false) {
								// Iterating, across the tall edge of the staircase, a raycast aiming down the staircase
								actorXOrigin = staircaseId.slopeOriginOffsetX + i*run  + staircaseId.rayXComponent - ii;
								actorYOrigin = staircaseId.slopeOriginOffsetY - i*rise + staircaseId.rayYComponent - jj;
								
								break;
							}
						}
					}
				}
			}
		}
	} else {
		onStaircase = false;
	}
	
	if onStaircase {
		jumpHeight = staircaseId.zfloor*20 + (actorXOrigin - self.x)*staircaseId.staircaseRun + (actorYOrigin - self.y)*staircaseId.staircaseRise;
	} else {
		for (var i = 0; i < instance_number(obj_solid); i += 1) {
			trgScr = instance_find(obj_solid,i).id;
			if (trgScr.zheight*20 > self.jumpHeight && trgScr.zcieling*20 <= self.jumpHeight) || !(trgScr.finite) {
				// Checking for negative y collision at current z coordinate
				if collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,trgScr,false,true) {
					colNorth = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,trgScr,false,true);
				}
				// Checking for positive y collision at current z coordinate
				if collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,trgScr,false,true) {
					colSouth = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,trgScr,false,true);
				}
			}
		}
		for (var i = 0; i < instance_number(obj_solid_side); i += 1) {
			trgScr = instance_find(obj_solid_side,i).id;
			if (trgScr.zheight*20 > self.jumpHeight && trgScr.zcieling*20 <= self.jumpHeight) || !(trgScr.finite) {
				// Checking for negative x collision at current z coordinate
				if collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-4,trgScr,false,true) {
					colWest = collision_rectangle(bbox_left-1,bbox_top,bbox_left,bbox_bottom-4,trgScr,false,true);
				}
			
				// Checking for positive x collision at current z coordinate
				if collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-4,trgScr,false,true) {
					colEast = collision_rectangle(bbox_right+1,bbox_top,bbox_right,bbox_bottom-4,trgScr,false,true);
				}
			}
		}
	
	  //---Solids---
	  if colNorth
	  {
	    if add_y <= 0
	    add_y = 0;
	    if c_vspeed <= 0
	    c_vspeed = 0
   
	    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_top,colNorth,false,true) {
	        y += 1;
	    }
	  }
   
	  if colSouth
	  {
	    if add_y >= 0 {
		    add_y = 0;
		}
	    if c_vspeed >= 0 {
			c_vspeed = 0;
		}
   
	    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,colSouth,false,true) {
		    y -= 1;
		}
	  }
   
	  if colWest
	  {
	    if add_x <= 0
	    add_x = 0;
	    if c_hspeed <= 0
	    c_hspeed = 0
   
	    if collision_rectangle(bbox_left,bbox_top,bbox_left,bbox_bottom,colWest,false,true) {
	        x += 1;
	    }
	  }
   
	  if colEast
	  {
	    if add_x >= 0
	    add_x = 0;
	    if c_hspeed >= 0
	    c_hspeed = 0
   
	    if collision_rectangle(bbox_right,bbox_top,bbox_right,bbox_bottom,colEast,false,true) {
	        x -= 1;
	    }
	  }
  
		// Unflipped Slopes
		repeat(abs(c_hspeed)) {
			// Vertical slopes displacement
			if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false) {
				if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false).slopeOffset;
				
					if c_hspeed < 0 {
						y -= c_hspeed / slopeOffset;
					}
				}
			}
			if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false) {
				if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false).slopeOffset;
				
					if c_hspeed > 0 {
						y += c_hspeed / slopeOffset;
					}
				}
			}
		}
		repeat(abs(c_vspeed)) {
			// Horizontal slopes displacement
			if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false) {
				if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_bot,true,false).slopeOffset;
				
					if c_vspeed < 0 {
						x -= c_vspeed * slopeOffset;
					}
				}
			}
			if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false) {
				if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_bot,true,false).slopeOffset;
				
					if c_vspeed < 0 {
						x += c_vspeed * slopeOffset;
					}
				}
			}
		}
	
		// Flipped Slopes
		repeat(abs(c_hspeed)) {
			// Vertical slopes displacement
			if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false) {
				if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false).slopeOffset;
				
					if c_hspeed < 0 {
						y += c_hspeed / slopeOffset;
					}
				}
			}
			if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false) {
				if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false).slopeOffset;
				
					if c_hspeed > 0 {
						y -= c_hspeed / slopeOffset;
					}
				}
			}
		}
		repeat(abs(c_vspeed)) {
			// Horizontal slopes displacement
			if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false) {
				if collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,obj_slopeL_top,true,false).slopeOffset;
				
					if c_vspeed > 0 {
						x += c_vspeed * slopeOffset;
					}
				}
			}
			if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false) {
				if collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false).zplace*20 > self.jumpHeight {
					slopeOffset = collision_rectangle(bbox_left-1,bbox_top,bbox_right,bbox_bottom-1,obj_slopeR_top,true,false).slopeOffset;
				
					if c_vspeed > 0 {
						x -= c_vspeed * slopeOffset;
					}
				}
			}
		}
	}
}


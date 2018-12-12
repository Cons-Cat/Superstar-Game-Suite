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
			widthIterate = staircaseId.widthIterate;
			widthIterateCollisionOff = staircaseId.widthIterateCollisionOff;
			slopeOriginOffsetX = staircaseId.slopeOriginOffsetX;
			slopeOriginOffsetY = staircaseId.slopeOriginOffsetY;
			
			for (var i = -1; i <= (widthIterate - widthIterateCollisionOff - 2) * 20; i += 1) {
				rise = staircaseId.collisionMaskRise;
				run  = staircaseId.collisionMaskRun;
				j = i*rise + 3;
				
				for (var ii = 0; ii <= 1; ii += 1) {
					for (var jj = 0; jj <= 1; jj += 1) {
						// There must be four horizontally and/or vertically adjacent rays to precisely encompass the entire area
						if collision_line(slopeOriginOffsetX + i*run - ii,slopeOriginOffsetY - j + jj,slopeOriginOffsetX + i*run + - ii + 1 + staircaseId.rayXComponent,slopeOriginOffsetY - j + staircaseId.rayYComponent + jj,obj_staircasecollision_mask,true,false) {
							// Iterating, across the tall edge of the staircase, a raycast aiming down the staircase
							staircaseXOrigin = staircaseId.slopeOriginOffsetX + i*run + staircaseId.rayXComponent - ii;
							staircaseYOrigin = staircaseId.slopeOriginOffsetY - i*rise + staircaseId.rayYComponent;
						
							break;
						}
					}
				}
			}
		}
	} else {
		onStaircase = false;
	}
	
	if onStaircase {
		jumpHeight = staircaseId.zfloor*20 + (staircaseXOrigin - self.x)*staircaseId.staircaseRun + (staircaseYOrigin - self.y)*staircaseId.staircaseRise;
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


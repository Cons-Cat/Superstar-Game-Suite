var currentsolid_up = false;
var currentsolid_down = false;
var currentsolid_left = false;
var currentsolid_right = false;
var trgScr;
var slopeOffset;

repeat(2) {
	for (var i = 0; i < instance_number(obj_solid); i += 1) {
		trgScr = instance_find(obj_solid,i).id;
		if (trgScr.zheight*20 > self.jumpHeight && trgScr.zcieling*20 <= self.jumpHeight) || !(trgScr.finite) {
			// Checking for negative y collision at current z coordinate
			if collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,trgScr,false,true) {
				currentsolid_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,trgScr,false,true);
			}
			// Checking for positive y collision at current z coordinate
			if collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,trgScr,false,true) {
				currentsolid_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,trgScr,false,true);
			}
		}
	}
	for (var i = 0; i < instance_number(obj_solid_side); i += 1) {
		trgScr = instance_find(obj_solid_side,i).id;
		if (trgScr.zheight*20 > self.jumpHeight && trgScr.zcieling*20 <= self.jumpHeight) || !(trgScr.finite) {
			// Checking for negative x collision at current z coordinate
			if collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-4,trgScr,false,true) {
				currentsolid_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left,bbox_bottom-4,trgScr,false,true);
			}
			
			// Checking for positive x collision at current z coordinate
			if collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-4,trgScr,false,true) {
				currentsolid_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right,bbox_bottom-4,trgScr,false,true);
			}
		}
	}
	
  //---Solids---
  if currentsolid_up
  {
    if add_y <= 0
    add_y = 0;
    if c_vspeed <= 0
    c_vspeed = 0
   
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_top,currentsolid_up,false,true) {
        y += 1;
    }
  }
   
  if currentsolid_down
  {
    if add_y >= 0{
	    add_y = 0;
	}
    if c_vspeed >= 0{
		c_vspeed = 0;
	}
   
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,currentsolid_down,false,true) {
	    y -= 1;
	}
  }
   
  if currentsolid_left
  {
    if add_x <= 0
    add_x = 0;
    if c_hspeed <= 0
    c_hspeed = 0
   
    if collision_rectangle(bbox_left,bbox_top,bbox_left,bbox_bottom,currentsolid_left,false,true) {
        x += 1;
    }
  }
   
  if currentsolid_right
  {
    if add_x >= 0
    add_x = 0;
    if c_hspeed >= 0
    c_hspeed = 0
   
    if collision_rectangle(bbox_right,bbox_top,bbox_right,bbox_bottom,currentsolid_right,false,true) {
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

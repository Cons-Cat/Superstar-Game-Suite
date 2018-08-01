///Lucy Jump Attack
var jumpAttY = argument[0].y;
var jumpAttX = argument[0].x;
var jumpAttHSPD = (jumpAttX - self.x) / 33;
var jumpAttJumpSPD = -9.2;
var jumpAttJumpGrav = 0.45;

if jumpAttState = 0{
	if self.y < jumpAttY{
		var jumpAttYArrange = false;
	} else {
		var jumpAttYArrange = true;
	}

	if jumpAttState = 0{
		if self.x < room_width/2-24{ //Horizontal movement
			x += jumpAttHSPD;
		} else {
			x = room_width/2-24;
			jumpAttState = 1;
		}
	}

	if jumpAttYArrange = false{ //If target is lower
		if self.y < jumpAttY{
			y += 1.4;
		} else {
			y = jumpAttY;
		}
	}

	if jumpAttYArrange = true{ //If target is higher
		if self.y > jumpAttY{
			y -= 1.4;
		} else {
			y = jumpAttY;
		}
	}
}

if jumpAttState = 1{ //Prepare to Jump
	if jumpAttTime > 0{
		jumpAttTime -= 1;
	} else {
		jumpAttJumpPlaceX = self.x;
		jumpAttJumpPlaceY = self.y;
		jumpAttJumpPlaceY2 = jumpAttJumpPlaceY;
		
		jumpAttState = 2;
	}
}

if jumpAttState = 2{ //Start Jumping
	if jumpAttJumped = 0{
		vspeed = jumpAttJumpSPD;
		gravity = jumpAttJumpGrav;
		jumpAttJumped = 1;
	}
	
	if x < argument[0].x{
		hspeed = arc_calc_xspeed(jumpAttJumpSPD, jumpAttJumpGrav, (jumpAttJumpPlaceX-self.x)/140, jumpAttJumpPlaceY,argument[0].x+16,argument[0].y-64);

		if x < argument[0].x - (argument[0].x-jumpAttJumpPlaceX)/24{
			hspeed += jumpAttJumpPlaceX/argument[0].x*1.0;
		} else {	
			hspeed -= jumpAttJumpPlaceX/argument[0].x*10;
		}
		
	} else {
		x = argument[0].x;
		hspeed = 0;
	}
	
	//Land #1 on target
	if collision_rectangle(bbox_left,bbox_bottom+vspeed,bbox_right,bbox_bottom,argument[0],false,false){
		jumpAttState = 3;
		jumpAttTime = 2;
		
		y = argument[0].bbox_top;
		vspeed = 0;
		gravity = 0;
	}
}

if jumpAttState = 3{
	if jumpAttTime > 0{
		jumpAttTime -= 1;
		if keyboard_check_pressed(ord("X")){
			jumpAttKey = true;
		}
	} else {
		if jumpAttKey = true{
			jumpAttState = 3.5;
			jumpAttKey = false;
			jumpAttTime = 3;
		} else {
			jumpAttState = 6.5;
			jumpAttKey = false;
			jumpAttTime = 4;
		
			vspeed = jumpAttJumpSPD/2.5;
			hspeed = -2;
			gravity = jumpAttJumpGrav;
		}
	}
}

if jumpAttState = 3.5{
	if jumpAttTime > 0{
		jumpAttTime -= 1;
	} else {
		jumpAttState = 4;
		vspeed = jumpAttJumpSPD;
	}
}

if jumpAttState = 4{
	gravity = jumpAttJumpGrav;
	
	//Land #2 on target
	if collision_rectangle(bbox_left,bbox_bottom+vspeed,bbox_right,bbox_bottom,argument[0],false,false) && vspeed > 0{
		jumpAttState = 5;
		jumpAttTime = 2;
		jumpAttJumpPlaceX = self.x;
		jumpAttJumpPlaceY = self.y;
		
		y = argument[0].bbox_top;
		vspeed = 0;
		gravity = 0;
	}
}

if jumpAttState = 5{ //Bounce off of target
	if jumpAttTime > 0{
		jumpAttTime -= 1;
		if keyboard_check_pressed(ord("X")){
			jumpAttKey = true;
		}
	} else {
		if jumpAttKey = true{
			jumpAttState = 5.5;
			jumpAttKey = false;
			jumpAttTime = 3;
			
			vspeed = 0;
			gravity = 0;
		} else {
			jumpAttState = 6.5;
			jumpAttKey = false;
			jumpAttTime = 4;
			
			vspeed = jumpAttJumpSPD/2.5;
			hspeed = -2;
			gravity = jumpAttJumpGrav;
		}
	}
}

if jumpAttState = 5.5{
	if jumpAttTime > 0{
		jumpAttTime -= 1;
	} else {
		jumpAttState = 4;
		jumpAttState = 6;
		
		vspeed = jumpAttJumpSPD/2;
		hspeed = -2;
		gravity = jumpAttJumpGrav;
	}
}

if jumpAttState = 6{ //Land on ground
	if y > jumpAttJumpPlaceY2 - vspeed{
		y = jumpAttJumpPlaceY2;
		hspeed = -4//-jumpAttHSPD;
		vspeed = 0;
		gravity = 0;
		image_xscale = -1;
		
		if y > ystart{
			jumpAttYArrange2 = 1;
		} else if y < ystart{
			jumpAttYArrange2 = 0;
		} else {
			jumpAttYArrange2 = -1; //No vertical displacement
		}
		
		jumpAttState = 7;
	}
}

if jumpAttState = 6.5{ //Land on ground after missing attack
	if y > jumpAttJumpPlaceY2 - vspeed{
		y = jumpAttJumpPlaceY2;
		hspeed = 0;
		vspeed = 0;
		gravity = 0;
		
		if y > ystart{
			jumpAttYArrange2 = 1;
		} else if y < ystart{
			jumpAttYArrange2 = 0;
		} else {
			jumpAttYArrange2 = -1; //No vertical displacement
		}
		
		if jumpAttTime > 0{
			jumpAttState -= 1;
		} else {
			jumpAttState = 7;
		}
	}
}

//Return to starting position and end turn
if jumpAttState = 7{
	if jumpAttYArrange2 = 0{ //If target is lower
		if self.y < ystart{
			y += 1.4;
		} else {
			y = ystart;
		}
	}
	if jumpAttYArrange2 = 1{ //If target is lower
		if self.y > ystart{
			y -= 1.4;
		} else {
			y = ystart;
		}
	}
	
	if x < xstart - hspeed{
		hspeed = 0;
		x = xstart;
		image_xscale = 1;
		jumpAttState = 8;
		
		obj_battle_control.turn += 1;
	} else {
		image_xscale = -1;
	}
}

/// @description 
if spawn = 0{
	x = obj_lucyblockspawn.x + blockx[space];
	y = obj_lucyblockspawn.x + blocky[space];
	spawn = 1;
}

//Raising
/*if !keyboard_check(vk_right) && !keyboard_check(vk_left) && event = false{
	if space = 8{
		if raise < 12{
			raise += 4.5;
		} else {
			raise = 14;
		}
	}
}
if space != 8 || event = true{
	if raise > 2{
		raise -= 3;
	} else {
		raise = 0;
	}
}*/

//Clamp spaces
if space < 0{
	space = 8;
}
if space > 8{
	space = 0;
}

if spaceTemp != space{
	if distance_to_point(obj_lucyblockspawn.x + blockx[space],obj_lucyblockspawn.y + blocky[space]) > 1{
		move_towards_point(obj_lucyblockspawn.x + blockx[space],obj_lucyblockspawn.y + blocky[space],spd);
	} else {
		spaceTemp = space;
		moving = false;
		speed = 0;
		x = obj_lucyblockspawn.x + blockx[space];
		y = obj_lucyblockspawn.y + blocky[space];
	}
}

if keyboard_check_pressed(_select){ //If player hits select button
	if space = 8{ //If block is in select position
		//if raise = 14{ //If block is fully raised
			event = true; //Activate block effect
		//}
	}
}
if keyboard_check_pressed(_back){
	if instance_exists(obj_target){
		self.event = false;
		
		with obj_target{
			instance_destroy();
		}
	}
}

depth = -y;

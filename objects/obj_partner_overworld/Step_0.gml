/// @description Trail behind player

//Follow target
if obj_player_overworld.dirIso = 0 {
	if distance_to_point(obj_player_overworld.x,obj_player_overworld.y+dist) > 1 {
		move_towards_point(obj_player_overworld.x,obj_player_overworld.y+dist,spd);
	} else {
		x = obj_player_overworld.x;
		y = obj_player_overworld.y+dist;
		speed = 0;
		direction = 90;
	}
}
if obj_player_overworld.dirIso = 1 {
	if distance_to_point(obj_player_overworld.x-dist,obj_player_overworld.y+dist) > 1 {
		move_towards_point(obj_player_overworld.x-dist,obj_player_overworld.y+dist,spd);
	} else {
		x = obj_player_overworld.x-dist;
		y = obj_player_overworld.y+dist;
		speed = 0;
		direction = 45;
	}
}
if obj_player_overworld.dirIso = 2 {
	if distance_to_point(obj_player_overworld.x-dist,obj_player_overworld.y) > 1 {
		move_towards_point(obj_player_overworld.x-dist,obj_player_overworld.y,spd);
	} else {
		x = obj_player_overworld.x-dist;
		y = obj_player_overworld.y;
		speed = 0;
		direction = 0;
	}
}
if obj_player_overworld.dirIso = 3 {
	if distance_to_point(obj_player_overworld.x-dist,obj_player_overworld.y-dist) > 1 {
		move_towards_point(obj_player_overworld.x-dist,obj_player_overworld.y-dist,spd);
	} else {
		x = obj_player_overworld.x-dist;
		y = obj_player_overworld.y-dist;
		speed = 0;
		direction = 315;
	}
}
if obj_player_overworld.dirIso = 4 {
	if distance_to_point(obj_player_overworld.x,obj_player_overworld.y-dist) > 1 {
		move_towards_point(obj_player_overworld.x,obj_player_overworld.y-dist,spd);
	} else {
		x = obj_player_overworld.x;
		y = obj_player_overworld.y-dist;
		speed = 0;
		direction = 270;
	}
}
if obj_player_overworld.dirIso = 5 {
	if distance_to_point(obj_player_overworld.x+dist,obj_player_overworld.y-dist) > 1 {
		move_towards_point(obj_player_overworld.x+dist,obj_player_overworld.y-dist,spd);
	} else {
		x = obj_player_overworld.x+dist;
		y = obj_player_overworld.y-dist;
		speed = 0;
		direction = 225;
	}
}
if obj_player_overworld.dirIso = 6 {
	if distance_to_point(obj_player_overworld.x+dist,obj_player_overworld.y) > 1 {
		move_towards_point(obj_player_overworld.x+dist,obj_player_overworld.y,spd);
	} else {
		x = obj_player_overworld.x+dist;
		y = obj_player_overworld.y;
		speed = 0;
		direction = 180;
	}
}
if obj_player_overworld.dirIso = 7 {
	if distance_to_point(obj_player_overworld.x+dist,obj_player_overworld.y+dist) > 1 {
		move_towards_point(obj_player_overworld.x+dist,obj_player_overworld.y+dist,spd);
	} else {
		x = obj_player_overworld.x+dist;
		y = obj_player_overworld.y+dist;
		speed = 0;
		direction = 135;
	}
}

//Angle
if direction > 68 && direction < 113 {
	//Up
	spr = sprU;
	image_xscale = 1;
}
if direction < 68 && direction > 23{
	//UpRight
	spr = sprUR;
	image_xscale = 1;
}
if direction < 23 || direction > 338{
	//Right
	spr = sprR;
	image_xscale = 1;
}
if direction < 338 && direction > 293{
	//DownRight
	spr = sprDR;
	image_xscale = 1;
}
if direction < 293 && direction > 248{
	//Down
	spr = sprD;
	image_xscale = 1;
}
if direction < 248 && direction > 203{
	//DownLeft
	spr = sprDR;
	image_xscale = -1;
}
if direction < 203 && direction > 158{
	//Left
	spr = sprR;
	image_xscale = -1;
}
if direction < 158 && direction > 112{
	//UpLeft
	spr = sprUR;
	image_xscale = -1;
}

//Depth
depth = -y;

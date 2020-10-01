function scr_collision_mask() {
	var radius = argument[0];
	var collAngle = scr_collision_normal(x, y, radius, 3);

	if collAngle != -1 {
		if (c_hspeed != 0 || c_vspeed != 0) {
		    move_outside_solid(collAngle, point_distance(0, 0, c_hspeed, c_vspeed));
		
			for (var i = 0; i < solidArraySize; i++) {
				solidArray[i].solid = false;
			}
		}
	}



}

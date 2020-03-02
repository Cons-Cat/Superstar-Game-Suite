var cielDefault = y + (zfloor - zcieling) * 20;

if obj_z_mode.mode = 0 {
	floorY = y;
	cielY = cielDefault;
} else {
	var floorMax = y + (zfloor - obj_z_max.z) * 20;
	var floorMin = y + (zfloor - obj_z_min.z) * 20;
	
	floorY = clamp(y, floorMax, y + (zfloor + zcieling) * 20);
	cielY = clamp(cielDefault, y, floorMin);
}

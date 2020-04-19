//var scrAngle = scr_collision_normal(x, y, obj_solid_mask, 8, 1);;
var collAngle = scr_collision_normal(x, y, obj_solid_mask, 8, 1);;
var scrAngle = collAngle;

var nx;
var ny;
var ix;
var iy;
var rx;
var ry;

var escapeI;

if scrAngle != -1 {
	if (c_hspeed != 0 || c_vspeed != 0) {
		DRAWANGLE = scrAngle;
		nx = lengthdir_x(1, scrAngle);
		ny = lengthdir_y(1, scrAngle);
		
		// Find incident vector
		scrAngle = point_direction(0, 0, c_hspeed, c_vspeed);
		ix = lengthdir_x(1, scrAngle);
		iy = lengthdir_y(1, scrAngle);
		
		// Find reflection vector
		// R = I - 2 * N * (I • N)
		rx = ix - 2 * nx * dot_product(ix, iy, nx, ny);
		ry = iy - 2 * ny * dot_product(ix, iy, nx, ny);
		
		// Produce collision response
		scrAngle = point_direction(0, 0, rx, ry);
		
	    move_outside_solid(collAngle, point_distance(0, 0, c_hspeed, c_vspeed));
		/*
		escapeI = 0;
		while scr_collision_normal(x, y, obj_solid_mask, 8, 1) != -1 {
			x += lengthdir_x(rx, scrAngle);
			y += lengthdir_y(ry, scrAngle);
			
			// Prevent infinite loop in edge cases.
			escapeI++;
			if escapeI > 10 { break; }
		}
		*/
	}
}

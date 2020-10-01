/// collision_normal(x1,y1,obj_solid_mask [,rad [,res]])
function scr_collision_normal() {
	//
	//  Returns a 2D "surface normal" (in degrees) at a given point 
	//  on or near an instance detected within a circular test area.
	//  Makes approximately pi*(rad*rad)/(res*res) collision calls.
	//  If no collision is found, (-1) is returned.
	//
	//      x1,y1       point on the surface, real
	//      rad         radius of test area (default 4), real
	//      res         resolution of test (default 1), real
	//
	/// GMLscripts.com/license
	var xx  = argument[0];
	var yy  = argument[1];
	var rad = 4;
	var res = 1;
	if (argument_count > 2) rad = argument[2];
	if (argument_count > 3) res = argument[3];
	if (rad <= 0) rad = 4;
	if (res <= 0) res = 1;
	var nx = 0;
	var ny = 0;

	solidArraySize = 0;
	solidArray[0] = -1;

	if !collision_circle(xx, yy, rad, obj_solid_mask, true, true) {
		return -1;
	}

	for (var k = 0; k < instance_number(obj_solid_mask); k++)
	{
		var inst = instance_find(obj_solid_mask, k);
	
		if script_execute(inst.collScript, self.id, inst.id)
		{
			solidArray[solidArraySize] = inst.id;
			solidArraySize++;
			inst.solid = true;
		
		    if (collision_circle(xx, yy, rad, inst, true, true)) {
		        for (var j = res; j <= rad; j += res) {
		            for (var i = 0; i < rad; i += res) {
		                if (point_distance(0, 0, i, j) <= rad) {
		                    if (!collision_point(xx+i, yy+j, inst, true, true)) { nx += i; ny += j; }
		                    if (!collision_point(xx+j, yy-i, inst, true, true)) { nx += j; ny -= i; }
		                    if (!collision_point(xx-i, yy-j, inst, true, true)) { nx -= i; ny -= j; }
		                    if (!collision_point(xx-j, yy+i, inst, true, true)) { nx -= j; ny += i; }
		                }
		            }
		        }
		    }
		}
	}

	if (nx == 0 && ny == 0) {
		return (-1);
	}

	return point_direction(0, 0, nx, ny);



}

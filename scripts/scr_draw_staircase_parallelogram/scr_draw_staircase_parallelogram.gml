/// scr_draw_staircase_parallelogram( x1, y1, x2, y2, h )

// Top left.
var x1 = argument[0];
var y1 = argument[1];

// Top right.
var x2 = argument[2];
var y2 = argument[3];

// Height of the parallelogram
var h = argument[4];

// Run must be 1.
var argRise = argument[5];

var x0 = min(x1,x2);
var xF = max(x1,x2);

var y0 = min(y1,y2);
var yF = max(y1,y2);

var m = point_direction(x1,y1,x2,y2);
var d = point_distance(x1,y1,x2,y2);

var xx;
var yy;

for(xx = x1; xx < x2; xx++) {
	
}

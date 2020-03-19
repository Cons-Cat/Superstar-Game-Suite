/// scr_draw_staircase_bresenham( x1, y1, x2, y2)
var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];

var dx = abs(x2 - x1);
 var sx = (x1 < x2) ? 1 : -1;
var dy = -abs(y2 - y1);
var sy = (y1 < y2) ? 1 : -1;
var err = dx + dy;
var e2;

var leftward;
if x1 > x2 { leftward = 1; }
else if x1 < x2 { leftward = 0; }
else { leftward = 2; }

var upward;
if y1 > y2 { upward = 1; }
else if y1 < y2 { upward = 0; }
else { upward = 2; }

while (true) {
	if x1-x0 >= 0 && y1-y0 >= 0 {
		staircaseRasterInd[x1-x0,y1-y0] = 1;
	}
	
	if
	( ( x1 >= x2 && leftward = 0) || ( x1 <= x2 && leftward = 1 ) || ( x1 = x2 && leftward = 2) )
	&& ( ( y1 >= y2 && upward = 0) || ( y1 <= y2 && upward = 1 ) || (y1 = y2 && upward = 2) )
	{
		break;
	}
	
	e2 = 2 * err;
	
	if e2 >= dy {
		err += dy;
		x1 += sx;
	}
	
	if e2 <= dx {
		err += dx;
		y1 += sy;
	}
}

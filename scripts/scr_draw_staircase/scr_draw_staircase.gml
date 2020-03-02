/// scr_draw_staircase( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argLength, argSteps )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argSlopeRun = argument[4];
var argSlopeRise = argument[5];
var argLength = argument[6];
var argSteps = argument[7];

var stepLength = argLength / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;
var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );

var x1;
var x2;
var y1;
var y2;

var i;
var j;

var jRun;
var jRise;

var runSign = sign(argSlopeRun);
if runSign = 0 { runSign = 1; }

var riseSign = sign(argSlopeRise);
if riseSign = 0 { riseSign = 1; }

// Prevent 0 denominator
var wallWidth;
var slopeDif;

if argSlopeRun = 0 {
	wallWidth = 1;
	slopeDif = 0;
} else {
	wallWidth =  width * 20 / abs(argSlopeRun);
	slopeDif = abs( abs(argSlopeRun) - abs(argSlopeRise) );
}

// Draw walls in ascending order.
for ( i  = 1; i <= argSteps; i++ ) {
	len = argLength - ( argLength * i / argSteps);
	
	// Draw step wall.
	x1 = argX + lengthdir_x(stepLength,angle + runSign * 90) * (i-1) - 1;
	y1 = argY + lengthdir_y(len, angle + riseSign * 90) - stepHeight * i + 4;
	
	draw_set_color(c_gray);
	
	for ( var j = 0; j < wallWidth; j ++ ) {
		jRun = ( j * argSlopeRun );
		jRise = ( j * argSlopeRise );
		
		draw_rectangle( x1 + jRun, y1 + jRise, x1 + jRun + slopeDif, y1 + jRise + stepHeight, false);
	}
}

// Draw steps in ascending order.
for ( i  = 1; i <= argSteps; i++ ) {
	len = argLength - ( argLength * i / argSteps);
	
	// Draw step floor.
	x1 = argX + lengthdir_x(stepLength,angle + runSign * 90) * i;
	y1 = argY + lengthdir_y(len, angle + riseSign * 90) - stepHeight*i;
	x2 = x1 + ( argSlopeRun * width * 20 / (slopeDif+1) );
	y2 = y1 + ( argSlopeRise * width * 20 / (slopeDif+1) );
	
	draw_set_color(c_white);
	draw_line_width( x1, y1, x2, y2, stepLength );
}

/// scr_draw_staircase( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argLength, argSteps )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argSlopeRun = argument[4];
var argSlopeRise = argument[5];
var argLength = argument[6];
var argSteps = argument[7];

var i;
var j;
var stepLength = argLength / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;
//var angle = sqrt(power(argSlopeRun,2) + power(argSlopeRise,2));
//var angle = arctan( argSlopeRise / argSlopeRun );

//var angle = (-26.57 + 360) % 360;
var len = argLength - ( argLength / argSteps);
var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );

var x1;
var x2;
var y1;
var y2;

show_debug_message(argX);

// Draw walls in ascending order.
for ( i  = 1; i <= argSteps; i++ ) {
	len = argLength - ( argLength * i / argSteps);
	
	// Draw step wall.
	x1 = argX + lengthdir_x(stepLength,angle + sign(argSlopeRun) * 90) * (i-1) - 1;
	y1 = argY + lengthdir_y(len, angle + sign(argSlopeRise) * 90) - stepHeight * (i-1);
	
	draw_set_color(c_gray);
	
	for ( var j = 0; j < 20 / abs(argSlopeRun); j ++ ) {
		draw_rectangle( x1 + ( j * argSlopeRun ), y1 + ( j * argSlopeRise ), x1 + ( j * argSlopeRun ) + abs( abs(argSlopeRun) - abs(argSlopeRise) ), y1 + ( j * argSlopeRise ) + stepHeight, false);
	}
}

// Draw steps in ascending order.
for ( i  = 1; i <= argSteps; i++ ) {
	len = argLength - ( argLength * i / argSteps);
	
	// Draw step floor.
	x1 = argX + lengthdir_x(stepLength,angle + sign(argSlopeRun) * 90) * i;
	y1 = argY + lengthdir_y(len, angle + sign(argSlopeRise) * 90) - stepHeight*i;
	x2 = x1 + ( argSlopeRun * 10 );
	y2 = y1 + ( argSlopeRise * 10 );
		
	draw_set_color(c_white);
	draw_line_width( x1, y1, x2, y2, stepLength );
}

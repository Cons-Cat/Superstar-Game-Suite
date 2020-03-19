/// scr_draw_staircase_alt( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argNormalMag, argSteps )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argNormalRun = argument[4];
var argNormalRise = argument[5];
var argNormalMag = argument[6];
var argSteps = argument[7];

var stepLength = staircaseN / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;

var argSlopeRun = -argNormalRise;
var argSlopeRise = argNormalRun;

if argSlopeRun != 0 {
	argSlopeRise /= abs(argSlopeRun);
	argSlopeRun /= abs(argSlopeRun);
}

var normalAngle = point_direction( 0, 0, argNormalRun, argNormalRise );
var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );
angle = (normalAngle - 90 + 360) % 360;

var stepsAngleY = point_direction( 0, -( argZFloor - argZCeil ) * 20, lengthdir_x(argNormalMag,normalAngle), lengthdir_y(argNormalMag,normalAngle) - stepHeight );

draw_set_color(c_red);
draw_line(argX,argY+(argZFloor-argZCeil)*20,argX+lengthdir_x(argNormalMag,normalAngle),argY+(argZFloor-argZCeil)*20+lengthdir_y(argNormalMag,normalAngle));
draw_set_color(c_blue);
draw_line(argX,argY+(argZFloor-argZCeil)*20,argX+lengthdir_x(argNormalMag,angle),argY+(argZFloor-argZCeil)*20+lengthdir_y(argNormalMag,angle));

var x1;var y1;var x2; var y2; var x3; var y3; var x4; var y4;var x0;var xF, var y0, var yF;
var cWidth = staircaseL;

draw_set_color(c_white);

for (var k = 0; k < argSteps; k++) {
	// RENDER STEP
	x1 = argX + lengthdir_x( k * stepLength, normalAngle );
	y1 = argY + lengthdir_y( k * stepLength, normalAngle ) + k*stepHeight;
	
	x2 = x1 - floor(lengthdir_x( cWidth, angle ));
	y2 = y1 - floor(lengthdir_y( cWidth, angle ));
	
	var w = ceil(lengthdir_x( stepLength, normalAngle ) - 0.5);
	var h = ceil(lengthdir_y( stepLength, normalAngle ) - 0.5);
	
	x3 = x1 + w;
	y3 = y1 + h;
	
	x4 = x2 + w;
	y4 = y2 + h;
	
	scr_draw_staircase_bresenham(x1, y1, x2, y2);
	scr_draw_staircase_bresenham(x1, y1, x3, y3);
	scr_draw_staircase_bresenham(x3, y3, x4, y4);
	scr_draw_staircase_bresenham(x2, y2, x4, y4);
	
	// RENDER WALL
	x1 = x3;
	y1 = y3 + 1;
	x2 = x4;
	y2 = y4 + 1;
	
	y3 = y3 + stepHeight;
	y4 = y4 + stepHeight;
	
	scr_draw_staircase_bresenham(x1, y1, x2, y2);
	scr_draw_staircase_bresenham(x1, y1, x3, y3);
	scr_draw_staircase_bresenham(x3, y3, x4, y4);
	scr_draw_staircase_bresenham(x2, y2, x4, y4);
}
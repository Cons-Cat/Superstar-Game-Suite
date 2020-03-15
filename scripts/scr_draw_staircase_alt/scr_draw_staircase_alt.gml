/// scr_draw_staircase_alt( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argNormalMag, argSteps )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argNormalRun = argument[4];
var argNormalRise = argument[5];
var argNormalMag = argument[6];
var argSteps = argument[7];

var stepLength = argNormalMag / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;

var argSlopeRun = -argNormalRise;
var argSlopeRise = argNormalRun;

var normalAngle = point_direction( 0, 0, argNormalRun, argNormalRise );
var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );
//var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );
//var normalAngle;
//var normalAngle = ( angle + ( 90 * ( (argSlopeRise >= 0) ? -1 : 1 ) ) + 360 ) % 360;
	/*if (angle <= 90  && angle >= 0) || (angle < 360 && angle >= 270) {
		normalAngle = ( angle - 90 + 360 ) % 360;
	} else {
		normalAngle = ( angle + 90 + 360 ) % 360;
	}*/
//var stepsAngleX = point_direction( 0, 0, lengthdir_x(argNormalMag,normalAngle) - 6, lengthdir_y(argNormalMag,normalAngle));
var stepsAngleY = point_direction( 0, -( argZFloor - argZCeil ) * 20, lengthdir_x(argNormalMag,normalAngle), lengthdir_y(argNormalMag,normalAngle) - stepHeight );

//show_debug_message("Angle: " + string(angle));
//show_debug_message("Norm: " + string(normalAngle));

draw_set_color(c_red);
draw_line(x,y+(argZFloor-argZCeil)*20,x+lengthdir_x(argNormalMag,normalAngle),y+(argZFloor-argZCeil)*20+lengthdir_y(argNormalMag,normalAngle));
draw_set_color(c_blue);
draw_line(x,y+(argZFloor-argZCeil)*20,x+lengthdir_x(argNormalMag,angle),y+(argZFloor-argZCeil)*20+lengthdir_y(argNormalMag,angle));

var x1;var y1;var x2; var y2; var x3; var y3; var x4; var y4;var x0;var xF, var y0, var yF;
var xInc; var yInc;
//var calcY = argY - (argZFloor - argZCeil)*20;
//var stepOff = 0;
//var len;
//var tempX = 0;
var cWidth = ( (width * 20) / argSlopeRun ) - argSlopeRun;

draw_set_color(c_white);

for (var k = 0; k < argSteps; k++) {
	// RENDER STEP

	// Top left.
	y1 = argY + lengthdir_y( k * stepLength, stepsAngleY ) + k*stepHeight;
	x1 = argX + lengthdir_x( k * stepLength, normalAngle );
	
	// Top right.
	y2 = y1 + floor(argSlopeRise * cWidth);
	x2 = x1 + argSlopeRun * cWidth;
	
	draw_set_color(c_white);
	
	// Draw a parallelogram line-by-line.
	for( var i = 0; i < stepLength; i++) {
		xInc = round(lengthdir_x( i, normalAngle ) + 0.5);
		yInc = round(lengthdir_y( i, stepsAngleY ) + 0.5);
		//xInc = ceil(lengthdir_x( i, normalAngle ) + 0.5);
		//yInc = ceil(lengthdir_y( i, stepsAngleY ) + 0.5);
		
		scr_draw_staircase_bresenham(x1 + xInc, y1 + yInc, x2 + xInc, y2 + yInc);
		
		if i < stepLength - 1 {
			// Hacky solution to fill in gaps
			
			//scr_draw_staircase_bresenham(x1 + xInc + 1, y1 + yInc, x2 + xInc + 1, y2 + yInc);
		}
	}
}
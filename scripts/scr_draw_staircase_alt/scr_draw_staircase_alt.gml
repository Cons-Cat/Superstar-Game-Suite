/// scr_draw_staircase_alt( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argNormalMag, argSteps )
var argX = argument[0];
var argY = argument[1] - 1;
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
var xInc;
var yInc;
var cWidth = width * 20 + width*2;

draw_set_color(c_white);

for (var k = 0; k < argSteps; k++) {
	// RENDER STEP
	x1 = argX + lengthdir_x( k * stepLength, normalAngle );
	y1 = argY + lengthdir_y( k * stepLength, stepsAngleY ) + k*stepHeight;
	
	x2 = x1 - ceil(lengthdir_x( cWidth, angle ));
	y2 = y1 - ceil(lengthdir_y( cWidth, angle ));
	
	x3 = x1;
	
	draw_set_color(c_white);
	
	// Draw a parallelogram line-by-line.
	for( var i = 0; i < stepLength; i += 1) {
		xInc = floor(lengthdir_x( i, normalAngle ) + 0.5);
		yInc = ceil(lengthdir_y( i, normalAngle ) + 0.5);
		
		draw_set_color(c_white);
		scr_draw_staircase_bresenham(x1 + xInc, y1 + yInc, x2 + xInc, y2 + yInc);
		
		
		if i < stepLength - 1 {
			// Hacky solution to fill in gaps
			xInc = floor(lengthdir_x( i, normalAngle ) - 0.5);
			yInc = floor(lengthdir_y( i, normalAngle ) - 0.5);
			scr_draw_staircase_bresenham(x1 + xInc, y1 + yInc, x2 + xInc, y2 + yInc);
		}
	}
	
	// RENDER WALL
	x1 += floor(lengthdir_x(stepLength, normalAngle) - 0.5);
	y1 += floor(lengthdir_y(stepLength, normalAngle) - 0.5);
	
	x2 = x1 - ceil(lengthdir_x( cWidth, angle ));
	y2 = y1 - ceil(lengthdir_y( cWidth, angle ));
	
	draw_set_color(c_gray);
	// var limit = lengthdir_y( ( ( k * stepLength, stepsAngleY ) + k*stepHeight) - ( ( (k+1) * stepLength, stepsAngleY ) + (k+1)*stepHeight) );
	
	//for(i = 0; i < lengthdir_y( (k+1) * stepLength, stepsAngleY ) + (k+1)*stepHeight; i++)
	for( var i = 0; i < stepHeight; i++)
	{
		scr_draw_staircase_bresenham(x1,y1+i,x2,y2+i);
	}
}
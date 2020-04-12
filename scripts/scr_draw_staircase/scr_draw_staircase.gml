/// scr_draw_staircase_alt( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argNormalMag, argSteps, argFill )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argNormalRun = argument[4];
var argNormalRise = argument[5];
var argMagnitude = argument[6];
var argSteps = argument[7];
var argFill = argument[8];

var stepLength = argMagnitude / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;

var argSlopeRun = argNormalRise;
var argSlopeRise = -argNormalRun;

if argSlopeRun != 0 {
	argSlopeRise /= abs(argSlopeRun);
	argSlopeRun /= abs(argSlopeRun);
}

//var normalAngle = point_direction( 0, 0, argNormalRun, argNormalRise );
//var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );
//angle = (normalAngle - 90 + 360) % 360;

var x1;var y1;var x2; var y2; var x3; var y3; var x4; var y4;var x0;var xF, var y0, var yF;
//var cWidth = staircaseL;
var cWidth = width*20;
var colInd;

for (var k = 0; k < argSteps; k++) {
	colInd = k*2;
	
	// RENDER STEP
	x1 = argX + ( k * stepLength * argNormalRun );
	y1 = argY + ( k * stepLength * argNormalRise ) + k * stepHeight;
	
	var xComp = cWidth * argSlopeRun;
	var yComp = cWidth * argSlopeRise;
	
	x2 = x1 + xComp;
	y2 = y1 + yComp;
	
	var w = ceil( stepLength * argNormalRun - 0.5 );
	var h = ceil( stepLength * argNormalRise - 0.5 );
	
	x3 = x1 + w;
	y3 = y1 + h;
	
	x4 = x2 + w;
	y4 = y2 + h;
	
	scr_draw_staircase_bresenham(x1, y1, x2, y2, colInd);
	scr_draw_staircase_bresenham(x1, y1, x3, y3, colInd);
	scr_draw_staircase_bresenham(x3, y3, x4, y4, colInd);
	scr_draw_staircase_bresenham(x2, y2, x4, y4, colInd);
	
	x0 = min(x1, x2, x3, x4);
	y0 = min(y1, y2, y3, y4);
	xF = max(x1, x2, x3, x4);
	yF = max(y1, y2, y3, y4);
	
	if argFill {
		scr_draw_staircase_fill(x0, y0, xF, yF, colInd);
	}
	
	// RENDER WALL
	colInd = k*2 + 1;
	
	x1 = x3;
	y1 = y3 + 1;
	x2 = x4;
	y2 = y4 + 1;
	
	y3 = y3 + stepHeight;
	y4 = y4 + stepHeight;
	
	scr_draw_staircase_bresenham(x1, y1, x2, y2, colInd);
	scr_draw_staircase_bresenham(x1, y1, x3, y3, colInd);
	scr_draw_staircase_bresenham(x3, y3, x4, y4, colInd);
	scr_draw_staircase_bresenham(x2, y2, x4, y4, colInd);
	
	x0 = min(x1, x2, x3, x4);
	y0 = min(y1, y2, y3, y4);
	xF = max(x1, x2, x3, x4);
	yF = max(y1, y2, y3, y4);
	
	if argFill {
		scr_draw_staircase_fill(x0, y0, xF, yF, colInd);
	}
}

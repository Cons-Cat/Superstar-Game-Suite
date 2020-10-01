/// scr_draw_staircase( argX, argY, argNormalRun, argNormalRise, argMagnitude, argSteps, argFill )
function scr_draw_stairwall() {
	var argX = argument[0];
	var argY = argument[1];
	var argNormalRun = argument[2];
	var argNormalRise = argument[3];
	var argMagnitude = argument[4];
	var argSteps = argument[5];
	var argFill = argument[6];

	var stepLength = argMagnitude / argSteps;
	var stepHeight = ( zfloor - zcieling ) * 20 / argSteps;

	var argSlopeRun = argNormalRise;
	var argSlopeRise = -argNormalRun;

	if argSlopeRun != 0 {
		argSlopeRise /= abs(argSlopeRun);
		argSlopeRun /= abs(argSlopeRun);
	}
	if abs(argSlopeRise) > 1 {
		argSlopeRun /= abs(argSlopeRise);
		argSlopeRise /= abs(argSlopeRise);
	}

	var x1;var y1;var x2; var y2; var x3; var y3; var x4; var y4;var x0;var xF, var y0, var yF;
	var cWidth = width*20;
	var colInd;
	var xComp;var yComp;

	for (var k = 0; k < argSteps; k++) {
		colInd = k*2;
	
		// RENDER STEP
		x1 = argX + ( k * stepLength * argNormalRun );
		y1 = argY + ( k * stepLength * argNormalRise ) + k * stepHeight;
	
		xComp = ceil(cWidth * argSlopeRun - 0.5);
		yComp = ceil(cWidth * argSlopeRise - 0.5);
	
		x2 = x1 + xComp;
		y2 = y1 + yComp;
	
		xComp = ceil(argNormalRun * stepLength - 0.5);
		yComp = ceil(argNormalRise * stepLength - 0.5);
	
		x3 = x1 + xComp;
		y3 = y1 + yComp;
	
		x4 = x2 + xComp;
		y4 = y2 + yComp;
	
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



}

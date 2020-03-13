/// scr_draw_staircase_alt( argX, argY, argZFloor, argZCeil, argSlopeRun, argSlopeRise, argNormalMag, argSteps )
var argX = argument[0];
var argY = argument[1];
var argZFloor = argument[2];
var argZCeil = argument[3];
var argSlopeRun = argument[4];
var argSlopeRise = argument[5];
var argNormalMag = argument[6];
var argSteps = argument[7];

var stepLength = argNormalMag / argSteps;
var stepHeight = ( argZFloor - argZCeil ) * 20 / argSteps;

var angle = point_direction( 0, 0, argSlopeRun, argSlopeRise );
var normalAngle = ( angle + ( 90 * ( (argSlopeRise >= 0) ? 1 : -1 ) ) + 360 ) % 360;
//var stepsAngleX = point_direction( 0, 0, lengthdir_x(argNormalMag,normalAngle) - 6, lengthdir_y(argNormalMag,normalAngle));
var stepsAngleY = point_direction( 0, -( argZFloor - argZCeil ) * 20, lengthdir_x(argNormalMag,normalAngle), lengthdir_y(argNormalMag,normalAngle) - stepHeight );

show_debug_message("Angle: " + string(angle));
show_debug_message("Norm: " + string(normalAngle));

draw_set_color(c_red);
draw_line(x,y+(argZFloor-argZCeil)*20,x+lengthdir_x(argNormalMag,normalAngle),y+(argZFloor-argZCeil)*20+lengthdir_y(argNormalMag,normalAngle));

var x1;var y1;var x2; var y2; var x3; var y3; var x4; var y4;var x0;var xF, var y0, var yF;
//var calcY = argY - (argZFloor - argZCeil)*20;
//var stepOff = 0;
//var len;
//var tempX = 0;
var cWidth = (width * 20) / argSlopeRun - argSlopeRun;

draw_set_color(c_white);

for (var k = 0; k < argSteps; k++) {
	//var xInc = lengthdir_x(stepLength/2,normalAngle);
	//var yInc = stepHeight;
	
	//tempX = x3;
	//stepOff = k * ( lengthdir_x( (k)*stepLength, angle ) - lengthdir_x( (k+1)*stepLength, angle ) );
	//len = argNormalMag - ( argNormalMag * k / argSteps );
	
	//if k > 0 {
	//stepOff = -argNormalMag / argSteps * k;
	//}
	
	
	//stepOff = -1.5 * k;
	
	//if (k > 0) {
		//var tempX1 = argX + lengthdir_x( (k)*stepLength, normalAngle );
		//var tempX2 = argX + lengthdir_x( (k)*stepLength, normalAngle );
		
		//x1 = argX + lengthdir_x( (k-1)*stepLength, normalAngle );
		//y1 = calcY + lengthdir_y( k * stepLength, stepsAngleY );
		//stepOff = tempX - x1 - (1.5 * k);
		//stepOff = -1.5 * k;
		
		//stepOff = k * ( sqrt(stepLength/2) - sqrt(abs(y3-y1)) );
		//stepOff = -k * sqrt( sqr(stepLength) - sqr(y3-y1) );
		//stepOff = -1.5 * k;
		
			//stepOff = -k * (tempX2 - tempX1);
		
		//show_debug_message(stepOff);
		
		//show_debug_message(" ");
		//show_debug_message(tempX - x1);
		//show_debug_message(-1.5*k);
		//show_debug_message(tempX - x1 -1.5*k)
		//show_debug_message(" ");
		//show_debug_message(stepOff);
		
		//stepOff = tempX - x1 -1.5*k;
	//}
	
	// RENDER STEP

	// Top left.
	y1 = argY + lengthdir_y( k * stepLength, stepsAngleY ) + k*stepHeight;
	x1 = argX + lengthdir_x( k * stepLength, normalAngle );
	
	// Might floor argSlopeRise * width*20
	
	// Top right.
	y2 = y1 + floor(argSlopeRise * cWidth);
	x2 = x1 + argSlopeRun * cWidth;
	
	// Bottom left.
	//y3 = calcY + lengthdir_y( (k+1) * stepLength, stepsAngleY );
	//x3 = argX + lengthdir_x( (k+1) * stepLength, normalAngle ) + stepOff;
	
	// Bottom right.
	//y4 = y3 + floor(argSlopeRise * width*20);
	//x4 = x3 + argSlopeRun * width*20;
	
	//tempX = x3;
	
	//y0 = min(y1,y2,y3,y4);
	//yF = max(y1,y2,y3,y4);
	
	//x0 = min(x1,x2,x3,x4);
	//xF = max(x1,x2,x3,x4);
	
	/*for( var i = x0; i < xF; i++ ) {
		for( var j = y0; j < yF; j++ ) {
			if
			j >= y1 - floor( (i-x0) * argSlopeRun )
			&& j <= y3 - floor( (i-x0) * argSlopeRun )
			
			&& ( i <= x2 || j >= y2 + abs( floor ( (i - x2)*argSlopeRise) ) )
			&& ( i >= x3 || j <= y3 - abs( floor ( (i - x3)*argSlopeRise) ) )
		{
				if k = 0 { 
					draw_set_color(c_red);
				} else {
					draw_set_color(c_white);
				}
				
				draw_rectangle(i,j,i,j,false);
			}
		}
	}*/
	draw_set_color(c_white);
	
	// Draw a parallelogram line-by-line.
	for( var i = 0; i < stepLength; i++) {
		xInc = round(lengthdir_x( i, normalAngle ) + 0.5);
		yInc = round(lengthdir_y( i, stepsAngleY ) + 0.5);
		
		scr_draw_staircase_bresenham(x1 + xInc, y1 + yInc, x2 + xInc, y2 + yInc);
		
		if i < stepLength - 1 {
			// Hacky solution to fill in gaps
			
			//scr_draw_staircase_bresenham(x1 + xInc + 1, y1 + yInc, x2 + xInc + 1 - argSlopeRun, y2 + yInc - argSlopeRise);
			
			scr_draw_staircase_bresenham(x1 + xInc + 1, y1 + yInc, x2 + xInc + 1, y2 + yInc);
			
			//scr_draw_staircase_bresenham(x1 + xInc + 1, y1 + yInc, x2 + xInc + 1 - argSlopeRun, y2 + yInc - argSlopeRise);
		}
	}
}
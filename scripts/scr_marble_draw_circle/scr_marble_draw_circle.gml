/// scr_marble_draw_circle( x, y, radius, colInd );
var argX = argument[0];
var argY = argument[1];
var argR = argument[2];
var argCol = argument[3];

// Increase turbulence
if floor(random(4)) = 0 {
	argR -= 1;
}

// Iterate around circle
for (var i = 0; i < 360; i += 5) {
	if argX + ( argR * dcos(i) ) >= 0 && argY + ( argR * dsin(i) ) >= 0 {
		marblePixelCol[argX + ( argR * dcos(i) ), argY + ( argR * dsin(i) )] = argCol;
	}
}

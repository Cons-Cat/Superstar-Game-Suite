/// scr_marble_draw_streak( x, y, girth, colInd );
var argX = argument[0];
var argY = argument[1];
var argGirth = argument[2];
var argDir = argument[3]
var argCol = argument[4];

var shortRadius = floor(round(argGirth)/2);
var wideRadius = ceil(round(argGirth)/2);

for (var i = 0; i < shortRadius; i += 1) {
	if argX - lengthdir_x(i,argDir - 90) >= 0 && argY - lengthdir_y(i,argDir - 90) >= 0 {
		marblePixelCol[argX - lengthdir_x(i,argDir - 90), argY - lengthdir_y(i,argDir - 90)] = argCol;
	}
}
for (var i = 0; i < wideRadius; i += 1) {
	if argX + lengthdir_x(i,argDir + 90) >= 0 && argY + lengthdir_y(i,argDir + 90) >= 0 {
		marblePixelCol[argX + lengthdir_x(i,argDir + 90), argY + lengthdir_y(i,argDir + 90)] = argCol;
	}
}

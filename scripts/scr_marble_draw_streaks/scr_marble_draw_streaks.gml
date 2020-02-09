/// scr_marble_draw_streaks( x, y, girth, colInd );
var argX = argument[0];
var argY = argument[1];
var argGirth = argument[2];
var argDir = argument[3]
var argDirOff = argument[4];
var argCol = argument[5];

var shortRadius = floor(round(argGirth)/2);
var wideRadius = ceil(round(argGirth)/2);

if j > height * 20 + ( lengthdir_y(i,argDirOff) / lengthdir_x(i,argDirOff) * i ) {
	var dirOff = argDirOff;
} else {
	var dirOff = 0;
}

// Defining pixel values
for (var ii = 0; ii < shortRadius; ii += 1) {
	if argX - lengthdir_x(ii,argDir + dirOff - 90) >= 0 && argY - lengthdir_y(ii,argDir + dirOff - 90) >= 0 {
		marblePixelColInd[argX - lengthdir_x(ii,argDir + dirOff - 90), argY - lengthdir_y(ii,argDir + dirOff - 90)] = argCol;
	}
}

for (var ii = 0; ii < wideRadius; ii += 1) {
	if argX + lengthdir_x(ii,argDir + dirOff + 90) >= 0 && argY + lengthdir_y(ii,argDir + dirOff + 90) >= 0 {
		marblePixelColInd[argX + lengthdir_x(ii,argDir + dirOff + 90), argY + lengthdir_y(ii,argDir + dirOff + 90)] = argCol;
	}
}

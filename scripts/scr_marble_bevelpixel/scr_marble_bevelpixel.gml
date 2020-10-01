/// scr_marble_bevelpixel( x, y, colInd )
function scr_marble_bevelpixel() {
	var argX = argument[0];
	var argY = argument[1];

	if marblePixelColInd[argX,argY] <= 3 {
		// Bevel light pixel thoroughly
		return 0;
	} else {
		// Bevel dark pixels slightly less
		return 1;
	}



}

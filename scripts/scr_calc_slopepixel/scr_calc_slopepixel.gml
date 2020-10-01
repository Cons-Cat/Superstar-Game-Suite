/// scr_calc_slopepixel( angle, x );
function scr_calc_slopepixel() {
	var argAngle = argument[0];
	var ii = argument[1];

	// Function to return y given x and an angle
	var yOutput = ( lengthdir_y(ii,argAngle) / lengthdir_x(i,argAngle) * ii );

	// Prevent undefined domain
	if lengthdir_x(ii,argAngle) = 0 {
		yOutput = 0;
	}

	return yOutput;



}

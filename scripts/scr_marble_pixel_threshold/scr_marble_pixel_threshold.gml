// Function to return y given x and an angle
var argAngle = argument[0];
var ii = argument[1];

var pixelThreshold = ( lengthdir_y(ii,argAngle) / lengthdir_x(i,argAngle) * ii );
//var pixelThreshold = ii * width / height;

// Prevent undefined
if lengthdir_x(ii,argAngle) = 0 {
	pixelThreshold = 0;
}

return pixelThreshold;

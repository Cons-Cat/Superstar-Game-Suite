/// @description Dynamically rotate towards an index
/// @param val1 Index to rotate towards
/// @param val2 0 rotates clockwise, 1 rotates counter-clockwise
/// @param val3 dirIso

var dirIso = argument[2];
var rotSpd;

if abs(dirIso - argument[0]) > 1 && !(argument[0] = 0 && dirIso >= 7) {
	// Rotate quickly across a wide arc
	rotSpd = 0.25;
} else {
	// Rotate slowly across a short arc
	rotSpd = 0.125;
}

if argument[1] = 0 { // Clockwise
	dirIso += rotSpd;
	
	if dirIso >= 8 {
		dirIso -= 8;
	}
}
if argument[1] = 1 { // Counter Clockwise
	dirIso -= rotSpd;
	
	if dirIso < 0 {
		dirIso += 8;
	}
}

return floor(dirIso / rotSpd) * rotSpd;

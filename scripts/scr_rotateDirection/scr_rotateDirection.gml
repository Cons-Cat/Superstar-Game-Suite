var rotationInputDirection = argument[0];
var dirIso = argument[1];
var rotFin = argument[2];
var rotDir;

if (dirIso % 8 <= rotFin % 8 && dirIso % 8 > rotFin % 8 - 4) || (dirIso >= 6 && rotFin < 2) || (dirIso >= 6.5 && rotFin <= 2) || (dirIso >= 7 && rotFin <= 2) || (dirIso >= 7.5 && rotFin <= 2) {
	return 0;
} else {
	return 1;
}

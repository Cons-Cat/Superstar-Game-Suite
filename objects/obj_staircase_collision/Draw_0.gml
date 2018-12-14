/// @description Insert description here
// You can write your code in this editor
draw_self();

if staircaseRotation != 0 && staircaseRotation != 2 {
	iterateLengthTemp = iterateLength - widthIterateCollisionOff;
} else {
	// Sideways staircase
	iterateLengthTemp = iterateLength - widthIterateCollisionOff + 1;
}

for (var i = -1; i <= (iterateLengthTemp) * 20; i += 1) {
	var rise = collisionMaskRise;
	var run  = collisionMaskRun;
	
	if staircaseRotation != 0 && staircaseRotation != 2 {
		var j = i*rise + 3;
	} else {
		// Sideways staircase
		var j = 1;
	}
	
	for (var ii = 0; ii <= 1; ii += 1) {
		for (var jj = 0; jj <= 1; jj += 1) {
			if staircaseRotation != 0 && staircaseRotation != 2 {
				draw_line(slopeOriginOffsetX + i*run - ii,slopeOriginOffsetY - j + jj,slopeOriginOffsetX + i*run - ii + 1 + rayXComponent,slopeOriginOffsetY - j + rayYComponent + jj);
			} else {
				// Sideways staircase
				draw_line(slopeOriginOffsetX - ii,slopeOriginOffsetY - j - i*rise + jj,slopeOriginOffsetX - ii + 1 + rayXComponent,slopeOriginOffsetY - j - i*rise + jj);
			}
		}
	}
}

draw_rectangle(slopeOriginOffsetX,slopeOriginOffsetY,slopeOriginOffsetX,slopeOriginOffsetY,false);

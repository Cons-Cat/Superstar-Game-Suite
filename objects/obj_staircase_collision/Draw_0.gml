/// @description Insert description here
// You can write your code in this editor
draw_self();

for (var i = -1; i <= (widthIterate - widthIterateCollisionOff - 2) * 20; i += 1) {
	var rise = collisionMaskRise // staircaseRise / staircaseRun;
	var run  = collisionMaskRun  // staircaseRun / staircaseRise;
	var j = i*rise + 3;
	
	for (var ii = 0; ii <= 1; ii += 1) {
		for (var jj = 0; jj <= 1; jj += 1) {
			draw_line(slopeOriginOffsetX + i*run - ii,slopeOriginOffsetY - j + jj,slopeOriginOffsetX + i*run - ii + 1 + rayXComponent,slopeOriginOffsetY - j + rayYComponent + jj);
		}
	}
}

draw_rectangle(slopeOriginOffsetX,slopeOriginOffsetY,slopeOriginOffsetX,slopeOriginOffsetY,false);

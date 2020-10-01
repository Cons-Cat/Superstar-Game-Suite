/// scr_draw_staircase_fill(x0, y0, xF, yF, colInd);
function scr_draw_staircase_fill() {
	var x0 = argument[0];
	var y0 = argument[1];
	var xF = argument[2];
	var yF = argument[3];
	var colInd = argument[4];

	var inQuad; // Toggles when the scanner has entered the quadrilateral.
	var prevIn; // Toggles when the previously scanned pixel was enabled before this procedure.
	var drawLine; // Toggles when the quadrilateral does not bisect a line.

	var tempRaster;

	for (var j = 1; j < yF - y0; j++) {
		// Initialize line
		inQuad = false;
		prevIn = false;
		drawLine = false;
	
		for (var i = 0; i < xF - x0; i++) {
			tempRaster[i] = false;
		}
	
		// Scan left-to-right
		for (var i = 0; i <= xF - x0; i++) {
			if(x0 + i < 0) { continue; }
			if(y0 + j < 0) { continue; }
			//if(x0 + i >= staircaseW) { continue; }
			//if(y0 + j >= staircaseH) { continue; }
			//if(x0 + i >= array_height_2d( staircaseRasterTempInd) - 1) { continue; }
			//if(y0 + j >= array_length_2d( staircaseRasterTempInd, 1) - 1) { continue; }
		
			if staircaseRasterTempInd[x0+i, y0+j] = colInd {
				if !inQuad {
					inQuad = true;
					prevIn = true;
				} else {
					// Break when scanning an on pixel immediately after an off pixel
					if !prevIn {
						drawLine = true;
						break;
					}
				}
			} else {
				if inQuad {
					if i = xF - x0 {
						break;
					}
				
					prevIn = false;
					tempRaster[i] = true;
				}
			}
		}
	
		if drawLine {
			for (var i = 0; i < xF - x0; i++) {
				if tempRaster[i] {
					staircaseRasterTempInd[x0+i, y0+j] = colInd;
				
					if staircaseRasterInd[x0+i, y0+j] = -1 || (stepPriority && colInd % 2 = 0) {
						staircaseRasterInd[x0+i, y0+j] = colInd;
					}
				}
			}
		}/* else {
			for (var i = 0; i < xF - x0; i++) {
				staircaseRasterTempInd[x0+i, y0+j] = colInd;
				staircaseRasterInd[x0+i, y0+j] = colInd;
			}
		}*/
	}



}

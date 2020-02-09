/// scr_marble_draw_details()

hasGeneratedTextureDetails = true;

// Lighten top surface
for (i = 0; i < width*20; i += 1) {
	if flip {
		for (j = 0; j < height * 20; j += 1) {
			marblePixelColInd[i,j] -= 2;
		}
	} else {
		for (j = 0; j < angleStartY + 1 - i*angleSlope; j += 1) {
			marblePixelColInd[i,j] -= 2;
		}
	}
}

// If the terrain is not flat
if zfloor - zcieling > 0 {
	// Bevel top edge
	for (i = 0; i < width * 20; i += 1) {
		if !hasAdjacentDownAbove {
			if flip {
				marblePixelColInd[i,height*20-1] = scr_marble_bevelpixel(i,height*20-1);
			} else {
				marblePixelColInd[i,angleStartY - i*angleSlope] = scr_marble_bevelpixel(i,angleStartY - i*angleSlope);
			}
		} else {
			skipBevel[i] = false;
			
			for (k = 0; k < adjacentDownCount; k++) {
				if (self.x + i - 1 >= adjacentDownArrayId[k].x && self.x + i + 1 < adjacentDownArrayId[k].x + adjacentDownArrayId[k].width*20) {
					skipBevel[i] = true;
					
					break;
				}
			}
			
			if !skipBevel[i] {
				if flip {
					marblePixelColInd[i,height*20-1] = scr_marble_bevelpixel(i,height*20-1);
				} else {
					marblePixelColInd[i,angleStartY - i*angleSlope] = scr_marble_bevelpixel(i,angleStartY - i*angleSlope);
				}
			}
		}
		
		// Occlude bottom edge
		if marblePixelColInd[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] < 6 {
			marblePixelColInd[i,angleStartY + (zfloor - zcieling) * 20 - i*angleSlope] += 1;
		}
	}
	
	// Bevel left edge
	if !hasAdjacentLeftAbove {
		if flip {
			for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
				marblePixelColInd[0, j] =  scr_marble_bevelpixel(0,j);
			}
		} else {
			for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
				marblePixelColInd[0, j] = scr_marble_bevelpixel(0,j);
			}
		}
	}
			
	// Bevel right edge
	if !hasAdjacentRightAbove {
		if flip {
			for (j = 0; j < angleStartY + hasAdjacentDown; j += 1) {
				marblePixelColInd[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
			}
		} else {
			for (j = 0; j < angleStartY - angleSlope*width*20 + hasAdjacentDown; j += 1) {
				marblePixelColInd[width * 20 - 1, j] = scr_marble_bevelpixel(width * 20 - 1, j);
			}
		}
	}
}

// Recursing this script
if hasAdjacentLeft {
	with adjacentLeftId {
		if hasMarble {
			if !hasGeneratedTextureDetails {
				scr_marble_draw_details();
			}
		}
	}
}

if hasAdjacentRight {
	with adjacentRightId {
		if hasMarble {
			if !hasGeneratedTextureDetails {
				scr_marble_draw_details();
			}
		}
	}
}

if hasAdjacentUp {
	with adjacentUpId {
		if hasMarble {
			if !hasGeneratedTextureDetails {
				scr_marble_draw_details();
			}
		}
	}
}

if hasAdjacentDown {
	with adjacentDownId {
		if hasMarble {
			if !hasGeneratedTextureDetails {
				scr_marble_draw_details();
			}
		}
	}
}
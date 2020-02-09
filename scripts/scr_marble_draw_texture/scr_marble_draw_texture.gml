/// scr_marble_drawstreaks( argCol )

var argCol = argument[0];

hasGeneratedTextureStreaks[argCol] = true;

// Generate circle noise
/*for (i = -10; i < width * 20 + 10; i += floor(irandom_range(4,11))) {
	for (j = -10; j < (height + zfloor - zcieling) * 20 + 10; j += floor(irandom_range(4,7))) {
		var radius = 2 + random(4);
		
		if ( (j div 5) * 5 ) % 2 = 0 {
			// Even rows
			scr_marble_draw_circle(i,j,radius,4);
		} else {
			// Odd rows
			scr_marble_draw_circle(i + radius,j,radius,4);
		}
	}
}

// Erase circle noise around top edges
if zfloor - zcieling > 0 {
	for (j = 0; j < height * 20 - 1; j += 1) {
		if !hasAdjacentLeft {
			marblePixelColInd[0,j] = 3;
		}
		if !hasAdjacentRight {
			marblePixelColInd[width * 20,j] = 3;
		}
	}
}*/

// Draw marble streaks
for (i = 1; i < streakNetIterations; i += 1) {
	if marblePixelValue[i] = argCol {
		scr_marble_draw_streaks(marblePixelX[i], marblePixelY[i], marbleSampleGirth[i], marbleStreakDir[i], marbleAngleOffset, argCol);
	}
}

// Recursing this script
if hasAdjacentLeft {
	with adjacentLeftId {
		if hasMarble {
			if !hasGeneratedTextureStreaks[argCol] {
				scr_marble_draw_texture(argCol);
			}
		}
	}
}

if hasAdjacentRight {
	with adjacentRightId {
		if hasMarble {
			if !hasGeneratedTextureStreaks[argCol] {
				scr_marble_draw_texture(argCol);
			}
		}
	}
}

if hasAdjacentUp {
	with adjacentUpId {
		if hasMarble {
			if !hasGeneratedTextureStreaks[argCol] {
				scr_marble_draw_texture(argCol);
			}
		}
	}
}

if hasAdjacentDown {
	with adjacentDownId {
		if hasMarble {
			if !hasGeneratedTextureStreaks[argCol] {
				scr_marble_draw_texture(argCol);
			}
		}
	}
}

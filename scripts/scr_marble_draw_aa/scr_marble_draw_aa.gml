/// scr_marble_draw_details()
function scr_marble_draw_aa() {
	hasGeneratedTextureAA = true;

	// Initialize the virtual pixel array
#region

	for (var virI = 0; virI <= width*20 + 1; virI += 1) {
		virtualColInd[virI,0] = 3; // Default to blank
		virtualColInd[virI,(height + zfloor - zcieling)*20 + 1] = 3; // Default to blank

		for (var virJ = 0; virJ <= (height + zfloor - zcieling) * 20 + 1; virJ += 1) {
			if virI >= 1 && virJ >= 1 && virI <= width*20 && virJ <= (height + zfloor - zcieling) * 20 {
				virtualColInd[virI,virJ] = marblePixelColInd[virI-1,virJ-1];
			}
		
			if virI = 0 && virJ >= 1 && virJ <= (height + zfloor - zcieling)*20 {
				virtualColInd[virI,virJ] = 3; // Default to blank
			
				// Transfuse pixels from adjacent left marble
				if hasAdjacentLeft {
					with adjacentLeftId {
						if hasMarble {
							if virJ-1 + (other.y - self.y) >= 0 {
								other.virtualColInd[virI,virJ] = marblePixelColInd[width*20-1,virJ-1 + (other.y - self.y)];
							}
						}
					}
				}
			}
		
			if virI = width*20 + 1 && virJ >= 1 && virJ <= (height + zfloor - zcieling)*20 {
				virtualColInd[width*20+2,virJ] = 3; // Default to blank
			
				// Transfuse pixels from adjacent right marble
				if hasAdjacentRight {
					with adjacentRightId {
						if hasMarble {
							if virJ-1 + (other.y - self.y) >= 0 {
								other.virtualColInd[virI,virJ] = marblePixelColInd[0,virJ-1 + (other.y - self.y)];
							}
						}
					}
				}
			}
		}
	}

#endregion

	// Draw anti-aliasing
#region

	for (var zz = 0; zz <= 1; zz += 1) { // Iterate between light and dark streak
		for (i = 0; i < width*20 + 2; i += 1) {
			for (j = 0; j < (height + zfloor - zcieling)*20 + 2; j += 1) {
				// Focus on either dark or light streaks
				if zz = 0 {
					// Blend light streaks first
					k = 5;
				} else {
					// Blend dark streaks secondly
					k = 6;
				}
			
				var netK = k;

				var adjacentCount = 0;
				var dirCheck = 0;
			
				if virtualColInd[i,j] >= k {
					continue;
				}
			
				repeat(4) {
					dirCheck += 1;
				
					if dirCheck = 1 {
						var ii = i - 1;
						var jj = j;
					}
					if dirCheck = 2 {
						var ii = i + 1;
						var jj = j;
					}
					if dirCheck = 3 {
						var ii = i;
						var jj = j - 1;
					}
					if dirCheck = 4 {
						var ii = i;
						var jj = j + 1;
					}
				
					// Limit within boundaries
					if ii < 0 || ii > width * 20 + 1 { continue; }
					if jj < 0 || jj > ( height + zfloor - zcieling) * 20 + 1 { continue; }
				
					// If the adjacent pixel's darkness is equal to the selected streak's darkness
					if virtualColInd[ii,jj] = k {
						adjacentCount += 1;
					}
				
					// If any adjacent pixel's darkness is greater than, increment the darkness of the anti-aliasing
					if virtualColInd[ii,jj] > k {
						netK = k + 1;
					}
				}
			
				// If the select pixel is in a corner, lighten it
				if adjacentCount >= 2 {
					if i > 0 && j > 0 {
						marblePixelColInd[i-1,j-1] = netK - 1;
					}
				}
			}
		}
	}

#endregion

	// Recursing this script
	if hasAdjacentLeft {
		with adjacentLeftId {
			if hasMarble {
				if !hasGeneratedTextureAA {
					scr_marble_draw_aa();
				}
			}
		}
	}

	if hasAdjacentRight {
		with adjacentRightId {
			if hasMarble {
				if !hasGeneratedTextureAA {
					scr_marble_draw_aa();
				}
			}
		}
	}

	if hasAdjacentUp {
		with adjacentUpId {
			if hasMarble {
				if !hasGeneratedTextureAA {
					scr_marble_draw_aa();
				}
			}
		}
	}

	if hasAdjacentDown {
		for (k = 0; k < adjacentDownCount; k++) {
			with adjacentDownArrayId[k] {
				if hasMarble {
					if !hasGeneratedTextureAA {
						scr_marble_draw_aa();
					}
				}
			}
		}
	}



}

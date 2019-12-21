/// scr_marble_genstreaks( argCol, argStreaks )
var argCol = argument[0];
var argStreaks = argument[1];
var streaksTransfusedLeft = 0;
var streaksTransfusedRight = 0;
var tempEdgeStreakCountRead = 0;
edgeStreakCountRead = 0;
edgeStreakCountWrite = 0;
hasRecursed = false; // Reset to false so that scr_marble_reset_recursion may be executed afterwards

#region

with obj_editor_terrain_par {
	if self.id != other.id { // Exclude itself from the set
		if hasMarble {
			// Transfer horizontal streaks
			#region
			
			// If z coordinate is the same
			if y + (height + zfloor)*20 = other.y + (other.height + other.zfloor)*20 {
				// If the y dimensions overlap
				if (y >= other.y && y <= other.y + (other.height + other.zfloor - other.zcieling)*20)
				|| (y <= other.y && y + (height + zfloor - zcieling)*20 >= other.y) {
					// If the x coordinates are adjacent
					if x = other.x + other.width*20 || x + width*20 = other.x {
						tempEdgeStreakCountRead = 0;
						
						for (i = 0; i < edgeStreakCountWrite; i += 1) {
							if (
							( x = other.x + other.width*20 && edgeStreakTransX[i] <= 2 )
							xor ( x + width*20 = other.x && edgeStreakTransX[i] >= width*20 - 2 )
							)
							{
								if ( ( zfloor = other.zfloor ) || ( y + edgeStreakTransY[i] > other.y + other.height*20 ) )
								//&& ( y + edgeStreakTransY[i] < other.y + ( other.height + other.zfloor - other.zcieling )*20 )
								{
									other.edgeStreakReadX[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransX[i] + ( self.x - other.x );
									other.edgeStreakReadY[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransY[i] - ( other.y - self.y );
									other.edgeStreakReadDir[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransDir[i];
									other.edgeStreakReadGirth[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransGirth[i];
									//other.edgeStreakCount[argCol] = edgeStreakCount[argCol];
									
									other.edgeStreakReadLength[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransLength[i] + 2;
									other.edgeStreakReadJ[other.edgeStreakCountRead + tempEdgeStreakCountRead] = edgeStreakTransJ[i];
									
									tempEdgeStreakCountRead += 1;
								}
							}
						}
						
						other.edgeStreakCountRead += tempEdgeStreakCountRead;
					}
				}
			}
			
			#endregion
		}
	}
}

#endregion

// Calculate streak values
#region

randomize();

show_debug_message("Read: " + string(id) +", " + string(edgeStreakCountRead) + ", Recursion: " + string(marbleRecursionI));

if marbleRecursionI = 0 {
	argStreaks += edgeStreakCountRead;
} else {
	argStreaks = edgeStreakCountRead;
}

for (i = 0; i < argStreaks; i += 1) {
	// Initialize streak
	var initializeNew;
	var distributionX = i;
	var distributionY = 0;
	
	while distributionX >= width {
		distributionX -= width;
		distributionY += 1;
	}
	
	if //(transfuseIterate < edgeStreakCountRead)
	//&& (
	( i < edgeStreakCountRead ) // Transfuse all streaks before initializing new ones
	//)
	//&& marbleRecursionI > 0 // If this is the first iteration of this script on this instance
	{
		initializeNew = false;
	} else {
		initializeNew = true;
	}
	
	var transRight = false;
	var transLeft = false;
	var transEdgesPassed = 0;
	var tempEdgesPassed = transEdgesPassed;
	
	if initializeNew {
		// Initialize a new streak
		streakSampleX = random_range(5 + distributionX * 20, 15 + distributionX * 20);
		streakSampleY = random_range(5 + distributionY * 20, 15 + distributionY * 20);
		
		if hasAdjacentLeft {
			streakSampleDir = floor(random(180)) + 90;
		}
		if hasAdjacentRight {
			streakSampleDir = (floor(random(180)) + 270);
		}
		if !hasAdjacentLeft && !hasAdjacentRight {
			streakSampleDir = floor(random(360));
		}
		
		streakSampleLength = ceil( (width * 20) / ( (argStreaks) / 5.5 ) * 20 * random_range(0.655,1.05));
		streakSampleStart = 0;
	} else {
		// Transfuse an adjacent streak
		streakSampleX = edgeStreakReadX[i];
		streakSampleY = edgeStreakReadY[i];
		streakSampleDir = edgeStreakReadDir[i];
		marbleSampleGirth[0] = edgeStreakReadGirth[i];
		
		streakSampleLength = edgeStreakReadLength[i];
		streakSampleStart = edgeStreakReadJ[i];
		
		var streakAnglePassing = streakSampleDir;
		
		// Transfuse from right edge
		if streakAnglePassing > 90 && streakAnglePassing < 270 {
			transRight = true;
		}
		// Transfuse from left edge
		if streakAnglePassing < 90 || streakAnglePassing > 270 {
			transLeft = true;
		}
		
		transEdgesPassed = 1;
		//transfuseIterate += 1;
	}
	
	// Develop streak
	for (j = streakSampleStart; j < streakSampleLength; j += 1) {
		// Give streak random turbulence
		streakSampleDir += random_range(-38,38);
		streakSampleDir = (streakSampleDir + 360) % 360;
		
		streakSampleX += lengthdir_x(1,streakSampleDir);
		streakSampleY += lengthdir_y(1,streakSampleDir);
		
		// Extend streak length
		streakNetIterations += 1;
		
		// Develop girth
		marbleSampleGirth[streakNetIterations] = marbleSampleGirth[streakNetIterations - 1];
		
		if j < streakSampleLength - marbleSampleGirth[streakNetIterations] {
			marbleSampleGirth[streakNetIterations] += random_range(-0.55,0.55);
		} else {
			marbleSampleGirth[streakNetIterations] -= 1;
		}
		
		// Girth limits
		if marbleSampleGirth[streakNetIterations] < 1 {
			marbleSampleGirth[streakNetIterations] = 1;
		}
		if marbleSampleGirth[streakNetIterations] > 4.5 {
			marbleSampleGirth[streakNetIterations] = 4.5;
		}
		
		// Define where a pixel is placed
		marblePixelX[streakNetIterations] = streakSampleX;
		marblePixelY[streakNetIterations] = streakSampleY;
		marbleStreakDir[streakNetIterations] = streakSampleDir;
		
		// Define the value of the pixel
		if marbleSampleGirth[streakNetIterations] >= 1 {
			// Streak color
			marblePixelValue[streakNetIterations] = argCol;
		} else {
			// Taper value
			marblePixelValue[streakNetIterations] = argCol - 1;
		}
		
		// Transfuse this streak
		if j < streakSampleLength - 1 {
			// Transfuse across right edge
			if floor(streakSampleX) >= width*20 - 1 {
				if !transRight {
					streakSampleX = width*20 - 1;
					
					transRight = true;
					streakAnglePassing = streakSampleDir;
					transEdgesPassed += 1;
					streaksTransfusedRight += 1;
					
					// Break streaks that pass rightward (outward)
					if ( streakAnglePassing < 90 || streakAnglePassing > 270 ) {
						transEdgesPassed = 2;
					}
				} else if (
					transRight
					&& (
						// Pass leftward, and back in rightward
						( streakAnglePassing > 90 && streakAnglePassing < 270 )
						&& (
							( streakSampleDir <= 90 )
							|| ( streakSampleDir >= 270 )
						)
					)
				) {
					streakSampleX = width*20 - 1;
					transEdgesPassed += 1;
					streaksTransfusedRight += 1;
				}
			}
			
			// Transfuse across left edge
			if	floor(streakSampleX) <= 0 {
				if !transLeft {
					streakSampleX = 0;
					
					transLeft = true;
					streakAnglePassing = streakSampleDir;
					transEdgesPassed += 1;
					streaksTransfusedLeft += 1;
					
					// Break streaks that pass leftward (outward)
					if ( streakAnglePassing > 90 && streakAnglePassing < 270 ) {
						transEdgesPassed = 2;
					}
				} else if (
					transLeft
					&& (
						// Pass rightward, and back in leftward
						( streakAnglePassing < 90 || streakAnglePassing > 270 )
						&& (
							( streakSampleDir >= 90 )
							&& (  streakSampleDir <= 270 )
						)
					)
				) {
					streakSampleX = 0;
					transEdgesPassed += 1;
					streaksTransfusedLeft += 1;
				}
			}
			
			//if tempEdgesPassed != transEdgesPassed {
			if transEdgesPassed = 2 {
				tempEdgesPassed = transEdgesPassed;
				
				edgeStreakTransX[edgeStreakCountWrite] = streakSampleX;
				edgeStreakTransY[edgeStreakCountWrite] = streakSampleY;
				edgeStreakTransDir[edgeStreakCountWrite] = streakSampleDir;
				edgeStreakTransGirth[edgeStreakCountWrite] = marbleSampleGirth[streakNetIterations];
				edgeStreakTransLength[edgeStreakCountWrite] = streakSampleLength;
				edgeStreakTransJ[edgeStreakCountWrite] = j;
				
				// Dark or light
				edgeStreakCount[argCol] += 1;
				
				// Debugging transfusion
				if transRight {
					marbleDebugPixelColInd[marbleDebugPixelCount] = 7; // Red
				}
				if transLeft {
					marbleDebugPixelColInd[marbleDebugPixelCount] = 8; // Blue
				}
				
				marbleDebugPixelX[marbleDebugPixelCount] = streakSampleX;
				marbleDebugPixelY[marbleDebugPixelCount] = streakSampleY;
				marbleDebugPixelCount += 1;
				
				edgeStreakCountWrite += 1;
			}
			
			// End the streak
			if tempEdgesPassed = 2 {
				streakSampleLength = 0;
				
				break;
			}
		}
		
		// Beyond texture's vertical bounds
		if streakSampleY > (height + zfloor - zcieling) * 20 || streakSampleY < 0 {
			// Skip the rest of this streak
			streakNetIterations -= 1;
			
			break;
		}
	}
}

#endregion

// Increment the count of times this script has executed on this instance
marbleRecursionI += 1;

// Recursing this script
if streaksTransfusedLeft > 0 {
	if hasAdjacentLeft {
		with adjacentLeftId {
			if hasMarble {
				scr_marble_genstreaks(argCol,streaksCol[argCol]);
			}
		}
		
		show_debug_message("Left. Write: " + string(id) + ", " + string(streaksTransfusedLeft) + ", Recursion: " + string(marbleRecursionI));
	}
}

if streaksTransfusedRight > 0 {
	if hasAdjacentRight {
		with adjacentRightId {
			if hasMarble {
				scr_marble_genstreaks(argCol,streaksCol[argCol]);
			}
		}
		
		show_debug_message("Right. Write: " + string(id) + ", " + string(streaksTransfusedRight) + ", Recursion: " + string(marbleRecursionI));
	}
}

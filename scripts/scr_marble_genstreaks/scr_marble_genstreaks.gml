/// scr_marble_genstreaks( argCol, argStreaks )
var argCol = argument[0];
var argStreaks = argument[1];

var argStreaksReadIn = 0;

if argument_count >= 3 {
	argStreaksReadIn = argument[2];
	
	if argument_count >= 4 {
		var argId = argument[3];
	}
}

var streaksTransfusedLeft = 0;
var streaksTransfusedRight = 0;
var streaksTransfusedUp = 0;
var streaksTransfusedDown = 0;
var streaksTransfusedTopDown = 0;

hasRecursed = false; // Reset to false so that scr_marble_reset_recursion() may be executed afterwards
var edgeStreakCountRead = 0;
var edgeStreakCountWrite = 0;

#region

// Transfer streaks
if argStreaksReadIn > 0 {
	// REPLACE THIS ITERATION WITH ONLY THE OBJECT CALLING THIS SCRIPT
	with obj_editor_placeable_parent {
		if self.id != other.id { // Exclude itself from the set
			if hasMarble {
				#region
				
				// If this instance is adjacent
				if (
					// If y coordinate is the same
					y + (height + zfloor)*20 = other.y + (other.height + other.zfloor)*20
					&& (
						// If the z dimensions overlap
						(y >= other.y && y <= other.y + (other.height + other.zfloor - other.zcieling)*20)
						|| (y <= other.y && y + (height + zfloor - zcieling)*20 >= other.y)
					)
					&& (
						// If the x coordinates are adjacent
						x = other.x + other.width*20
			               || x + width*20 = other.x
					)
				)
				|| (
					// If y coordinate is adjacent
					( y + (height + zfloor)*20 = other.y + other.zfloor*20
					|| y + zfloor*20 = other.y + (other.height + other.zfloor)*20 )
					&& (
						// If the x dimensions overlap
						(x >= other.x && x < other.x + other.width*20)
						|| (x <= other.x && x + width*20 >= other.x)
					)
					&& (
						// If the z dimensions overlap
						(zfloor >= other.zfloor && zcieling <= other.zfloor)
						|| (zfloor <= other.zfloor && zfloor > other.zcieling)
					)
				)
				{
					for (i = 0; i < argStreaksReadIn; i += 1) {
						var tempTransX = self.x + edgeStreakTransX[i];
						var tempTransY = self.y + edgeStreakTransY[i];
						
						// Ensure this streak was meant to transfuse to this instance
						if
						(
							tempTransX >= other.x && tempTransX <= other.x + other.width * 20
							&& (
								(
									// Adjacent upward and transfusing downward
									edgeStreakTransDir[i] > 180 && edgeStreakTransDir[i] < 360
									&& edgeStreakTransY[i] = height*20 - 1
								)
								xor (
									// Adjacent downward and transfusing upward
									edgeStreakTransDir[i] < 180 && edgeStreakTransDir[i] > 0
									&& edgeStreakTransY[i] = 0
								) 
							)
						)
						|| (
							tempTransY >= other.y + other.height * 20 && tempTransY <= other.y + ( other.height + other.zfloor - other.zcieling ) * 20
							&& (
								// Adjacent rightward and transfusing leftward
								edgeStreakTransDir[i] < 270 && edgeStreakTransDir[i] > 90
								xor
								// Adjacent leftward and transfusing rightward
								edgeStreakTransDir[i] > 270 || edgeStreakTransDir[i] < 90
							)
						)
						{
							if ( y < other.y || y >= other.y + other.height*20 - 1)
							&& other.zfloor = self.zfloor
							&& tempTransX >= other.x && tempTransX <= other.x + other.width*20
							{
								// Transfuse across top face's camera-facing edge
								if edgeStreakTransY[i] = 0 {
									// Transfuse from top, upward.
									other.edgeStreakReadY[edgeStreakCountRead] = other.height * 20;
								} else if edgeStreakTransY[i] = height*20 - 1  {
									// Transfuse from top, downward.
									other.edgeStreakReadY[edgeStreakCountRead] = 0;
								} else {
									continue;
								}
							} else {
								// Transfuse horizontally.
								other.edgeStreakReadY[edgeStreakCountRead] = edgeStreakTransY[i] - ( other.y - self.y );
							}
							
							other.edgeStreakReadX[edgeStreakCountRead] = edgeStreakTransX[i] + ( self.x - other.x );
							
							other.edgeStreakReadDir[edgeStreakCountRead] = edgeStreakTransDir[i];
							other.edgeStreakReadGirth[edgeStreakCountRead] = edgeStreakTransGirth[i];
							other.edgeStreakReadLength[edgeStreakCountRead] = edgeStreakTransLength[i];
							other.edgeStreakReadJ[edgeStreakCountRead] = edgeStreakTransJ[i];
							
							//show_debug_message(" " + string(other.id) + ": " + string(i));
							edgeStreakCountRead += 1;
						}
					}
				}
				
				#endregion
			}
		}
	}
}

//show_debug_message("");

#endregion

// Calculate streak values
#region

randomize();

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
	
	if i < edgeStreakCountRead { // Transfuse all streaks before initializing new ones
		initializeNew = false;
	} else {
		initializeNew = true;
	}
	
	var transRight = false;
	var transLeft = false;
	var transUp = false;
	var transDownTopDown = false; // y = height*20
	var streakHasBeenAbove = false;
	var transDownSide = false;
	
	var transEdgesPassed = 0;
	
	if initializeNew {
		// Initialize a new streak
		streakSampleX = random_range(5 + distributionX * 20, 15 + distributionX * 20);
		streakSampleY = random_range(5 + distributionY * 20, 15 + distributionY * 20);
		
		// Skip generating streaks that are obscured by other terrain.
		var streakBreak = false;
		
		for (k = 0; k < adjacentDownCount; k++) {
			if streakBreak { break; }
			
			if streakSampleX >= adjacentDownArrayId[k].x - self.x && streakSampleX <= adjacentDownArrayId[k].x + adjacentDownArrayId[k].width*20 - self.x {
				if self.y + streakSampleY >= adjacentDownArrayId[k].y && self.y + streakSampleY <= adjacentDownArrayId[k].y + (adjacentDownArrayId[k].height + adjacentDownArrayId[k].zfloor - adjacentDownArrayId[k].zcieling)*20 {
					streakBreak = true;
				}
			}
		}
		
		if streakBreak { continue; }
		
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
		if edgeStreakReadX[i] >= width*20 {
			transRight = true;
		}
		// Transfuse from left edge
		if edgeStreakReadX[i] <= 0 {
			transLeft = true;
		}
		// Transfuse from top edge
		if edgeStreakReadY[i] <= 0 {
			transUp = true;
		}
		// Transfuse from bottom edge
		if edgeStreakReadY[i] >= ( height + zfloor - zcieling ) * 20 {
			transDownSide = true;
		}
		
		transEdgesPassed = 1;
	}
	
	// Develop streak
	for (j = streakSampleStart; j < streakSampleLength; j += 1) {
		// Give streak random turbulence
		streakSampleDir += random_range(-38,38);
		
		if streakSampleDir >= 360 || streakSampleDir < 0 {
			streakSampleDir = (streakSampleDir + 360) % 360;
		}
		
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
			if floor(streakSampleX) > width*20 - 1 {
				streakSampleX = width*20 - 1;
				
				if !transRight {
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
					transEdgesPassed = 2;
					streaksTransfusedRight += 1;
				}
			}
			
			// Transfuse across left edge
			if floor(streakSampleX) < 0 {
				streakSampleX = 0;
				
				if !transLeft {
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
					transEdgesPassed = 2;
					streaksTransfusedLeft += 1;
				}
			}
			
			if streakSampleY < height*20 - 1 {
				//if streakSampleDir < 180 && streakSampleDir > 0 { // Angling upward
					streakHasBeenAbove = true;
				//}
			}
			
			// Transfuse across side face's top edge
			if streakHasBeenAbove {
				if streakSampleY >= height*20 - 1 {
					//if streakSampleDir > 180 && streakSampleDir < 360 { // Angling downward
						for (k = 0; k < adjacentDownCount; k++) {
							if adjacentDownArrayId[k].x - self.x <= streakSampleX && adjacentDownArrayId[k].x + adjacentDownArrayId[k].width*20 - self.x >= streakSampleX {
								adjacentDownArrayTrans[k] = true;
								streakSampleY = height*20 - 1;
							
								transDownTopDown = true;
								streaksTransfusedTopDown += 1;
								transEdgesPassed = 2;
							
								break;
							}
						}
					//}
		   		}
			}
			
			if streakSampleY <= 0 {
				streakSampleY = 0;
				
				if !transUp {
					transUp = true;
					streakAnglePassing = streakSampleDir;
					transEdgesPassed += 1;
					streaksTransfusedUp += 1;
					
					// Break streaks that pass upward (outward)
					if ( streakAnglePassing < 180 || streakAnglePassing > 0 ) {
						transEdgesPassed = 2;
					}
				} else if (
					transUp
					&& (
						// Pass downward, and back in upward
						( streakAnglePassing > 180 && streakAnglePassing < 360 )
						&& (
							( streakSampleDir <= 360 )
							|| ( streakSampleDir >= 180 )
						)
					)
				) {
					streaksTransfusedUp += 1;
					transEdgesPassed = 2;
				}
			}
			
			// Commented out for now
			#region
			// Transfuse across side face's down edge
			/*if floor(streakSampleY) >= ( height + zfloor - zcieling ) * 20 - 1 {
				if !transDownSide {
					streakSampleY = ( height + zfloor - zcieling ) * 20 - 1;
					
					transDownSide = true;
					streakAnglePassing = streakSampleDir;
					transEdgesPassed += 1;
					streaksTransfusedDown += 1;
					
					// Break streaks that pass downward (outward)
					if ( streakAnglePassing > 180 && streakAnglePassing < 360 ) {
						transEdgesPassed = 2;
					}
				} else if (
					transUp
					&& (
						// Pass upward, and back in downward
						( streakAnglePassing < 180 && streakAnglePassing > 0 )
						&& (
							( streakSampleDir >= 0 )
							|| ( streakSampleDir <= 180 )
						)
					)
				) {
					streakSampleY = 0;
					transEdgesPassed += 1;
					streaksTransfusedUp += 1;
				}
			}*/
			
			// Transfuse across top face's down edge
			/*if ( floor(streakSampleY) >= ( height ) * 20 - 1 && streakSampleDir > 180 && streakSampleDir < 360 )
			|| ( floor(streakSampleY) <= ( height ) * 20 - 1 && streakSampleDir < 180 && streakSampleDir > 0 ) {
				if !transDownTop {
					transDownTop = true;
					
					edgeStreakTransXTop[edgeStreakCountWrite] = streakSampleX;
					edgeStreakTransYTop[edgeStreakCountWrite] = height * 20 - 1;
				}
			}*/
			
			#endregion
			
			if transEdgesPassed = 2 {
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
					//streaksTransfusedRight += 1;
				} else
				if transDownTopDown {
					marbleDebugPixelColInd[marbleDebugPixelCount] = 7; // Red
					//streaksTransfusedTopDown += 1;
				} else
				if transLeft {
					marbleDebugPixelColInd[marbleDebugPixelCount] = 8; // Blue
					//streaksTransfusedLeft += 1;
				} else
				if transUp {
					//show_debug_message("	pass top edge");
					//streaksTransfusedUp += 1;
					marbleDebugPixelColInd[marbleDebugPixelCount] = 8; // Blue
				}
				
				// End the streak
				if j < streakSampleLength {
					marbleDebugPixelX[marbleDebugPixelCount] = edgeStreakTransX[edgeStreakCountWrite];
					marbleDebugPixelY[marbleDebugPixelCount] = edgeStreakTransY[edgeStreakCountWrite];
					
					marbleDebugPixelCount += 1;
					
					edgeStreakCountWrite += 1;
					streakSampleLength = 0;
				}
				
				break;
			}
			
			// If streak clips into obstructed space.
			if hasAdjacentDown {
				if transEdgesPassed = 0 {
					for (k = 0; k < adjacentDownCount; k++) {
						if streakSampleY >= height*20 {
							if self.x + streakSampleX >= adjacentDownArrayId[k].x
							&& self.x + streakSampleX <= adjacentDownArrayId[k].x + adjacentDownArrayId[k].width * 20
							{
								if transEdgesPassed = 1 {
									// Write streaks that already passed one edge.
									transEdgesPassed = 2;
								} else {
									// End streaks that have not passed an edge.
									streakSampleLength = 0;
								}
								
								break;
							}
						}
					}
				}
			}
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
				scr_marble_genstreaks(argCol,streaksCol[argCol],edgeStreakCountWrite);
			}
		}
	}
}

if streaksTransfusedRight > 0 {
	if hasAdjacentRight {
		with adjacentRightId {
			if hasMarble {
				scr_marble_genstreaks(argCol,streaksCol[argCol],edgeStreakCountWrite);
			}
		}
	}
}

if streaksTransfusedUp > 0  {
	for (k = 0; k < adjacentUpCount; k++) {
		//if adjacentUpArrayTrans[k] {
			with adjacentUpArrayId[k] {
				if hasMarble {
					//show_debug_message(string(other.id) + ": TRANSFUSING UPWARDS, " + string(edgeStreakCountWrite));
					scr_marble_genstreaks(argCol,streaksCol[argCol],edgeStreakCountWrite);
				}
			}
		//}
	}
}

if streaksTransfusedDown > 0 || streaksTransfusedTopDown > 0 {
	for (k = 0; k < adjacentDownCount; k++) {
		if adjacentDownArrayTrans[k] {
			with adjacentDownArrayId[k] {
				if hasMarble {
					//show_debug_message(string(other.id) + ": TRANSFUSING DOWNWARDS, " + string(edgeStreakCountWrite));
					scr_marble_genstreaks(argCol,streaksCol[argCol],edgeStreakCountWrite);
				}
			}
		}
	}
}

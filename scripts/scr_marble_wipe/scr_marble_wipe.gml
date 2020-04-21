/// Reset all marble values on this terrain instance

// Initialize streaks
streakNetIterations = 0;
marbleDebugPixelCount = 0;

// Light streak
streaksCol[5] = ceil( width * ( height + zfloor - zcieling ) / 1.5 ); // Area, in 20x20 units, / 1.5
// Dark streak
streaksCol[6] = floor( width * ( height + zfloor - zcieling ) / 1.5 ); // Area, in 20x20 units, / 1.5

// Initialize streak transfusion
edgeStreakCountRead = 0;
edgeStreakCountWrite = 0;
edgeStreakCount[5] = 0;
edgeStreakCount[6] = 0;

adjacentUpCount = 0;
adjacentDownCount = 0;
adjacentLeftCount = 0;
adjacentRightCount = 0;

adjacentLeftId = 0;
adjacentRightId = 0;
adjacentUpId = 0;
adjacentDownId = 0;

var tempInst;

// Make all virtual pixels blank
for (i = 0; i <= width * 20 + 1; i += 1) {
	for (j = 0; j <= ( height + zfloor - zcieling ) * 20 + 1; j += 1) {
		marblePixelColInd[i,j] = 3;
	}
}

// Prevent infinite recursion
marbleHasBeenWiped = true;
hasGeneratedTextureStreaks[5] = false;
hasGeneratedTextureStreaks[6] = false;
hasGeneratedTextureDetails = false;
hasGeneratedTextureAA = false;
hasRecursed = false;

// Find adjacent terrain
for (i = 0; i < instance_number(obj_editor_placeable_parent); i += 1) {
	#region
	
	tempInst = instance_find(obj_editor_placeable_parent,i);
	
	if tempInst.id != self.id { // Exclude itself from the set
		// Find laterally adjacent terrain
		if tempInst.y + (tempInst.height + tempInst.zfloor) * 20 = self.y + (self.height + self.zfloor) * 20 {
			#region
			
			// Find leftward adjacent terrain
			if tempInst.x + tempInst.width * 20 = self.x {
				hasAdjacentLeft = true;
				adjacentLeftId = tempInst;
				
				if tempInst.y <= self.y {
					hasAdjacentLeftAbove = true;
				}
				
				// Add to array
				adjacentLeftArrayId[adjacentLeftCount] = tempInst.id;
				adjacentLeftArrayTrans[adjacentLeftCount] = false;
				
				adjacentLeftCount++;
				
				// Wipe leftward terrain
				with adjacentLeftId {
					if hasMarble {
						if !marbleHasBeenWiped {
							scr_marble_wipe();
						}
					}
				}
			}
			
			// Find rightward adjacent terrain
			if tempInst.x = self.x + self.width * 20 {
				hasAdjacentRight = true;
				adjacentRightId = tempInst;
				
				if tempInst.y <= self.y {
					hasAdjacentRightAbove = true;
				}
				
				// Add to array
				adjacentRightArrayId[adjacentRightCount] = tempInst.id;
				adjacentRightArrayTrans[adjacentRightCount] = false;
				
				adjacentRightCount++;
			
				// Wipe rightward terrain
				with adjacentRightId {
					if hasMarble {
						if !marbleHasBeenWiped {
							scr_marble_wipe();
						}
					}
				}
			}
			
			#endregion
		}
		
		// Find vertically adjacent terrain
		if ( (tempInst.x <= self.x && tempInst.x + tempInst.width * 20 >= self.x)
		|| (tempInst.x >= self.x && tempInst.x <= self.x + self.width * 20) )
		&& (tempInst.zcieling <= self.zfloor) {
			#region
			
			// Find upward adjacent terrain
			if tempInst.y + (tempInst.height + tempInst.zfloor) * 20 = self.y + self.zfloor * 20 {
				hasAdjacentUp = true;
				adjacentUpId = tempInst;
				
				if tempInst.zfloor <= self.zfloor {
					hasAdjacentUpAbove = true;
				}
				
				// Add to array
				adjacentUpArrayId[adjacentUpCount] = tempInst.id;
				adjacentUpArrayTrans[adjacentUpCount] = false;
				
				adjacentUpCount++;
				
				// Wipe upward terrain
				with adjacentUpId {
					if hasMarble {
						if !marbleHasBeenWiped {
							scr_marble_wipe();
						}
					}
				}
			}
			
			// Find downward adjacent terrain
			if tempInst.y + tempInst.zfloor * 20 = self.y + (self.height + self.zfloor) * 20 {
				hasAdjacentDown = true;
				adjacentDownId = tempInst;
				
				if tempInst.zfloor >= self.zfloor {
					hasAdjacentDownAbove = true;
				}
				
				// Add to array
				adjacentDownArrayId[adjacentDownCount] = tempInst.id;
				adjacentDownArrayTrans[adjacentDownCount] = false;
				
				adjacentDownCount++;
				
				hasAdjacentDown = true;
				adjacentDownId = tempInst;
				
				if tempInst.zfloor <= self.zfloor {
					hasAdjacentDownAbove = true;
				}
				
				// Wipe downward terrain
				with adjacentDownId {
					if hasMarble {
						if !marbleHasBeenWiped {
							scr_marble_wipe();
						}
					}
				}
			}
			
			#endregion
		}
	}
	
	#endregion
}

bakeMarble = true;

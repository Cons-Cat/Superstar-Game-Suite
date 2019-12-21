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

adjacentLeftId = 0;
adjacentRightId = 0;
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
for (i = 0; i < instance_number(obj_editor_terrain_par); i += 1) {
	#region
	
	tempInst = instance_find(obj_editor_terrain_par,i);
	
	if tempInst.id != self.id { // Exclude itself from the set
		if tempInst.y + (tempInst.height + tempInst.zfloor) * 20 = self.y + (self.height + self.zfloor) * 20 {
			// Find adjacent terrain
			if tempInst.x + tempInst.width * 20 = self.x {
				hasAdjacentLeft = true;
				adjacentLeftId = tempInst;
				
				if tempInst.y <= self.y {
					hasAdjacentLeftAbove = true;
				}
				
				// Wipe leftward terrain
				with adjacentLeftId {
					if hasMarble {
						if !marbleHasBeenWiped {
							scr_marble_wipe();
						}
					}
				}
			}
			
			if tempInst.x = self.x + self.width * 20 {
				hasAdjacentRight = true;
				adjacentRightId = tempInst;
				
				if tempInst.y <= self.y {
					hasAdjacentRightAbove = true;
				}
			}
			
			// Wipe rightward terrain
			with adjacentRightId {
				if hasMarble {
					if !marbleHasBeenWiped {
						scr_marble_wipe();
					}
				}
			}
		}
		
		/*if tempInst.y = self.y + self.height*20 {
			if tempInst.x + tempInst.width*20 >= self.x + self.width*20 {
				if tempInst.x <= self.x {
					if tempInst.zfloor = self.zfloor {
						hasAdjacentDown = true;
					}
				}
			}
		}*/
	}
	
	#endregion
}

bakeMarble = true;

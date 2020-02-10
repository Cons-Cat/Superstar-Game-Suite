/// scr_marble_reset_recursion()

hasRecursed = true;
marbleRecursionI = 0;
edgeStreakCountRead = 0;

// Recursing this script
if hasAdjacentLeft {
	with adjacentLeftId {
		if hasMarble {
			if !hasRecursed {
				scr_marble_reset_recursion();
			}
		}
	}
}

if hasAdjacentRight {
	with adjacentRightId {
		if hasMarble {
			if !hasRecursed {
				scr_marble_reset_recursion();
			}
		}
	}
}

if hasAdjacentUp {
	with adjacentUpId {
		if hasMarble {
			if !hasRecursed {
				scr_marble_reset_recursion();
			}
		}
	}
}

if hasAdjacentDown {
	with adjacentDownId {
		if hasMarble {
			if !hasRecursed {
				scr_marble_reset_recursion();
			}
		}
	}
}

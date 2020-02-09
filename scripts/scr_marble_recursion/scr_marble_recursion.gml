/// scr_marble_recursion(argScript)

var argScr = argument[0];
var argCol = argument[1];

// Increment the count of times this script has executed on this instance
marbleRecursionI += 1;

// Recursing this script
for (k = 0; k < adjacentLeftCount; k++) {
	with adjacentLeftArrayId[k] {
		if hasMarble {
			script_execute(argScr,argCol,streaksCol[argCol]);
		}
	}
}

for (k = 0; k < adjacentRightCount; k++) {
	with adjacentRightArrayId[k] {
		if hasMarble {
			script_execute(argScr,argCol,streaksCol[argCol]);
		}
	}
}

for (k = 0; k < adjacentUpCount; k++) {
	with adjacentUpArrayId[k] {
		if hasMarble {
			script_execute(argScr,argCol,streaksCol[argCol]);
		}
	}
}

for (k = 0; k < adjacentDownCount; k++) {
	with adjacentDownArrayId[k] {
		if hasMarble {
			script_execute(argScr,argCol,streaksCol[argCol]);
		}
	}
}

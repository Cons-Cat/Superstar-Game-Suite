/// @description Box behavior

// Drag box
#region

if ( relativeMouseX >= x - 3 && relativeMouseX <= x ) ||
( relativeMouseX > scrollVerRightBound && relativeMouseX <= scrollVerRightBound + 3 ) ||
( relativeMouseY >= y - 3 && relativeMouseY <= y ) ||
( relativeMouseY >= y + boxHeight && relativeMouseY <= y + boxHeight + 3 ) {
	canSelectBox = true;
	
	outlineCol[0] = col[3];
	outlineCol[1] = col[4];
} else {
	if !select {
		canSelectBox = false;
		
		outlineCol[0] = col[1];
		outlineCol[1] = col[2];
	}
}

// Don't highlight outline when the scrollbar is dragged
if scrollVerSelect {
	canSelectBox = false;
	
	outlineCol[0] = col[1];
	outlineCol[1] = col[2];
}

// Click on outline
if canSelectBox {
	if mouse_check_button_pressed(mb_left) {
		select = true;
		
		xDragOff = x - relativeMouseX;
		yDragOff = y - relativeMouseY;
	}
}

if !mouse_check_button(mb_left) {
	select = false;
	tempCursorPlaceChar = -1;
	tempCursorPlaceLine = -1;
}

// Dragged by the mouse
if select {
	x = ( ( relativeMouseX + xDragOff ) div 5 ) * 5;
	y = ( ( relativeMouseY + yDragOff ) div 5 ) * 5;
}

#endregion

// Drag bubbles
#region
 
if !canSelectBox {
	for (i = 0; i <= bubbleCount; i += 1) {
		if relativeMouseY >= y + 1 + bubbleY[i] - surfaceScrollOff && relativeMouseY <= y + 1 + bubbleY[i] - surfaceScrollOff + (lineCount[i] + 1)*10 {
			if relativeMouseX <= x + 2 + bubbleX[i] && relativeMouseX >= x - 6 + bubbleX[i] {
				if bubbleX[i] > 5 {
					// Left slider
					canSelectBubState[i] = 0;
				}
			} else if relativeMouseX >= x + 5 + bubbleX[i] + longestLine[i] && relativeMouseX <= x + 12 + bubbleX[i] + longestLine[i] {
				// Right slider
				canSelectBubState[i] = 1;
			} else {
				canSelectBubState[i] = -1;
			}
		} else {
			canSelectBubState[i] = -1;
		}
		
		if canSelectBubState[i] != -1 {
			// Slide out slider
			if sliderMagnitude <= 1 - 0.1 {
				sliderMagnitude += 0.1;
			} else {
				sliderMagnitude = 1;
			}
		} else {
			// Retract slider
			if sliderMagnitude > 0.13 {
				sliderMagnitude -= 0.13;
			} else {
				sliderMagnitude = 0;
			}
		}
	}
}

#endregion

// Debug tools
#region

// Create new dialogue bubble
if keyboard_check_pressed(ord("Z")) {
	bubbleCount += 1;
	bubbleX[bubbleCount] = 5;
	
	if lineCount[bubbleCount - 1] = 0 {
		bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 18;
	} else {
		bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 16;
	}
	
	lineCount[bubbleCount] = 0;
	lineStr[bubbleCount,lineCount[bubbleCount]] = "New.";
	longestLine[bubbleCount] = string_width(lineStr[bubbleCount,lineCount[bubbleCount]]);
	canSelectBubState[bubbleCount] = -1;
	remakeSurface = true;
	
	scrollVerPartition = 100;
	
	exit;
}

// Create new dialogue line
if keyboard_check_pressed(ord("X")) {
	lineCount[bubbleCount] += 1;
	lineStr[bubbleCount,lineCount[bubbleCount]] = "TEXT";
	
	remakeSurface = true;
	
	exit;
}

#endregion

// Transform cursor
#region

// Place cursor at position
if mouse_check_button_pressed(mb_left) {
	#region
	
	cursorState = -1; // Default to de-activated cursor
	obj_camera_editor.canInputMove = true; // Freeze camera while manipulating cursor
	
	for (k = 0; k <= bubbleCount; k += 1) {
		if relativeMouseX >= self.x + 4 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] - surfaceScrollOff && relativeMouseY <= self.y + bubbleY[k] - surfaceScrollOff + (lineCount[k]+1)*10 {
			for (j = 0; j <= lineCount[k]; j += 1) {
				if relativeMouseY >= self.y + 4 + bubbleY[k] - surfaceScrollOff + j*10 && relativeMouseY < self.y + 14 + bubbleY[k] - surfaceScrollOff + j*10 {
					cursorBubble = k;
					cursorPlaceLine = j;
					cursorPlaceSelectionLine = cursorPlaceLine;
					cursorState = 0; // Idle cursor
					obj_camera_editor.canInputMove = false; // Freeze camera while manipulating cursor
					
					if relativeMouseX - self.x - 4 - bubbleX[k] > string_width( string_copy(lineStr[k,j],1,string_length(lineStr[k,j]))) - ( string_width( string_char_at(lineStr[k,j],string_length(lineStr[k,j])) ) / 2 ) {
						cursorPlaceChar = string_length(lineStr[k,j]); // Go to end of line
						cursorPlaceSelectionChar = cursorPlaceChar;
					} else {
						for (i = 1; i <= string_length(lineStr[k,j]); i += 1) {
							if string_width( string_copy(lineStr[k,j],1,i) ) - ( string_width( string_char_at(lineStr[k,j],i) ) / 2 ) >= relativeMouseX - self.x - 4 - bubbleX[k] {
								cursorPlaceChar = i-1; // Place to the left of this character
								cursorPlaceSelectionChar = cursorPlaceChar;
								
								break;
							}
						}
					}
					
					cursorPlacePix = string_width( string_copy(lineStr[k,j],1,cursorPlaceChar) ); // Pixel position of cursor
					tempCursorPlacePix = cursorPlacePix; // Pixel position of cursor
					
					break;
				}
			}
		}
	}
	
	#endregion
}

// Drag cursor
if cursorBubble != -1 && cursorState != -1 {
	#region
	
	if mouse_check_button(mb_left) {
		k = cursorBubble;
		
		if tempCursorPlaceChar = -1 {
			tempCursorPlaceChar = cursorPlaceChar;
			tempCursorPlaceLine = cursorPlaceLine;
		}
		
		if relativeMouseX >= self.x + 4 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] - surfaceScrollOff && relativeMouseY <= self.y + bubbleY[k] - surfaceScrollOff + (lineCount[k]+1)*10 {
			for (j = 0; j <= lineCount[k]; j += 1) {
				cursorPlaceSelectionLine = j;
				
				if relativeMouseY >= self.y + 4 + bubbleY[k] - surfaceScrollOff + j*10 && relativeMouseY < self.y + 14 + bubbleY[k] - surfaceScrollOff + j*10 {
					if relativeMouseX - self.x - 4 - bubbleX[k] > string_width( string_copy(lineStr[k,j],1,string_length(lineStr[k,j]))) - ( string_width( string_char_at(lineStr[k,j],string_length(lineStr[k,j])) ) / 2 ) {
						cursorPlaceSelectionChar = string_length(lineStr[k,j]); // Go to end of line
					} else {
						for (i = 1; i <= string_length(lineStr[k,j]); i += 1) {
							if string_width( string_copy(lineStr[k,j],1,i) ) - ( string_width( string_char_at(lineStr[k,j],i) ) / 2 ) >= relativeMouseX - self.x - 4 - bubbleX[k] {
								cursorPlaceSelectionChar = i-1; // Place to the left of this character
								
								break;
							}
						}
						
						break;
					}
				}
			}
		}
		
		// Highlight backwards
		if cursorPlaceSelectionChar <= tempCursorPlaceChar {
			cursorPlaceChar = cursorPlaceSelectionChar;
			cursorPlaceSelectionChar = tempCursorPlaceChar;
		}
		if cursorPlaceSelectionLine <= tempCursorPlaceLine {
			cursorPlaceLine = cursorPlaceSelectionLine;
			cursorPlaceSelectionLine = tempCursorPlaceLine;
		}
		
		// If the cursor has moved while dragging
		if cursorPlaceSelectionChar != cursorPlaceChar || cursorPlaceSelectionLine != cursorPlaceLine {
			cursorState = 1; // Highlight cursor
		} else {
			cursorState = 0; // Cancel highlight
		}
	}
	
	#endregion
}

// Navigate cursor
if cursorState = 0 {
	#region
	
	if keyboard_check_pressed(vk_right) {
		if cursorPlaceChar < string_length(lineStr[cursorBubble,cursorPlaceLine]) {
			// Move cursor rightward
			cursorPlaceChar += 1;
		} else {
			if cursorPlaceLine < lineCount[cursorBubble] {
				// Move cursor onto line below
				cursorPlaceChar = 0;
				cursorPlaceLine += 1;
			}
		}
	}
	
	if keyboard_check_pressed(vk_left) {
		if cursorPlaceChar > 0 {
			// Move cursor leftward
			cursorPlaceChar -= 1;
		} else {
			if cursorPlaceLine > 0 {
				// Move cursor onto line above
				cursorPlaceLine -= 1;
				cursorPlaceChar = string_length(lineStr[cursorBubble,cursorPlaceLine]);
			}
		}
	}
	
	cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
	
	#endregion
}

#endregion

// Type text
if cursorState = 0 {
	#region
	if keyboard_check_pressed(vk_anykey) {
		k = cursorBubble;
		j = cursorPlaceLine;
		
		// Custom script which adds keyboard characters to a string argument
		lineStr[k,j] = typeText(string_copy(lineStr[k,j],1,cursorPlaceChar)) + string_copy(lineStr[k,j],cursorPlaceChar+1,string_length(lineStr[k,j]));
		
		if keyboard_check_pressed(vk_backspace) {
			if cursorPlaceChar > 0 {
				cursorPlaceChar -= 1;
			}
		} else {
			cursorPlaceChar += 1;
		}
		
		cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
		
		remakeSurface = true;
	}
	
	#endregion
}

// Close interface
#region

if relativeMouseX < x - 3 || relativeMouseX > scrollVerRightBound + 3 || relativeMouseY < y - 3 || relativeMouseY > y + boxHeight + 3 {
	if mouse_check_button_pressed(mb_left) {
		canDelete = true;
	}
	
	if mouse_check_button_released(mb_left) {
		// Delete interface
		if canDelete {
			instance_destroy();
		} else {
			cursorPlace = -1; // Lose cursor
			canDelete = true;
		}
	}
} else {
	if mouse_check_button_pressed(mb_left) {
		canDelete = false;
	}
}

#endregion

// Longest line for each bubble
for ( j = 0; j <= bubbleCount; j += 1) {
	var tempLength = 20; // Minimum bubble width
	
	for ( i = 0; i <= lineCount[j]; i += 1) {
		if string_width(lineStr[j,i]) >= tempLength {
			tempLength = string_width(lineStr[j,i]);
			
			longestLine[j] = tempLength;
		}
	}
}

// Update surface and box
if remakeSurface {
	#region
	
	remakeSurface = false;
	
	// Update surface dimensions
	var surfWidth = 0;
	var surfHeight = 0;
	
	for (i = 0; i <= bubbleCount; i += 1) {
		if longestLine[i] + bubbleX[i] + 4 >= surfWidth {
			surfWidth = longestLine[i] + bubbleX[i] + 12;
		}
		
		if lineCount[i] = 0 {
			surfHeight += bubbleY[i] - surfHeight + (lineCount[i] + 1)*10 + 6;
		} else {
			surfHeight += bubbleY[i] - surfHeight + (lineCount[i] + 1)*10 + 4;
		}
	}
	
	panelHeight = surfHeight + 3;
	
	if surface_exists(diaSurface) {
		surface_resize(diaSurface,surfWidth,surfHeight);
	} else {
		diaSurface = surface_create(surfWidth,surfHeight);
	}
	
	// Update box dimensions
	boxWidth = surfWidth + 2;
	
	boxHeight = surfHeight + 1;
	
	// Limit box height
	if boxHeight > 80 {
		boxHeight = 80;
	}
	
	#endregion
}

// Update scrollbar
scrollVerLeftBound = x + boxWidth;
scrollVerRightBound = x + boxWidth + 8;
scrollVerTopBound = y - 1;
scrollVerBotBound = y + boxHeight + 1;
scrollHorLeftBound = x;
scrollHorRightBound = x + boxWidth;

surfaceScrollOff = (panelHeight - (scrollVerBotBound - scrollVerTopBound)) * scrollVerPartition / 100;
 
/// @description Box behavior

if !mouse_check_button(mb_left) {
	select = false;
	tempCursorPlaceChar = -1;
	tempCursorPlaceLine = -1;
	
	for (i = 0; i <= bubbleCount; i += 1) {
		for (j = 0; j <= 3; j += 1) {
			selectBubSlider[i,j] = false;
		}
	}
}

// Selecting the box
#region

if
// Dialogue box
(
	( relativeMouseX >= x - 4 && relativeMouseX <= x ) ||
	( relativeMouseX > scrollVerRightBound && relativeMouseX <= scrollVerRightBound + 4 ) ||
	( relativeMouseY >= y - 4 && relativeMouseY <= y ) ||
	( relativeMouseY >= y + boxHeight && relativeMouseY <= y + boxHeight + 4 )
) &&
(relativeMouseX >= x - 4 && relativeMouseX <= scrollVerRightBound + 4 && relativeMouseY >= y - 4 && relativeMouseY <= y + boxHeight + 4)
// Buttons box
|| (
	( relativeMouseX >= buttonsBoundRight - 2 && relativeMouseX <= buttonsBoundRight + 2 ) ||
	( relativeMouseX >= buttonsBoundLeft - 2 && relativeMouseX <= buttonsBoundLeft + 2 ) ||
	( relativeMouseY >= y - 4 && relativeMouseY <= y ) ||
	( relativeMouseY >= buttonsBoundBot - 2 && relativeMouseY <= buttonsBoundBot + 2 )
)
{
	canSelectBox = true;
} else {
	if !select {
		canSelectBox = false;
	}
}

#endregion

// Drag bubbles
#region
 
 someSliderSelected = false;
 
for (i = bubbleCount; i >= 0; i -= 1) { // Iterate in reverse to give lower bubbles higher slider priority
	// Default to de-selected slider
	for (j = 0; j <= 3; j += 1)  {
		if !selectBubSlider[i,j] {
			canSelectBubSlider[i,j] = false;
		}
	}
	
	if !someSliderSelected {
		// Horizontal sliders
		if relativeMouseY >= y + 2 + bubbleY[i] - surfaceScrollOff && relativeMouseY <= y + 5 + bubbleY[i] - surfaceScrollOff + (lineCount[i] + 1)*10 {
			if relativeMouseX <= x + 2 + bubbleX[i] && relativeMouseX >= x - 6 + bubbleX[i] {
				if bubbleX[i] > 5 {
					// Left slider
					canSelectBubSlider[i,0] = true;
					someSliderSelected = true;
				}
			}
			
			if relativeMouseX >= x + 5 + bubbleX[i] + longestLine[i] && relativeMouseX <= x + 12 + bubbleX[i] + longestLine[i] {
				// Right slider
				canSelectBubSlider[i,1] = true;
					someSliderSelected = true;
			}
		}
		
		// Vertical sliders
		if relativeMouseX >= x + 2 + bubbleX[i] && relativeMouseX <= x + 4 + bubbleX[i] + longestLine[i] {
			if relativeMouseY >= y - 5 + bubbleY[i] - surfaceScrollOff && relativeMouseY <= y + bubbleY[i] - surfaceScrollOff {
				if bubbleY[i] > 5 {
					// Top slider
					canSelectBubSlider[i,2] = true;
					someSliderSelected = true;
				}
			}
			
			if relativeMouseY >= y + 6 + bubbleY[i] + (lineCount[i] + 1)*10 - surfaceScrollOff && relativeMouseY <= y + 11 + bubbleY[i] + (lineCount[i] + 1)*10 - surfaceScrollOff {
				if i > 0 && i < bubbleCount {
					// Bottom slder
					canSelectBubSlider[i,3] = true;
					someSliderSelected = true;
				}
			}
		}
	}
	
	for (j = 0; j <= 3; j += 1)  {
		if canSelectBubSlider[i,j] {
			// Slide out slider
			if sliderMagnitude[i,j] <= 1 - 0.1 {
				sliderMagnitude[i,j] += 0.1;
			} else {
				sliderMagnitude[i,j] = 1;
			}
		} else {
			// Retract slider
			if sliderMagnitude[i,j] > 0.13 {
				sliderMagnitude[i,j] -= 0.13;
			} else {
				sliderMagnitude[i,j] = 0;
			}
		}
		
		// Select sliders
		if mouse_check_button_pressed(mb_left) {
			if canSelectBubSlider[i,j] {
				selectBubSlider[i,j] = true;
				
				selectOffX = bubbleX[i] - (relativeMouseX - self.x);
				selectOffY = bubbleY[i] - (relativeMouseY - self.y);
				
				tempBubbleX = bubbleX[i];
				tempBubbleY = bubbleY[i];
				cursorState = -1;
			}
		}
		
		// Dragging horizontal sliders
		if selectBubSlider[i,0] || selectBubSlider[i,1] {
			bubbleX[i] = relativeMouseX - self.x + selectOffX;
			canSelectBox = false;
			
			// Limit
			if bubbleX[i] < 0 {
				bubbleX[i] = 0;
			}
			
			if bubbleX[i] != tempBubbleX { // If the slider has dragged
				tempBubbleX = bubbleX[i];
				remakeSurface = true;
			}
		}
		
		// Dragging vertical sliders
		if selectBubSlider[i,2] || selectBubSlider[i,3] {
			bubbleY[i] = relativeMouseY - self.y + selectOffY;
			canSelectBox = false;
			
			// Limit
			if i > 0 {
				if lineCount[i-1] > 0 {
					if bubbleY[i] < bubbleY[i-1] + (lineCount[i-1] + 1)*10 + 6 {
						bubbleY[i] = bubbleY[i-1] + (lineCount[i-1] + 1)*10 + 6;
					}
				} else {
					if bubbleY[i] < bubbleY[i-1] + (lineCount[i-1] + 1)*10 + 8 {
						bubbleY[i] = bubbleY[i-1] + (lineCount[i-1] + 1)*10 + 8;
					}
				}
			} else {
				if bubbleY[i] < 0 {
					bubbleY[i] = 0;
				}
			}
			
			if bubbleY[i] != tempBubbleY { // If the slider has dragged
				// Drag lower bubbles in tandem
				for (k = i+1; k <= bubbleCount; k += 1) {
					bubbleY[k] += bubbleY[i] - tempBubbleY;
				}
				
				tempBubbleY = bubbleY[i];
				remakeSurface = true;
			}
		}
	}
}

#endregion

// Dragging the box
#region

// Click on outline
if canSelectBox {
	outlineCol[0] = col[3];
	outlineCol[1] = col[4];
	
	if mouse_check_button_pressed(mb_left) {
		select = true;
		
		xDragOff = x - relativeMouseX;
		yDragOff = y - relativeMouseY;
	}
} else {
	outlineCol[0] = col[1];
	outlineCol[1] = col[2];
}

// Dragged by the mouse
if select {
	x = ( ( relativeMouseX + xDragOff ) div 5 ) * 5;
	y = ( ( relativeMouseY + yDragOff ) div 5 ) * 5;
}

#endregion

// Transform cursor

// Place cursor at position
if mouse_check_button_pressed(mb_left) {
	#region
	
	obj_camera_editor.canInputMove = true; // Freeze camera while manipulating cursor
	
	if relativeMouseX >= self.x && relativeMouseX <= self.x + boxWidth && relativeMouseY >= self.y && relativeMouseY <= self.y + boxHeight {
		cursorState = -1; // Default to de-activated cursor
	}
	
	for (k = 0; k <= bubbleCount; k += 1) {
		if relativeMouseX >= self.x + 3 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] - surfaceScrollOff && relativeMouseY <= self.y + 4 + bubbleY[k] - surfaceScrollOff + (lineCount[k]+1)*10 {
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
		
		// If the mouse is within every line's boundaries
		if relativeMouseX >= self.x + 3 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] - surfaceScrollOff && relativeMouseY <= self.y + 4 + bubbleY[k] - surfaceScrollOff + (lineCount[k]+1)*10 {
			// Iterate through each line
			for (j = 0; j <= lineCount[k]; j += 1) {
				// Update cursor line
				cursorPlaceSelectionLine = j;
					
				// If the mouse is one character beyond the x bound of this line
				if relativeMouseX - self.x - 4 - bubbleX[k] > string_width( string_copy(lineStr[k,j],1,string_length(lineStr[k,j]))) - ( string_width( string_char_at(lineStr[k,j],string_length(lineStr[k,j])) ) / 2 ) {
					cursorPlaceSelectionChar = string_length(lineStr[k,j]); // Go to end of line
					
				// If the mouse is within the line's character bounds
				} else {
					// Iterate through each character of this line
					for (i = 1; i <= string_length(lineStr[k,j]); i += 1) {
						// If the mouse is within this character's bounds
						if string_width( string_copy(lineStr[k,j],1,i) ) - ( string_width( string_char_at(lineStr[k,j],i) ) / 2 ) >= relativeMouseX - self.x - 4 - bubbleX[k] {
							cursorPlaceSelectionChar = i-1; // Place to the left of this character
							
							// Break out of this line's characters
							break;
						}
					}
				}
				
				// If the mouse is above this line's bottom boundary
				if relativeMouseY <= self.y + 14 + bubbleY[k] - surfaceScrollOff + j*10 {
					// Break out of this line loop
					break;
				}
			}
		}
		
		/* Prevent cursor from starting in the wrong place when the direction
		of the selection box changes due to the cursor moving vertically, rather
		than horizontally. */
		if cursorPlaceSelectionLine = tempCursorPlaceLine && cursorPlaceSelectionChar >= tempCursorPlaceChar {
			cursorPlaceChar = tempCursorPlaceChar;
		}
		
		// Highlight backwards
		if ( (cursorPlaceSelectionChar <= tempCursorPlaceChar && cursorPlaceSelectionLine = tempCursorPlaceLine) ) || ( cursorPlaceSelectionLine < tempCursorPlaceLine )  {
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

// Navigate cursor with arrow keys
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
		
		cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
		tempCursorPlacePix = cursorPlacePix; // Pixel position of cursor
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
		
		cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
		tempCursorPlacePix = cursorPlacePix; // Pixel position of cursor
	}
	
	if keyboard_check_pressed(vk_down) {
		if cursorPlaceLine < lineCount[cursorBubble] {
			// Move cursor downward
			cursorPlaceLine += 1;
			
			for (i = 0; i <= string_length(lineStr[cursorBubble,cursorPlaceLine]); i += 1) {
				if string_width(string_copy(lineStr[cursorBubble,cursorPlaceLine],1,i)) <= tempCursorPlacePix + ( string_width( string_char_at(lineStr[cursorBubble,cursorPlaceLine],i) ) / 2 ) {
					cursorPlaceChar = i;
				} else {
					break;
				}
			}
			
			cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
		}
	}
	
	if keyboard_check_pressed(vk_up) {
		if cursorPlaceLine > 0 {
			// Move cursor upward
			cursorPlaceLine -= 1;
			
			for (i = 0; i <= string_length(lineStr[cursorBubble,cursorPlaceLine]); i += 1) {
				if string_width(string_copy(lineStr[cursorBubble,cursorPlaceLine],1,i)) <= tempCursorPlacePix + ( string_width( string_char_at(lineStr[cursorBubble,cursorPlaceLine],i) ) / 2 ) {
					cursorPlaceChar = i;
				} else {
					break;
				}
			}
			
			cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
		}
	}
	
	#endregion
}

// Type text
if keyboard_check_pressed(vk_anykey) {
	#region
	
	if cursorState != -1 {
		k = cursorBubble;
		j = cursorPlaceLine;
		j2 = cursorPlaceSelectionLine;
		i = cursorPlaceChar + 1;
		
		// Idk
		if j = j2 {
			multiLines = false;
			i2 = cursorPlaceSelectionChar + 1;
		} else {
			multiLines = true;
			i2 = cursorPlaceSelectionChar;
		}
		
		tempStr = lineStr[k,j];
		remakeSurface = true;
		
		if cursorState = 0 {
			#region
			
			if lineStr[k,j] != "" || !keyboard_check(vk_backspace) {
				// Custom script which adds keyboard characters to a string argument
				lineStr[k,j] = typeText(string_copy(lineStr[k,j],1,cursorPlaceChar), true) + string_copy(lineStr[k,j],cursorPlaceChar+1,string_length(lineStr[k,j]));
			} else {
				// If the line is blank and backspace is pressed
				
				// Delete a line
				deleteLines = true;
				deleteLine[k,j] = true;
				
				cursorPlaceChar = string_length(lineStr[k,j-1]) + 1;
				cursorPlaceLine = j-1;
			}
			
			if lineStr[k,j] != tempStr {
				if keyboard_check_pressed(vk_backspace) {
					if cursorPlaceChar > 0 {
						// Subtract a character
						cursorPlaceChar -= 1;
					}
				} else {
					cursorPlaceChar += 1;
				}
				
				cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
				tempCursorPlacePix = cursorPlacePix; // Pixel position of cursor
			}
			
			#endregion
		}
		
		if cursorState = 1 {
			#region
			
			while !(j = j2 && i = i2) {
				if j = j2 && string_length(lineStr[k,j]) = 0 {
					// Necessary break for blank line at the end of selection
					break;
				}
				
				if i <= string_length(lineStr[k,j]) {
					// If on the last line
					if j = j2 {
						i2 -= 1;
					}
				} else {
					i = 1;
					j += 1;
				}
				
				// Delete a character from the string
				lineStr[k,j] = string_delete(lineStr[k,j],i,1);
				
				// Delete this line afterwards
				if lineStr[k,j] = "" {
					deleteLines = true;
					deleteLine[k,j] = true;
				}
			}
			
			// Change cursor state to 0
			if multiLines {
				lineStr[k,cursorPlaceLine] = typeText(string_copy(lineStr[k,cursorPlaceLine],1,cursorPlaceChar), false) + string_copy(lineStr[k,cursorPlaceLine], cursorPlaceChar+1, string_length(lineStr[k,cursorPlaceLine]) - cursorPlaceChar) + string_copy(lineStr[k,cursorPlaceLine+1], 1, string_length((lineStr[k,cursorPlaceLine+1])));
				
				deleteLines = true;
				deleteLine[k,j] = true;
			} else {
				lineStr[k,cursorPlaceLine] = typeText(string_copy(lineStr[k,cursorPlaceLine],1,cursorPlaceChar), false) + string_copy(lineStr[k,cursorPlaceLine], cursorPlaceChar+1, string_length(lineStr[k,cursorPlaceLine]) - cursorPlaceChar);
			}
			
			cursorState = 0;
			cursorPlaceChar += 1;
			
			#endregion
		}
		
		// Create a new line
		if keyboard_check_pressed(vk_enter) {
			#region
			
			lineCount[k] += 1;
			deleteLine[k,lineCount[k]] = false;
			
			// Move lines below to make space
			for (var jj = lineCount[k]; jj > j; jj -= 1) {
				lineStr[k,jj] = lineStr[k,jj-1];
			}
			for (var jj = k + 1; jj <= bubbleCount; jj += 1) {
				bubbleY[jj] += 10;
			}
			
			lineStr[k,j+1] = "";
			
			cursorPlaceChar = 0;
			cursorPlaceLine = j+1;
			
			cursorPlacePix = 0;
			tempCursorPlacePix = cursorPlacePix; // Pixel position of cursor
			
			remakeSurface = true;
			
			#endregion
		}
	}
	
	#endregion
}

if deleteLines {
	#region
	
	deleteLines = false;
	deletionStart = -1;
	linesToDelete = 0;
	
	for (k = 0; k <= bubbleCount; k += 1) {
		for (j = 0; j <= lineCount[k]; j += 1) {
			if deleteLine[k,j] {
				if deletionStart = -1 {
					// Find first line to delete
					deletionStart = j;
				}
				
				// Count lines of deletion
				linesToDelete += 1;
			}
		}
		
		// Delete lines
		for (var i = 0; i < linesToDelete; i += 1) {
			// Move lower lines upward
			for (var jj = deletionStart; jj < lineCount[k]; jj += 1) {
				lineStr[k,jj] = lineStr[k,jj+1];
			}
			
			lineCount[k] -= 1;
		}
	}
	
	#endregion
}

// Anchor buttons box
if x - 2 + boxWidth/2 >= trg.x {
	buttonsAnchorRight = true;
} else {
	buttonsAnchorRight = false;
}

// Select buttons
#region

// Anchor buttons box
if buttonsAnchorRight {
	buttonsBoundLeft = scrollVerRightBound + 3;
	buttonsBoundRight = scrollVerRightBound + 1 + sprite_get_width(spr_dia_buttons_box);
} else {
	buttonsBoundLeft = x - 2 - sprite_get_width(spr_dia_buttons_box);
	buttonsBoundRight = x - 2;
}

buttonsBoundBot = y - 5 + sprite_get_height(spr_dia_buttons_box);

for (i = 0; i <= 1; i += 1) {
	for (j = 0; j <= 3; j += 1) {
		if buttonSelected != i * 4 + j {
			canSelectButtonState[i,j] = 0; // Default to de-selected
		} else {
			canSelectButtonState[i,j] = 1;
		}
		
		if relativeMouseY >= y + 1 + j*16 && relativeMouseY <= y + 16 + j*16 {
			if buttonsAnchorRight {
				// Right-anchored buttons box
				if relativeMouseX >= scrollVerRightBound + 6 + i*16 && relativeMouseX <= scrollVerRightBound + 21 + i*16 {
					if buttonSelected = -1 {
						canSelectButtonState[i,j] = 1;
					}
					if buttonSelected = i * 4 + j {
						canSelectButtonState[i,j] = 2;
					}
				}
			} else {
				// Left-anchored buttons box
				if relativeMouseX >= x - 37 + i*16 && relativeMouseX <= x - 22 + i*16 {
					if buttonSelected = -1 {
						canSelectButtonState[i,j] = 1;
					}
					if buttonSelected = i * 4 + j {
						canSelectButtonState[i,j] = 2;
					}
				}
			}
		}
		
		// Make buttons inert when the box is dragging
		if select {
			canSelectButtonState[i,j] = 0;
		}
		
		// Click on a button
		if mouse_check_button_pressed(mb_left) {
			if canSelectButtonState[i,j] = 1 {
				buttonSelected = i * 4 + j;
			}
		}
		
		if mouse_check_button_released(mb_left) {
			buttonSelected = -1;
			
			if canSelectButtonState[i,j] = 2 {
				// Activate button
				if i = 0 && j = 0 {
					// Create a new dialogue bubble
					bubbleCount += 1;
					bubbleX[bubbleCount] = 0;
					deleteLine[bubbleCount,0] = false;
					
					if lineCount[bubbleCount - 1] = 0 {
						bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 18;
					} else {
						bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 16;
					}
					
					lineCount[bubbleCount] = 0;
					lineStr[bubbleCount,lineCount[bubbleCount]] = "";
					longestLine[bubbleCount] = string_width(lineStr[bubbleCount,lineCount[bubbleCount]]);
					
					for (j = 0; j <= 3; j += 1) {
						selectBubSlider[bubbleCount,j] = false;
						canSelectBubSlider[bubbleCount,j] = false;
						sliderMagnitude[bubbleCount,j] = 0;
					}
					
					scrollVerPartition = 100;
					
					remakeSurface = true;
				}
			}
		}
	}
}

#endregion

// Close interface
#region

if !( relativeMouseX >= x - 4 && relativeMouseX <= scrollVerRightBound + 4 && relativeMouseY >= y - 4 && relativeMouseY <= y + boxHeight + 4 )
&& !( relativeMouseX >= buttonsBoundLeft - 2 && relativeMouseX <= buttonsBoundRight + 2 && relativeMouseY <= buttonsBoundBot + 2 )
{
	if mouse_check_button_pressed(mb_left) {
		if cursorState = -1 {
			canDelete = true;
		} else {
			canDelete = false;
		}
	}
	
	if mouse_check_button_released(mb_left) {
		// Delete interface
		if canDelete {
			instance_destroy();
		} else {
			cursorState = -1;
			cursorPlaceChar = -1; // Lose cursor
			canDelete = true;
		}
	}
} else {
	canDelete = false;
}

#endregion

// Longest line for each bubble
for ( j = 0; j <= bubbleCount; j += 1) {
	#region
	
	var tempLength = 20; // Minimum bubble width
	
	for ( i = 0; i <= lineCount[j]; i += 1) {
		if string_width(lineStr[j,i]) >= tempLength {
			tempLength = string_width(lineStr[j,i]);
			
			longestLine[j] = tempLength;
		}
	}
	
	#endregion
}

// Update surface and box
if remakeSurface {
	#region
	
	remakeSurface = false;
	
	// Update surface dimensions
	var surfWidth = 0;
	var surfHeight = 0;
	
	for (i = 0; i <= bubbleCount; i += 1) {
		if longestLine[i] + bubbleX[i] + 12 >= surfWidth {
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
	boxWidth = surfWidth + 3;
	
	boxHeight = surfHeight + 1;
	
	// Limit box height
	if boxHeight > 80 {
		boxHeight = 80;
	}
	
	#endregion
}

// Don't highlight elements when the scrollbar is dragging
if scrollVerSelect {
	canSelectBox = false;
	
	for (i = 0; i <= 3; i += 1) {
		canSelectBubSlider[i] = false;
		
		for (j = 0; j <= bubbleCount; j += 1) {
			sliderMagnitude[j,i] = 0;
		}
	}
	
	for (i = 0; i <= 1; i += 1) {
		for (j = 0; j <= 3; j += 1) {
			canSelectButtonState[i,j] = 0;
		}
	}
}

// Update scrollbar
scrollVerLeftBound = x + boxWidth;
scrollVerRightBound = x + boxWidth + 8;
scrollVerTopBound = y - 1;
scrollVerBotBound = y + boxHeight + 1;
scrollHorLeftBound = x;
scrollHorRightBound = x + boxWidth;

surfaceScrollOff = (panelHeight - (scrollVerBotBound - scrollVerTopBound)) * scrollVerPartition / 100;
 
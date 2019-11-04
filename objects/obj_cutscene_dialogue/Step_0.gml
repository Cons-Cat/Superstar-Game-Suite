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

// Debug tools
#region

// Create new dialogue bubble
if keyboard_check_pressed(ord("Z")) {
	bubbleCount += 1;
	bubbleX[bubbleCount] = 0;
	
	if lineCount[bubbleCount - 1] = 0 {
		bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 18;
	} else {
		bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 16;
	}
	
	lineCount[bubbleCount] = 0;
	lineStr[bubbleCount,lineCount[bubbleCount]] = "New.";
	longestLine[bubbleCount] = string_width(lineStr[bubbleCount,lineCount[bubbleCount]]);
	remakeSurface = true;
	
	for (j = 0; j <= 3; j += 1) {
		selectBubSlider[bubbleCount,j] = false;
		canSelectBubSlider[bubbleCount,j] = false;
		sliderMagnitude[bubbleCount,j] = 0;
	}
	
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
#region

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
		
		if relativeMouseX >= self.x + 3 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] - surfaceScrollOff && relativeMouseY <= self.y + 4 + bubbleY[k] - surfaceScrollOff + (lineCount[k]+1)*10 {
			for (j = 0; j <= lineCount[k]; j += 1) {
				cursorPlaceSelectionLine = j;
				
				if relativeMouseY >= self.y + 4 + bubbleY[k] - surfaceScrollOff + j*10 && relativeMouseY < self.y + 14 + bubbleY[k] - surfaceScrollOff + j*10 {
					if relativeMouseX - self.x - 4 - bubbleX[k] > string_width( string_copy(lineStr[k,j],1,string_length(lineStr[k,j]))) - ( string_width( string_char_at(lineStr[k,j],string_length(lineStr[k,j])) ) / 2 ) {
						cursorPlaceSelectionChar = string_length(lineStr[k,j]); // Go to end of line
						
						break;
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
if keyboard_check_pressed(vk_anykey) {
	#region
	
	if cursorState != -1 {
		k = cursorBubble;
		j = cursorPlaceLine;
		j2 = cursorPlaceSelectionLine;
		i = cursorPlaceChar;
		i2 = cursorPlaceSelectionChar;
		tempStr = lineStr[k,j];
		remakeSurface = true;
		
		if cursorState = 0 {
			// Custom script which adds keyboard characters to a string argument
			lineStr[k,j] = typeText(string_copy(lineStr[k,j],1,cursorPlaceChar), true) + string_copy(lineStr[k,j],cursorPlaceChar+1,string_length(lineStr[k,j]));
			
			if lineStr[k,j] != tempStr {
				if keyboard_check_pressed(vk_backspace) {
					if cursorPlaceChar > 0 {
						cursorPlaceChar -= 1;
					}
				} else {
					cursorPlaceChar += 1;
				}
				
				cursorPlacePix = string_width( string_copy(lineStr[cursorBubble,cursorPlaceLine],1,cursorPlaceChar) ); // Pixel position of cursor
			}
		}
		
		if cursorState = 1 {
			cursorState = 0;
			show_debug_message(cursorState);
			
			while !(j = j2 && i = i2) {
				if i < string_length(lineStr[k,j]) {
					// Fams
					if j = j2 {
						i2 -= 1;
					}
				} else {
					i = 1;
					j += 1;
				}
				
				lineStr[k,j] = string_delete(lineStr[k,j],i+1,1);
				show_debug_message(lineStr[k,j]);
			}
			
			lineStr[k,cursorPlaceLine] = typeText(string_copy(lineStr[k,cursorPlaceLine],1,cursorPlaceChar), false) + string_copy(lineStr[k,cursorPlaceLine],cursorPlaceChar+1,string_length(lineStr[k,cursorPlaceLine]));
			cursorPlaceChar += 1;
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
		
		if mouse_check_button_pressed(mb_left) {
			if canSelectButtonState[i,j] = 1 {
				buttonSelected = i * 4 + j;
			}
		}
		
		if mouse_check_button_released(mb_left) {
			buttonSelected = -1;
			
			if canSelectButtonState[i,j] = 2 {
				// Click on button
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
			cursorPlace = -1; // Lose cursor
			canDelete = true;
		}
	}
} else {
	canDelete = false;
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
 
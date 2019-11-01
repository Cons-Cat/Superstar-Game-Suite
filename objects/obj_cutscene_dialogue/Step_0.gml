/// @description Box behavior

// Drag box
if ( relativeMouseX >= x - 3 && relativeMouseX <= x ) ||
( relativeMouseX > scrollVerRightBound && relativeMouseX <= scrollVerRightBound + 3 ) ||
( relativeMouseY >= y - 3 && relativeMouseY <= y ) ||
( relativeMouseY >= y + boxHeight && relativeMouseY <= y + boxHeight + 3 ) {
	canSelect = true;
	
	outlineCol[0] = col[3];
	outlineCol[1] = col[4];
} else {
	if !select {
		canSelect = false;
		
		outlineCol[0] = col[1];
		outlineCol[1] = col[2];
	}
}

// Click on outline
if canSelect {
	if mouse_check_button_pressed(mb_left) {
		select = true;
		canDelete = false; // Do not delete after releasing mouse
		
		xDragOff = x - relativeMouseX;
		yDragOff = y - relativeMouseY;
	}
}

if !mouse_check_button(mb_left) {
	select = false;
}

// Dragged by the mouse
if select {
	x = ( ( relativeMouseX + xDragOff ) div 5 ) * 5;
	y = ( ( relativeMouseY + yDragOff ) div 5 ) * 5;
}

if mouse_check_button_released(mb_left) {
	// Delete interface
	if canDelete {
		if relativeMouseX < x - 3 || relativeMouseX > scrollVerRightBound + 3 || relativeMouseY < y - 3 || relativeMouseY > y + boxHeight + 3 {
			instance_destroy();
		}
	} else {
		cursorPlace = -1; // Lose cursor
		canDelete = true;
	}
}

// Create new dialogue bubble
if keyboard_check_pressed(ord("Z")) {
	bubbleCount += 1;
	bubbleX[bubbleCount] = 5;
	bubbleY[bubbleCount] = bubbleY[bubbleCount - 1] + lineCount[bubbleCount - 1]*10 + 16;
	lineCount[bubbleCount] = 0;
	lineStr[bubbleCount,lineCount[bubbleCount]] = "new";
	longestLine[bubbleCount] = string_width(lineStr[bubbleCount,lineCount[bubbleCount]]);
}

// Create new dialogue line
if keyboard_check_pressed(ord("X")) {
	lineCount[bubbleCount] += 1;
	lineStr[bubbleCount,lineCount[bubbleCount]] = "TEXT";
}

// Extend line
if keyboard_check_pressed(ord("C")) {
	lineStr[bubbleCount,lineCount[bubbleCount]] += "a";
}

// Place cursor
k = 0; // Bubble

if mouse_check_button_pressed(mb_left) {
	for (k = 0; k <= bubbleCount; k += 1) {
		if relativeMouseX >= self.x + 4 + bubbleX[k] && relativeMouseX <= self.x + 4 + bubbleX[k] + longestLine[k] && relativeMouseY >= self.y + bubbleY[k] && relativeMouseY <= self.y + bubbleY[k] + (lineCount[k]+1)*10 {
			show_debug_message(k);
			for (j = 0; j <= lineCount[k]; j += 1) {
				if relativeMouseY >= self.y + 4 + bubbleY[k] + j*10 && relativeMouseY < self.y + 14 + bubbleY[k] + j*10 {
					cursorBubble = k;
					cursorLine = j;
					cursorState = 0; // Idle cursor
					obj_camera_editor.canInputMove = false; // Freeze camera while manipulating cursor
					
					if relativeMouseX - self.x - 4 - bubbleX[k] > string_width( string_copy(lineStr[k,j],1,string_length(lineStr[k,j]))) - ( string_width( string_char_at(lineStr[k,j],string_length(lineStr[k,j])) ) / 2 ) {
						cursorPlaceChar = string_length(lineStr[k,j]); // Go to end of line
					} else {
						for (i = 1; i <= string_length(lineStr[k,j]); i += 1) {
							if string_width( string_copy(lineStr[k,j],1,i) ) - ( string_width( string_char_at(lineStr[k,j],i) ) / 2 ) >= relativeMouseX - self.x - 4 - bubbleX[k] {
								cursorPlaceChar = i-1; // Place to the left of this character
								
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
}

// Navigate cursor
if cursorState = 0 {
	if keyboard_check_pressed(vk_right) {
		cursorPlaceChar += 1;
		cursorPlacePix = string_width( string_copy(lineStr[0,0],1,cursorPlaceChar) ); // Pixel position of cursor
	}
	if keyboard_check_pressed(vk_left) {
		cursorPlaceChar -= 1;
		cursorPlacePix = string_width( string_copy(lineStr[0,0],1,cursorPlaceChar) ); // Pixel position of cursor
	}
}

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

// Update scrollbar
scrollVerLeftBound = x + boxWidth;
scrollVerRightBound = x + boxWidth + 8;
scrollVerTopBound = y - 1;
scrollVerBotBound = y + boxHeight + 1;

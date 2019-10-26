/// @description Perform most scrollbar operations
relativeMouseX = window_mouse_get_x() + room_width

// Scrollbars
scrollHorFactor = (scrollHorRightBound - scrollHorLeftBound) / panelWidth;
scrollVerFactor = (scrollVerBotBound - scrollVerTopBound) / panelHeight;

if scrollHorFactor > 1 {
	scrollHorFactor = 1;
}
if scrollVerFactor > 1 {
	scrollVerFactor = 1;
}

// Scrolling
if (relativeMouseX >= scrollHorLeftBound && relativeMouseX <= scrollHorRightBound) || (relativeMouseX >= scrollVerLeftBound && relativeMouseX <= scrollVerRightBound) {
	if (relativeMouseY >= scrollVerTopBound && relativeMouseY <= scrollVerBotBound) || (relativeMouseY >= scrollHorTopBound && relativeMouseY <= scrollHorBotBound) {
		if mouse_wheel_up() {
			if keyboard_check(vk_shift) || panelHeight <= (scrollVerBotBound - scrollVerTopBound) {
				if scrollHorPartition < 100 - 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2) {
					scrollHorPartition += 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2);
				} else {
					scrollHorPartition = 100;
				}
			} else {
				if scrollVerPartition > 100 / (panelHeight / (scrollVerBotBound - scrollVerTopBound)) {
					scrollVerPartition -= 100 / (panelHeight / (scrollVerBotBound - scrollVerTopBound));
				} else {
					scrollVerPartition = 0;
				}
			}
		}
		
		if mouse_wheel_down() {
			if keyboard_check(vk_shift) || panelHeight <= (scrollVerBotBound - scrollVerTopBound) {
				if scrollHorPartition > 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2) {
					scrollHorPartition -= 100 / (panelWidth / (scrollHorRightBound - scrollHorLeftBound) * 2);
				} else {
					scrollHorPartition = 0;
				}
			} else {
				if scrollVerPartition < 100 - 100 / (panelHeight / (scrollVerBotBound - scrollVerTopBound)) {
					scrollVerPartition += 100 / (panelHeight / (scrollVerBotBound - scrollVerTopBound));
				} else {
					scrollVerPartition = 100;
				}
			}
		}
	}
}

if scrollVerHeight = scrollVerBotBound - scrollVerTopBound {
	// Hook to the top when condensed
	scrollVerPartition = 0;
}
if scrollHorWidth = scrollHorRightBound - scrollHorLeftBound {
	// Hook the the left when condensed
	scrollHorPartition = 0;
}

// Select scroll bars
scrollHorWidth = scrollHorFactor * (scrollHorRightBound - scrollHorLeftBound); // The dimension of the horizontal clickable scrollbar
scrollVerHeight = scrollVerFactor * (scrollVerBotBound - scrollVerTopBound); // The dimension of the vertical clickable scrollbar

if mouse_check_button_pressed(mb_left) && !select {
	if relativeMouseX >= scrollHorX && relativeMouseX <= scrollHorX + scrollHorWidth {
		if relativeMouseY >= scrollHorTopBound && relativeMouseY <= scrollHorBotBound {
			scrollHorSelect = true;
			scrollHorSelectOff = relativeMouseX - scrollHorX;
		}
	}
	
	if relativeMouseX >= scrollVerLeftBound && relativeMouseX <= scrollVerRightBound {
		if relativeMouseY >= scrollVerY && relativeMouseY <= scrollVerY + scrollVerHeight {
			scrollVerSelect = true;
			scrollVerSelectOff = relativeMouseY - scrollVerY;
		}
	}
}

// Deselect scroll bars
if mouse_check_button_released(mb_left) {
	scrollHorSelect = false;
	scrollVerSelect = false;
}

if scrollHorSelect {
// Drag horizontal scroll bar
	scrollHorX = relativeMouseX - scrollHorSelectOff;
	scrollHorPartition = (scrollHorX - scrollHorLeftBound) / (scrollHorRightBound - scrollHorLeftBound - scrollHorWidth) * 100;
	
	if scrollHorX < scrollHorLeftBound{
		scrollHorX = scrollHorLeftBound;
		scrollHorPartition = 0;
	}
	
	if scrollHorX > scrollHorRightBound - scrollHorWidth {
		scrollHorX = scrollHorRightBound - scrollHorWidth;
		scrollHorPartition = 100;
	}
} else {
	// Adapt to moving panel
	scrollHorX = scrollHorLeftBound + (scrollHorPartition / 100) * (scrollHorRightBound - scrollHorLeftBound - scrollHorWidth);
}

if scrollVerSelect {
	// Drag vertical scroll bar
	scrollVerY = relativeMouseY - scrollVerSelectOff;
	scrollVerPartition = (scrollVerY - scrollVerTopBound) / (scrollVerBotBound - scrollVerTopBound - scrollVerHeight) * 100;
	
	if scrollVerY < scrollVerTopBound || scrollVerHeight > panelHeight {
		scrollVerY = scrollVerTopBound;
		scrollVerPartition = 0;
	}
	
	if scrollVerY > scrollVerBotBound - scrollVerHeight {
		scrollVerY = scrollVerBotBound - scrollVerHeight;
		scrollVerPartition = 100;
	}
} else {
	// Adapt to moving panel
	// Top Boundary + Percentage * Bottommost Boundary for the top edge
	scrollVerY = scrollVerTopBound + (scrollVerPartition / 100) * (scrollVerBotBound - scrollVerTopBound - scrollVerHeight); // Net y coordinate of clickable scrollbar
}

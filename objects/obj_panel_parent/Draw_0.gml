/// @description Draw scroll bars

// Backdrop

// Horizontal bar
if hasScrollHor {
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound + scrollPanelSquish,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorTopBound,false); // Top line
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorBotBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound,false); // Bottom line
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorLeftBound + scrollPanelSquish,scrollHorBotBound,false); // Left line
	draw_rectangle(scrollHorRightBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound,false); // Right line
}

// Vertical bar
if hasScrollVer {
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerTopBound,false); // Top line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerBotBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Bottom line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerLeftBound + scrollPanelSquish,scrollVerBotBound,false); // Left line
	draw_rectangle(scrollVerRightBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Right line
}

// Scrollbar

// Horizontal bar
if hasScrollHor {
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,false); // Outside fill
	
	if scrollHorSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollHorX + scrollPanelSquish + 1,scrollHorTopBound + 1,scrollHorX + scrollHorWidth + scrollPanelSquish - 1,scrollHorBotBound - 1,false); // Inside fill
	
	draw_set_color(make_color_rgb(24,24,25));
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollPanelSquish,scrollHorTopBound,false); // Top left corner
	draw_rectangle(scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorTopBound,false); // Top right corner
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorBotBound,scrollHorX + scrollPanelSquish,scrollHorBotBound,false); // Bottom left corner
	draw_rectangle(scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,false); // Bottom right corner
}

if hasScrollVer {
	// Vertical bar
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Outside fill
	
	if scrollVerSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish + 1,scrollVerY + 1,scrollVerRightBound + scrollPanelSquish - 1,scrollVerY + scrollVerHeight - 1,false); // Inside fill
	
	draw_set_color(make_color_rgb(24,24,25));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY,scrollVerLeftBound + scrollPanelSquish,scrollVerY,false); // Top left corner
	draw_rectangle(scrollVerRightBound + scrollPanelSquish,scrollVerY,scrollVerRightBound + scrollPanelSquish,scrollVerY,false); // Top right corner
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY + scrollVerHeight,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Bottom left corner
	draw_rectangle(scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Bottom right corner
}

/// @description Insert description here
// Scrollbar backdrops
//if x < 1008 {
	// Horizontal bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound + scrollPanelSquish,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorTopBound,false); // Top line
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorBotBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound,false); // Bottom line
	draw_rectangle(scrollHorLeftBound + scrollPanelSquish,scrollHorTopBound,scrollHorLeftBound + scrollPanelSquish,scrollHorBotBound,false); // Left line
	draw_rectangle(scrollHorRightBound + scrollPanelSquish,scrollHorTopBound,scrollHorRightBound + scrollPanelSquish,scrollHorBotBound,false); // Right line
//}

//if x < 1023 {

	// Vertical bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerTopBound,false); // Top line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerBotBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Bottom line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerTopBound,scrollVerLeftBound + scrollPanelSquish,scrollVerBotBound,false); // Left line
	draw_rectangle(scrollVerRightBound + scrollPanelSquish,scrollVerTopBound,scrollVerRightBound + scrollPanelSquish,scrollVerBotBound,false); // Right line

//}

// Scrollbars
//if x < scrollHorLeftBound || x > scrollHorRightBound {
	// Horizontal bar
	if scrollHorSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,false); // Inside fill
	
	/*draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorTopBound,false); // Top line
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorBotBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,false); // Bottom line
	draw_rectangle(scrollHorX + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollPanelSquish,scrollHorBotBound,false); // Left line
	draw_rectangle(scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorTopBound,scrollHorX + scrollHorWidth + scrollPanelSquish,scrollHorBotBound,false); // Right line
	*/
//}
//if x < 1023 {

	// Vertical bar
	if scrollVerSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Inside fill
	
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY,scrollVerRightBound + scrollPanelSquish,scrollVerY,false); // Top line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY + scrollVerHeight,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Bottom line
	draw_rectangle(scrollVerLeftBound + scrollPanelSquish,scrollVerY,scrollVerLeftBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Left line
	draw_rectangle(scrollVerRightBound + scrollPanelSquish,scrollVerY,scrollVerRightBound + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Right line
//}

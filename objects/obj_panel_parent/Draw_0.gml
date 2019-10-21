/// @description Draw scroll bars

// Backdrop

if onBase != 2 {
	// Horizontal bar
	if scrollHorRightBound - scrollHorLeftBound > 0 {
		if hasScrollHor {
			draw_set_color(make_color_rgb(40,47,56));
			draw_rectangle(scrollHorLeftBound,scrollHorTopBound,scrollHorRightBound,scrollHorBotBound,false); // Inside fill
			
			draw_set_color(make_color_rgb(34,34,35));
			draw_rectangle(scrollHorLeftBound,scrollHorTopBound,scrollHorRightBound,scrollHorTopBound,false); // Top line
			draw_rectangle(scrollHorLeftBound,scrollHorBotBound,scrollHorRightBound,scrollHorBotBound,false); // Bottom line
			draw_rectangle(scrollHorLeftBound,scrollHorTopBound,scrollHorLeftBound,scrollHorBotBound,false); // Left line
			draw_rectangle(scrollHorRightBound,scrollHorTopBound,scrollHorRightBound,scrollHorBotBound,false); // Right line
		}
	}
	
	// Vertical bar
	if hasScrollVer {
		draw_set_color(make_color_rgb(40,47,56));
		draw_rectangle(scrollVerLeftBound,scrollVerTopBound,scrollVerRightBound,scrollVerBotBound,false); // Inside fill
		
		draw_set_color(make_color_rgb(34,34,35));
		draw_rectangle(scrollVerLeftBound,scrollVerTopBound,scrollVerRightBound,scrollVerTopBound,false); // Top line
		draw_rectangle(scrollVerLeftBound,scrollVerBotBound,scrollVerRightBound,scrollVerBotBound,false); // Bottom line
		draw_rectangle(scrollVerLeftBound,scrollVerTopBound,scrollVerLeftBound,scrollVerBotBound,false); // Left line
		draw_rectangle(scrollVerRightBound,scrollVerTopBound,scrollVerRightBound,scrollVerBotBound,false); // Right line
	}
	
	// Scrollbar
	
	// Horizontal bar
	if scrollHorRightBound - scrollHorLeftBound > 0 {
		if hasScrollHor {
			draw_set_color(make_color_rgb(34,34,35));
			draw_rectangle(scrollHorX,scrollHorTopBound,scrollHorX + scrollHorWidth,scrollHorBotBound,false); // Outside fill
			
			if scrollHorSelect {
				draw_set_color(make_color_rgb(232,180,89));
			} else {
				draw_set_color(make_color_rgb(78,80,82));
			}
			
			draw_rectangle(scrollHorX + 1,scrollHorTopBound + 1,scrollHorX + scrollHorWidth - 1,scrollHorBotBound - 1,false); // Inside fill
			
			draw_set_color(make_color_rgb(24,24,25));
			draw_rectangle(scrollHorX,scrollHorTopBound,scrollHorX,scrollHorTopBound,false); // Top left corner
			draw_rectangle(scrollHorX + scrollHorWidth,scrollHorTopBound,scrollHorX + scrollHorWidth,scrollHorTopBound,false); // Top right corner
			draw_rectangle(scrollHorX,scrollHorBotBound,scrollHorX,scrollHorBotBound,false); // Bottom left corner
			draw_rectangle(scrollHorX + scrollHorWidth,scrollHorBotBound,scrollHorX + scrollHorWidth,scrollHorBotBound,false); // Bottom right corner
		}
	}
	
	if hasScrollVer {
		// Vertical bar
		draw_set_color(make_color_rgb(34,34,35));
		draw_rectangle(scrollVerLeftBound,scrollVerY,scrollVerRightBound,scrollVerY + scrollVerHeight,false); // Outside fill
		
		if scrollVerSelect {
			draw_set_color(make_color_rgb(232,180,89));
		} else {
			draw_set_color(make_color_rgb(78,80,82));
		}
		
		draw_rectangle(scrollVerLeftBound + 1,scrollVerY + 1,scrollVerRightBound - 1,scrollVerY + scrollVerHeight - 1,false); // Inside fill
		
		draw_set_color(make_color_rgb(24,24,25));
		draw_rectangle(scrollVerLeftBound,scrollVerY,scrollVerLeftBound,scrollVerY,false); // Top left corner
		draw_rectangle(scrollVerRightBound,scrollVerY,scrollVerRightBound,scrollVerY,false); // Top right corner
		draw_rectangle(scrollVerLeftBound,scrollVerY + scrollVerHeight,scrollVerRightBound,scrollVerY + scrollVerHeight,false); // Bottom left corner
		draw_rectangle(scrollVerRightBound,scrollVerY + scrollVerHeight,scrollVerRightBound,scrollVerY + scrollVerHeight,false); // Bottom right corner
	}
}

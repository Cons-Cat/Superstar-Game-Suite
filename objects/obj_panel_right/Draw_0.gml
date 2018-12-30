/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,x,70,1024,506,x,0+70);

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(x-1,0+70,x-1,576,false); // draw_line() is buggier

// Scrollbar backdrops
if x < 1008 {
	// Horizontal bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(x-1 + scrollPanelSquish,0+70,1008 + scrollPanelSquish,0+85 + scrollPanelSquish,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(x-1,0+70,1008 + scrollPanelSquish,0+70,false); // Top line
	draw_rectangle(x-1 + scrollPanelSquish,0+85,1008 + scrollPanelSquish,0+85,false); // Bottom line
	draw_rectangle(x-1 + scrollPanelSquish,0+70,x-1 + scrollPanelSquish,0+85,false); // Left line
	draw_rectangle(1007 + scrollPanelSquish,0+70,1008 + scrollPanelSquish,0+85,false); // Right line
}

if x < 1023 {
	// Vertical bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(1008 + scrollPanelSquish,0+86,1024 + scrollPanelSquish,0+419,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(1008 + scrollPanelSquish,0+85,1024 + scrollPanelSquish,0+85,false); // Top line
	draw_rectangle(1008 + scrollPanelSquish,0+419,1024 + scrollPanelSquish,0+419,false); // Bottom line
	draw_rectangle(1008 + scrollPanelSquish,0+86,1008 + scrollPanelSquish,0+419,false); // Left line
	draw_rectangle(1024 + scrollPanelSquish,0+85,1024 + scrollPanelSquish,0+419,false); // Right line
}

// Scrollbars
if x < 1008 {
	// Horizontal bar
	if scrollHorSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollHorX + scrollPanelSquish,70,scrollHorX + scrollHorWidth + scrollPanelSquish,85,false); // Inside fill
	
	draw_rectangle(scrollHorX + scrollPanelSquish,70,scrollHorX + scrollHorWidth + scrollPanelSquish,70,false); // Top line
	draw_rectangle(scrollHorX + scrollPanelSquish,85,scrollHorX + scrollHorWidth + scrollPanelSquish,85,false); // Bottom line
	draw_rectangle(scrollHorX + scrollPanelSquish,70,scrollHorX + scrollPanelSquish,85,false); // Left line
	draw_rectangle(scrollHorX + scrollHorWidth + scrollPanelSquish,70,scrollHorX + scrollHorWidth + scrollPanelSquish,85,false); // Right line
}
if x < 1023 {
	// Vertical bar
	if scrollVerSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(1008 + scrollPanelSquish,scrollVerY,1024 + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Inside fill
	
	draw_rectangle(1008 + scrollPanelSquish,scrollVerY,1024 + scrollPanelSquish,scrollVerY,false); // Top line
	draw_rectangle(1008 + scrollPanelSquish,scrollVerY + scrollVerHeight,1024 + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Bottom line
	draw_rectangle(1008 + scrollPanelSquish,scrollVerY,1008 + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Left line
	draw_rectangle(1024 + scrollPanelSquish,scrollVerY,1024 + scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Right line
}

draw_self();

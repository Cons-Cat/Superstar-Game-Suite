/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,0,0,x-0,506,0,0+70);

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(x,0+70,x,0+576,false); // draw_line() is buggier

// Scrollbar backdrops
if x > 16 {
	// Horizontal bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(15 - scrollPanelSquish,0+70,x - scrollPanelSquish,0+85 - scrollPanelSquish,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(15,0+70,x - scrollPanelSquish,0+70,false); // Top line
	draw_rectangle(15 - scrollPanelSquish,0+85,x - scrollPanelSquish,0+85,false); // Bottom line
	draw_rectangle(15 - scrollPanelSquish,0+70,15 - scrollPanelSquish,0+85,false); // Left line
	draw_rectangle(x - scrollPanelSquish,0+70,x - scrollPanelSquish,0+85,false); // Right line
}
if x > 1 {
	// Vertical bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(0,0+86,0+15 - scrollPanelSquish,0+419,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(0,0+85,0+15 - scrollPanelSquish,0+85,false); // Top line
	draw_rectangle(0,0+419,0+15 - scrollPanelSquish,0+419,false); // Bottom line
	draw_rectangle(0,0+86,0 - scrollPanelSquish,0+419,false); // Left line
	draw_rectangle(0+15 - scrollPanelSquish,0+86,0+15 - scrollPanelSquish,0+419,false); // Right line
}

// Scrollbars
if x > 16 {
	// Horizontal bar
	if scrollHorSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(scrollHorX - scrollPanelSquish,70,scrollHorX + scrollHorWidth - scrollPanelSquish,85,false); // Inside fill
	
	draw_rectangle(scrollHorX - scrollPanelSquish,70,scrollHorX + scrollHorWidth - scrollPanelSquish,70,false); // Top line
	draw_rectangle(scrollHorX - scrollPanelSquish,85,scrollHorX + scrollHorWidth - scrollPanelSquish,85,false); // Bottom line
	draw_rectangle(scrollHorX - scrollPanelSquish,70,scrollHorX - scrollPanelSquish,85,false); // Left line
	draw_rectangle(scrollHorX + scrollHorWidth - scrollPanelSquish,70,scrollHorX + scrollHorWidth - scrollPanelSquish,85,false); // Right line
}
if x > 1 {
	// Vertical bar
	if scrollVerSelect {
		draw_set_color(make_color_rgb(232,180,89));
	} else {
		draw_set_color(make_color_rgb(78,80,82));
	}
	
	draw_rectangle(0,scrollVerY,15 - scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Inside fill
	
	draw_rectangle(0,scrollVerY,15 - scrollPanelSquish,scrollVerY,false); // Top line
	draw_rectangle(0,scrollVerY + scrollVerHeight,15 - scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Bottom line
	draw_rectangle(0,scrollVerY,0 - scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Left line
	draw_rectangle(15 - scrollPanelSquish,scrollVerY,15 - scrollPanelSquish,scrollVerY + scrollVerHeight,false); // Right line
}

draw_self();

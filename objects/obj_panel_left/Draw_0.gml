/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,0,0,x-0,350,0,0+70);

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(x,0+69,x,0+419,false); // draw_line() is buggier

// Scrollbar backdrops
if x > 0 + 16 {
	// Horizontal bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(0,0+69,x,0+84,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(0,0+69,x,0+70,false); // Top line
	draw_rectangle(0,0+84,x,0+84,false); // Bottom line
	draw_rectangle(0,0+69,0,0+84,false); // Left line
	draw_rectangle(x,0+69,x,0+84,false); // Right line
	
	// Vertical bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(0,0+86,0+15,0+419,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(0,0+85,0+15,0+85,false); // Top line
	draw_rectangle(0,0+419,0+15,0+419,false); // Bottom line
	draw_rectangle(0,0+86,0,0+419,false); // Left line
	draw_rectangle(0+15,0+86,0+15,0+419,false); // Right line
}

draw_self();

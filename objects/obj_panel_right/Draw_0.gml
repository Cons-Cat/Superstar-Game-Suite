/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,x,70,1024,350,x,0+70);

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(x-1,0+70,x-1,0+419,false); // draw_line() is buggier

// Scrollbar backdrops
if x < 0 + 1008 {
	// Vertical bar
	draw_set_color(make_color_rgb(40,47,56));
	draw_rectangle(0+1008,0+69,0+1024,0+419,false); // Inside fill
	
	draw_set_color(make_color_rgb(34,34,35));
	draw_rectangle(0+1008,0+69,0+1024,0+69,false); // Top line
	draw_rectangle(0+1008,0+419,0+1024,0+419,false); // Bottom line
	draw_rectangle(0+1008,0+69,0+1009,0+419,false); // Left line
	draw_rectangle(0+1024,0+69,0+1024,0+419,false); // Right line
}

draw_self();

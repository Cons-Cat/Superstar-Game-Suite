/// @description 
draw_set_alpha(1);
draw_set_color(c_red);

if DRAWANGLE != -1 {
	draw_line(x, y, x + lengthdir_x(40, DRAWANGLE), y + lengthdir_y(40, DRAWANGLE));
}

/// @description Debug drawing.
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,c_purple,0.5);
var i = 0;

draw_set_alpha(0.85);
while (true) {
	show_debug_message("I: ");
	if lineX1[i] != -1 {
		show_debug_message(i);
		draw_set_color(c_blue);
		draw_line(lineX1[i],lineY1[i],lineX2[i],lineY2[i]);
		i++;
	} else {
		break;
	}
}
draw_set_alpha(1);

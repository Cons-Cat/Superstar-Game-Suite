/// @description 
draw_set_alpha(0.45);
draw_set_color(c_aqua);

for(i = 0; i < DRAWC; i++) {
	draw_rectangle(DRAWX[i],DRAWY[i],DRAWX[i],DRAWY[i],false);
}

draw_set_alpha(1);

/// @description 
draw_set_alpha(0.45);
draw_set_color(c_yellow);
draw_line(collX1,collY1,collX2,collY2);

draw_set_color(col);

for(i = 0; i < DRAWC; i++) {
	draw_rectangle(DRAWX[i],DRAWY[i],DRAWX[i],DRAWY[i],false);
}

draw_set_alpha(1);

/// @description 
draw_set_alpha(0.4);
draw_set_color(c_blue);

draw_rectangle(x,y,x+sprite_width*image_xscale,y+sprite_height*image_yscale,false);

draw_set_alpha(1);
draw_set_color(c_aqua);

for(i = 0; i < DRAWC; i++) {
	draw_rectangle(DRAWX[i],DRAWY[i],DRAWX[i],DRAWY[i],false);
}

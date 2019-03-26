/// @description Insert description here
draw_self();
draw_set_font(font);

if gone {
	// Draw backdrops
	if select {
		draw_rectangle_color(x-12,y-14,x+12,y-5,gray,gray,gray,gray,false);
		
		col = orange;
	} else {
		draw_rectangle_color(x-12,y-14,x+12,y-5,dorange,dorange,dorange,dorange,false);
		
		col = c_white;
	}
	
	// Draw label
	draw_set_color(col);
	draw_text(x-11,y-13,arbitraryInd);
}

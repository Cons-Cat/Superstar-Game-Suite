/// @description Insert description here
draw_self();
draw_set_font(font);

if gone {
	// Draw backdrops
	if slowSpd {
		draw_rectangle_color(x-16,y-25,x+15,y-16,dorange,dorange,dorange,dorange,false);
		
		col[0] = orange;
		col[1] = c_white;
	} else {
		draw_rectangle_color(x-16,y-14,x+15,y-5,dorange,dorange,dorange,dorange,false);
		
		col[0] = c_white;
		col[1] = orange;
	}
	
	// Draw labels
	draw_set_color(col[0]);
	draw_text(x-15,y-25,"Walk");
	
	draw_set_color(col[1]);
	draw_text(x-15,y-14,"Run");
}

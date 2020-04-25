/// @description 
if gone {
	scr_draw_button_edit(x, y, x + sprWidth, y + 30, selectState);
	
	// Button
	draw_set_color(col[3]); // Text label
	draw_set_font(font);
	draw_text_transformed(x+6,y+7,label,2,2,0);
}

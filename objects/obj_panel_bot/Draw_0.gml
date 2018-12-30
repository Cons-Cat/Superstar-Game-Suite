/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,192,y+20,641,576-y,192,y+20);
//draw_sprite_part(spr_editor_gui_bot,0,0,0,1024,576-y,0,y);

// Corners
draw_set_color(make_color_rgb(35,34,45));
draw_rectangle(3,y+4,3+187,576,false);
draw_rectangle(834,y+4,834+187,576,false);

// Outlines
if y < 576 {
	draw_set_color(make_color_rgb(63,70,87));
	draw_rectangle(0,y,1024,y,false);
	
	draw_set_color(make_color_rgb(28,30,36));
	draw_rectangle(0,y+1,1024,575,true);
	draw_rectangle(1,y+2,1023,574,true);
	
	draw_set_color(make_color_rgb(31,34,40));
	draw_rectangle(2,y+3,1022,573,true);
	draw_rectangle(191,y+3,190+643,573,true);
	
	draw_set_color(make_color_rgb(38,43,50));
	draw_rectangle(6,y+29,187,y+31,false);
	draw_set_color(make_color_rgb(30,32,37));
	draw_rectangle(6,y+32,187,y+33,false);
}

draw_self();

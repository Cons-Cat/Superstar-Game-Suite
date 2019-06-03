/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,scrollVerRightBound,scrollVerTopBound,(scrollHorRightBound-scrollVerRightBound)+1
,(scrollVerBotBound-scrollVerTopBound)+1,scrollVerRightBound,scrollVerTopBound);
event_inherited();

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(scrollVerLeftBound,scrollVerTopBound-6,scrollHorRightBound,scrollVerTopBound-1,false);

draw_set_color(make_color_rgb(31,34,40));
draw_rectangle(room_width + 2,y,scrollHorRightBound,y+2,false);

draw_set_color(make_color_rgb(28,30,36));
draw_rectangle(room_width,y,scrollHorRightBound,y,false);
draw_rectangle(room_width,y+3,scrollHorRightBound,y+3,false);
draw_rectangle(room_width,y+1,room_width + 1,y+2,false);

draw_set_color(make_color_rgb(35,38,45));
draw_rectangle(room_width + 3,y+2,scrollHorRightBound-1,y+2,false);

// Structured to fix an issue with horizontal dragging
if scrollHorRightBound - room_width > 136 {
	draw_sprite_ext(sprite_index,image_index,x,y+mousePeek,image_xscale,image_yscale,image_angle,c_white,image_alpha);
} else {
	draw_sprite_ext(sprite_index,image_index,scrollHorRightBound - 60,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
}

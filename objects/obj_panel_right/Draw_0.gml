/// @description Insert description here
draw_sprite_part(spr_editor_gui_streaks,0,x,70,1024,506,x,0+70);
event_inherited();

// Edge
draw_set_color(make_color_rgb(63,70,87));
draw_rectangle(x-1,0+70,x-1,576,false); // draw_line() is buggier

draw_self();

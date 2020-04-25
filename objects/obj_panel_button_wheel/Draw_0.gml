/// @description 
event_inherited();

// Wheel graphic
if angle != -1 {
	draw_set_color(perimeterCol);
	draw_line(x+sprWidth+4+w/2,y-1+h/2,x+sprWidth+4+w/2+lengthdir_x(14,angle),y-1+h/2+lengthdir_y(14,angle));
}

draw_sprite(spr_editor_region_wheel,1,x+sprWidth+2+w/2,y-1+h/2);

if angle != -1 {
	draw_set_color(graphicCol2);
	draw_line(x+sprWidth+3+w/2,y-1+h/2,x+sprWidth+3+w/2+lengthdir_x(15,angle),y-1+h/2+lengthdir_y(15,angle));
	draw_set_color(graphicCol1);
	draw_line(x+sprWidth+2+w/2,y-1+h/2,x+sprWidth+2+w/2+lengthdir_x(15,angle),y-1+h/2+lengthdir_y(15,angle));
}

draw_sprite(spr_editor_region_wheel,0,x+sprWidth+2+w/2,y-1+h/2);

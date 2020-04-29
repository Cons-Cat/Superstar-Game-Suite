/// @description 
event_inherited();

// Icon display
draw_set_color(perimeterCol);
draw_rectangle(x+sprWidth+6,y-1,x+sprWidth+32,y-1,false);
draw_rectangle(x+sprWidth+6,y+30,x+sprWidth+32,y+30,false);
draw_rectangle(x+sprWidth+3,y,x+sprWidth+3,y+29,false);
draw_rectangle(x+sprWidth+34,y,x+sprWidth+34,y+29,false);

draw_set_color(perimeterInsideCol);
draw_rectangle(x+sprWidth+4,y,x+sprWidth+33,y+29,false);

draw_set_color(graphicFillOutsideCol);
draw_rectangle(x+sprWidth+5,y+1,x+sprWidth+32,y+28,false);

draw_set_color(graphicFillInsideCol);
draw_rectangle(x+sprWidth+6,y+2,x+sprWidth+31,y+27,false);

draw_sprite(spr_preview_corner,0,x+sprWidth+6,y+2); // Corners
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+32,y+2,-1,1,0,c_white,1);
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6,y+28,1,-1,0,c_white,1);
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+32,y+28,-1,-1,0,c_white,1);

draw_sprite(sprite_index,0,x+sprWidth+19,y+27);

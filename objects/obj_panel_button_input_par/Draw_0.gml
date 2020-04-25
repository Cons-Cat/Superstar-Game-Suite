/// @description 
event_inherited();

// Value / String display
draw_set_color(perimeterCol);
draw_rectangle(x+sprWidth+6,y-1,x+sprWidth+6+valueLength,y-1,false);
draw_rectangle(x+sprWidth+6,y+30,x+sprWidth+6+valueLength,y+30,false);
draw_rectangle(x+sprWidth+3,y,x+sprWidth+3,y+29,false);
draw_rectangle(x+sprWidth+8+valueLength,y,x+sprWidth+8+valueLength,y+29,false);

draw_set_color(perimeterInsideCol);
draw_rectangle(x+sprWidth+4,y,x+sprWidth+7+valueLength,y+29,false);

draw_set_color(graphicFillOutsideCol);
draw_rectangle(x+sprWidth+5,y+1,x+sprWidth+6+valueLength,y+28,false);

draw_set_color(graphicFillInsideCol);
draw_rectangle(x+sprWidth+6,y+2,x+sprWidth+5+valueLength,y+27,false);

draw_sprite(spr_preview_corner,0,x+sprWidth+6,y+2); // Corners
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6+valueLength,y+2,-1,1,0,c_white,1);
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6,y+28,1,-1,0,c_white,1);
draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6+valueLength,y+28,-1,-1,0,c_white,1);

draw_set_font(obj_editor_gui.font);
draw_set_color(col[3]);
draw_text_transformed(x+sprWidth+7,y+7,arbitraryVal,2,2,0);

/// @description 
draw_set_color(colZ);

draw_rectangle(x+2,y+2,x+sprite_width-2,y+sprite_height-2,false);

draw_set_font(obj_editor_gui.fontDark);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_text_transformed(x+sprite_width/2,y+sprite_height/2+2,z,2,2,0);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_self();

// Draw outline
/*
draw_sprite(spr_button_corner,1,x+2,y+2);
draw_sprite_ext(spr_button_corner,1,x-2+buttonWidth,y+2,-1,1,0,c_white,1);
draw_sprite_ext(spr_button_corner,1,x+2,y+buttonHeight-2,1,-1,0,c_white,1);
draw_sprite_ext(spr_button_corner,1,x-2+buttonWidth,y+buttonHeight-2,-1,-1,0,c_white,1);
*/

draw_sprite(spr_arrow_editor_up,arrowLeftSub,x-25,y+1);
draw_sprite(spr_arrow_editor_down,arrowRightSub,x+52,y+1);

/// @description Insert description here
draw_set_font(font);
draw_set_color(c_white);
draw_sprite(sprite_index,image_index,x,y);

// Fill
draw_sprite_ext(spr_chat_outline_white,4,x,y+10-45,6,3,0,c_white,1);
draw_sprite_ext(spr_chat_outline_white,4,x,y+10-45,4,4,0,c_white,1);
draw_sprite(spr_chat_fill,0,x-25+1,y+10-60+1);
draw_sprite(spr_chat_fill,2,x+25-1,y+10-60+1);

draw_sprite(spr_chat_fill,6,x-25+1,y+10-30-1);
draw_sprite(spr_chat_fill,8,x+25-1,y+10-30-1);

// Color outline
draw_sprite(spr_chat_outline_white,0,x-25,y+10-60);
draw_sprite_ext(spr_chat_outline_white,1,x,y+10-60,4,1,0,c_white,1);
draw_sprite(spr_chat_outline_white,2,x+25,y+10-60);

draw_sprite_ext(spr_chat_outline_white,3,x-25,y+10-45,1,2,0,c_white,1);
draw_sprite_ext(spr_chat_outline_white,5,x+25,y+10-45,1,2,0,c_white,1);

draw_sprite(spr_chat_outline_white,6,x-25,y+10-30);
draw_sprite_ext(spr_chat_outline_white,7,x,y+10-30,4,1,0,c_white,1);
draw_sprite(spr_chat_outline_white,8,x+25,y+10-30);

// Dark outline
draw_sprite(spr_chat_outline_dark,0,x-25,y+10-60);
draw_sprite(spr_chat_outline_dark,2,x+25,y+10-60);

draw_sprite(spr_chat_outline_dark,6,x-25,y+10-30);
draw_sprite(spr_chat_outline_dark,8,x+25,y+10-30);

// Draw text
draw_set_halign(fa_center);
draw_text(x,y+10-60,"Zoom");

draw_set_color(orange);
draw_text(x,y-30,zoomVal);

draw_set_halign(fa_left);
draw_set_color(c_white);

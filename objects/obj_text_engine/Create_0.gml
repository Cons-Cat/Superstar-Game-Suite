/// @description Initialize variables
message_draw = "";
current = 0;
message_end = 0;
characters = 0;
increase = 2;
message_current = 0;
message[0] = "Test Text message, ! aSdF ...";
font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._ 1234567890",true,1);
draw_set_font(font);
_A = ord("Z");
freeDecay = 0;

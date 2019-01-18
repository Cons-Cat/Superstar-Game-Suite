/// @description Initialize variables
message_draw = "";
increase = 2;

message_current = 0;
message_length = 1; // Initialized as an arbitrary value greater than 0
message_end = 0;
current = 0;
rowCurrent = 0;
characters[rowCurrent] = 0;

font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._ 1234567890",true,1);
_A = ord("Z");

freeDecay = 0;

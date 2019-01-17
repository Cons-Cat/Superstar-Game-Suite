/// @description Initialize values
canDrag = false;
canClose = false;

width = 6;
height = 3;

placex = xstart - width*5 + 10;
placey = ystart - height*5;

blue = make_color_rgb(54,70,128);
orange = make_color_rgb(255,160,64);

outlineColor = c_white;
corner = 8;
select[0] = false;
selectCol[0] = blue;
select[1] = false;
selectCol[1] = blue;
select[2] = false;
selectCol[2] = blue;
select[3] = false;
selectCol[3] = blue;
select[4] = false;

textRows = 0;
canSelectTextRow[0] = false;
selectTextRow[0] = false;
str[0] = "";

font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._ 1234567890|",true,1);
alarm[0] = 10;
obj_trigger_dialogue_region_editor.canDeSelect = false;

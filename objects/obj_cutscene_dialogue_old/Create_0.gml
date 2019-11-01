/// @description Initialize values
canDrag = false;
canClose = false;

blue = make_color_rgb(54,70,128);
orange = make_color_rgb(255,160,64);
dorange = make_color_rgb(58,41,25);

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
canInputEnter = true;
str[0] = "";

font = obj_editor_gui.font;
alarm[0] = 10;
obj_trigger_region_parent.canDeSelect = false;

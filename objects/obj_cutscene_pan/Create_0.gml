/// @description Initialize variables
canDrag = true;
canPlace = false;
canDel = false;
canRelease = false;
mouseHover = false;
mouseXOff = 0;
mouseYOff = 0;
decimalPlace = -1;

gone = false;
gray = make_color_rgb(102,102,102);
orange = make_color_rgb(255,160,64);

font = obj_editor_gui.font;
obj_trigger_region_parent.canDeSelect = false;

image_speed = 0;

/// @description 
subPointDisplacement = 0;
col = make_color_rgb(200,210,243); // Cute blue-ish
orange = make_color_rgb(255,160,64); // Light orange

list[0,0] = "layer_" + string(0);
list[0,1] = "";
subType[0,1] = 0; // Clipping mask
select[0,0] = false;
select[0,1] = false;
canSelect[0,0] = false;
canSelect[0,1] = false;

eyeState[0] = 0;
eyeCol[0] = col;
plusCol = col;
dieCol = col;

depth = -1;

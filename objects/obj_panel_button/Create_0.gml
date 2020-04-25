/// @description Insert description here
select = false;
canSelect = false;
canRelease = false;
imgIndex = 0;
gone = false;
selectState = 0;

trg = -1;
label = "";

relativeMouseX = -1;
relativeMouseY = -1;

// Dimensions
sortX = 0;
sortY = 0;
sprWidth = -1;
longestSprWidth = -1;
sprHeight = 30;
width = -1;

// Colors
insideCol = make_color_rgb(255,160,64); // Light orange
perimeterCol = make_color_rgb(63,70,87); // Light gray
perimeterInsideCol = make_color_rgb(28,30,36); // Very dark gray
graphicFillInsideCol = make_color_rgb(35,38,45); // Mid-tone gray
graphicFillOutsideCol = make_color_rgb(31,34,40); // Dark gray
graphicCol1 = make_color_rgb(200,210,243);
graphicCol2 = make_color_rgb(147,155,179);

font = obj_editor_gui.font;

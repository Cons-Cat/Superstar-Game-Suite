/// @description Insert description here
select = false;
canRelease = false;
objIndex = -1;
imgIndex = 0;
gone = false;
selectState = 0;

relativeMouseX = -1;
relativeMouseY = -1;

// Dimensions
sortX = 0;
sortY = 0;
sprWidth = -1;
longestSprWidth = -1;
sprHeight = 30;
width = -1;

// Data
label = "";
buttonType = 0; // 0 is a generic button, 1 is a wheel button, 2 is a value input button
angle = -1;
decimalPlace = -1;

// Colors
insideCol = make_color_rgb(255,160,64); // Light orange
perimeterCol = make_color_rgb(63,70,87); // Light gray
perimeterInsideCol = make_color_rgb(28,30,36); // Very dark gray
graphicFillInsideCol = make_color_rgb(35,38,45); // Mid-tone gray
graphicFillOutsideCol = make_color_rgb(31,34,40); // Dark gray
graphicCol1 = make_color_rgb(200,210,243);
graphicCol2 = make_color_rgb(147,155,179);

font = obj_editor_gui.font;

// Update the right panel
obj_panel_right.calculateWidth = true;
obj_panel_left.calculateWidth = true;
// The right panel makes these buttons visible once it has updated

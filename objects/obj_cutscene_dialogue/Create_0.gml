/// @description Initialize values
event_inherited();

obj_trigger_region_parent.canDeSelect = false;

// Cursor values
cursorPlaceChar = -1; // Off of a bubble
cursorPlacePix = 0;
cursorBubble = -1;
cursorPlaceLine = -1;
cursorState = -1;
/*
-1 is an inactive state
0 is an idle state
1 is a multi-select state
*/
tempCursorPlaceChar = -1;
cursorPlaceSelectionLine = -1;
deleteLines = false;

// Dialogue bubble values
bubbleCount = 0; // 0 is a single bubble
bubbleX[bubbleCount] = 0;
bubbleY[bubbleCount] = 0;
lineCount[bubbleCount] = 0; // 0 is a single line
lineStr[bubbleCount,0] = "Text";
longestLine[bubbleCount] = 0;
selectBubSlider[0,0] = false;
selectBubSlider[0,1] = false;
selectBubSlider[0,2] = false;
selectBubSlider[0,3] = false;
sliderMagnitude[0,0] = 0;
sliderMagnitude[0,1] = 0;
sliderMagnitude[0,2] = 0;
sliderMagnitude[0,3] = 0;
someSliderSelected = false;
waviesCount[bubbleCount] = 0; // No wavies initially

// Box Values
boxWidth = 70;
boxHeight = 70;
placeX = x;
placeY = y;
placeXOff = 0;
placeYOff = 0;
canDelete = false;
canSelectBox = false;
diaSurface = surface_create(boxWidth,boxHeight);
remakeSurface = true;
surfaceScrollOff = 0;

// Scrollbar values
hasScrollHor = false;

// Colors
col[0] = make_color_rgb(28,30,36); // Dark
col[1] = make_color_rgb(63,70,87); // Medium
col[2] = make_color_rgb(200,210,243); // Bright
col[3] = make_color_rgb(117,73,71); // Dark highlight
col[4] = make_color_rgb(232,180,89); // Bright highlight

outlineCol[0] = col[1]; // Outside outline
outlineCol[1] = col[3]; // Inside outline

font = obj_editor_gui.font;

// Buttons
buttonsAnchorRight = true;

buttonsBoundBot = 0;
buttonsBoundLeft = 0;
buttonsBoundRight = 0;

buttonSelected = -1; // No button has been selected

buttonSprite[0,0] = spr_dia_button_bubble;
buttonSprite[1,0] = spr_dia_button_color;
buttonSprite[0,1] = spr_dia_button_pause;
buttonSprite[1,1] = spr_dia_button_speed;
buttonSprite[0,2] = spr_dia_button_wavy;
buttonSprite[1,2] = spr_dia_button_shake;
buttonSprite[0,3] = spr_dia_button_impact;
buttonSprite[1,3] = spr_dia_button_wave;

for (i = 0; i <= 1; i += 1) {
	for (j = 0; j <= 3; j += 1) {
		canSelectButtonState[i,j] = 0;
	}
}

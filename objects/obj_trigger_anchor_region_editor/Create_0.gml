/// @description Initialize values
event_inherited();

str = "anchorScene";
blankCol = make_color_rgb(226,99,144);
modeForSelectVal = 4;

width = 1;
height = 1;

minorRadius = 2.5 * 20;
majorRadius = 2 * 20;
thresholdRadius = 1;
angle = 0;
zoomVal = 100;

canSelect = false;
select = 0;
placed = 0;
buttonSelected = 0;
depthIterate = 0;
anchorId = -1;
valueButtonsExist = false;

// Instance IDs
instId1[0] = "inst_"; // Instance object
instId2 = "";
instId3 = "XXXXXXXXXX"; // Object id
instId4[0] = "XXXXXXXXXX";

//for (i = 0; i < 8; i += 1) {
instId1[0] = instId1[0] + string_upper(choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"));
//}
for (i = 0; i < 36; i += 1) {
	if i = 8 || i = 13 || i = 18 || i = 23 {
		instId2 = instId2 + "-";
	} else {
		instId2 = instId2 + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
	}
}

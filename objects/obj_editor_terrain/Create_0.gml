/// @description 
event_inherited();

str = "rectangle";
tileLayer[0,0] = "layer_0";
tileLayer[0,1] = "";
tileRowWidth = 0;
calculateSub = true;
layerType[0] = 0;
surfaceResize = true; // Initialize surfaces
marbleLostResize = false; // If the marble is deleted when resizing the window

grid = -1;
marbleNetPixels = 0;
marbleSampleGirth[marbleNetPixels] = 0;
edgeStreakCountRead = 0;
transfusedDistributionX[edgeStreakCountRead] = -1;
transfusedDistributionY[edgeStreakCountRead] = -1;
genMarble = false;
bakeMarble = false;

hasAdjacentLeft = false;
hasAdjacentRight = false;

// Marble colors ( lightest to darkest )
marbleCol[0] = make_color_rgb(242,242,242);
marbleCol[1] = make_color_rgb(197,198,197);
marbleCol[2] = make_color_rgb(183,183,183);
marbleCol[3] = make_color_rgb(160,160,160);
marbleCol[4] = make_color_rgb(145,146,150);
marbleCol[5] = make_color_rgb(132,134,137);
marbleCol[6] = make_color_rgb(119,119,122);
marbleCol[7] = c_red;

// Graphics IDs
instId1[0] = "inst_"; // Graphics
instId1[1] = "inst_"; // Front collision
instId1[2] = "inst_"; // Left collision
instId1[3] = "inst_"; // Right collision
instId1[4] = "inst_"; // Back collision
instId1[5] = "inst_"; // Floor collision

instId2 = "";
for (j = 0; j <= 5; j += 1) {
	for (i = 0; i < 8; i += 1) {
		instId1[j] = instId1[j] + string_upper(choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"));
	}
}
for (i = 0; i < 36; i += 1) {
	if i = 8 || i = 13 || i = 18 || i = 23 {
		instId2 = instId2 + "-";
	} else {
		instId2 = instId2 + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
	}
}

// Collision IDs
for (j = 0; j <= 4; j += 1) {
	instId5[j] = "";
	for (i = 0; i < 36; i += 1) {
		if i = 8 || i = 13 || i = 18 || i = 23 {
			instId5[j] = instId5[j] + "-";
		} else {
			instId5[j] = instId5[j] + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
		}
	}
}

instId3 = "4294967295";
instId4[0] = "4d894d20-7ef3-4868-826d-3356487fbbc2"; // Graphics terrain object id
instId4[1] = "cdd62787-d73e-485d-aa29-b8d49f1489ab"; // Floor terrain object id
instId4[2] = "2ee9b48f-4b2a-4948-9a19-984d206ab55b"; // Front/Back collision object id
instId4[3] = "1c492275-c3f6-4819-8e63-c11675f1c0b7"; // Side collision object id

canMerge = true;

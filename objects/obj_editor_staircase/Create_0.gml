/// @description 
event_inherited();

str = "staircase";

zfloor = 0;
zIterate = 0;
widthIterate = 0;
heightIterate = 0;

staircaseType = 1;
/*
0 = 1x1x1 staircase
1 = 2x1x1 staircase
2 = 1x1x2 staircase
*/
staircaseRotation = 2;
/*
0 = face left
1 = face up
2 = face right
3 = face down-right-right
4 = face down-right
5 = face down-down-right
6 = face down
7 = face down-down-left
8 = face down-left
9 = face down-left-left
*/
xOrigin = 0;
yOrigin = 0;
sprCreate[0] = spr_slopeL_1x_bot;
sprCreate[1] = spr_slopeR_1x_bot;
sprCreate[2] = spr_slopeR_1x;
sprCreate[3] = spr_slopeL_1x;

slopeOriginOffsetX = 0;
slopeOriginOffsetY = 0;

/*dummyTop = instance_create_layer(x,y,layer,obj_editor_slope3_dummy_top);
dummyBot = instance_create_layer(x,y,layer,obj_editor_slope3_dummy_bot);
dummyTop.trg = self.id;
dummyBot.trg = self.id;
slope3MustUpdate = false;*/

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

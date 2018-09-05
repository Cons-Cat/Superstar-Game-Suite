/// @description 
width = 1;
height = 1;
mirror = false;
str = "slope1";

if obj_tile_z.z >= 0 {
	zfloor = obj_tile_z.z+1;
	zcieling = obj_tile_z.z;
} else {
	zfloor = 0;
	zcieling = 0;
}
select = 0;
placed = 0;
buttonSelected = 0;

col[0] = make_color_rgb(210,74,84); // Red
col[1] = make_color_rgb(212,106,55); // Dark orange
col[2] = make_color_rgb(209,160,75); // Light orange
col[3] = make_color_rgb(148,175,65); // Dark green
col[4] = make_color_rgb(177,209,75); // Light green
col[5] = make_color_rgb(0,184,132); // Teal
col[6] = make_color_rgb(64,139,209); // Blue
col[7] = make_color_rgb(147,71,198); // Purple
col[8] = make_color_rgb(225,86,204); // Pink

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

// Tile array values
resetArray = true;
tileArray[0,0] = 0;
sprMaterialDirectoryLoad = false;
sprMaterialDirectory = ""; // Must be a file directory
sprMaterial = spr_tls_rectangle_default;
tileArrayDrawX[0,0] = 0;
tileArrayDrawY[0,0] = 0;
paintSelected = false;
canSelect = false;
depthIterate = 0;
alarm[0] = 2;

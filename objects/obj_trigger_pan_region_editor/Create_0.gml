/// @description Initialize values
event_inherited();

str = "panScene";
blankCol = make_color_rgb(226,99,144);
modeForSelectVal = 4;

width = 1;
widthTemp = width;
height = 1;
angleVal = 0;

polygon = -1;
//polygonOutside = -1;
recalculate = true;
broken = true;
list = ds_list_create();
/*list2 = ds_list_create();
xVertexExtreme[0] = -1; // Leftmost vertex
xVertexExtreme[1] = -1; // Rightmost vertex
yVertexExtreme[0] = -1; // Topmost vertex
yVertexExtreme[1] = -1; // Bottommost vertex
resultantX[0] = x;
resultantY[0] = y;
resultantX[2] = x;
resultantY[2] = y;*/

if obj_tile_z.z >= 0 {
	zfloor = obj_tile_z.z;
	zcieling = obj_tile_z.z;
} else {
	zfloor = 0;
	zcieling = 0;
}

canSelect = false;
select = 0;
placed = 0;
buttonSelected = 0;
depthIterate = 0;
canSpawnButtons = false;

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

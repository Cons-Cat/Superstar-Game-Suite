/// @description Initialize values
str = "moveScene";

width = 1;
height = 1;

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

rows = 1;
rowSetting[1] = 0;
selectNumCol[0] = c_white;
selectNumCol[1] = c_white;
selectButTimelineCol[0] = c_white;
selectButTimelineCol[1] = c_white;

// Graphics IDs
instId1 = "inst_"; // Instance object
instId2 = "";
instId3 = "XXXXXXXXXX"; // Object id

for (i = 0; i < 8; i += 1) {
	instId1 = instId1 + string_upper(choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"));
}
for (i = 0; i < 36; i += 1) {
	if i = 8 || i = 13 || i = 18 || i = 23 {
		instId2 = instId2 + "-";
	} else {
		instId2 = instId2 + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
	}
}

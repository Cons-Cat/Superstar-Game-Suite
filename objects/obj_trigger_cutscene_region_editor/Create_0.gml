/// @description Initialize values
event_inherited();

str = "moveScene";
blankCol = make_color_rgb(101,168,196);
modeForSelectVal = 4;

width = 1;
height = 1;

polygon = -1;
recalculate = false;
broken = true;
list = ds_list_create();

buttonSelected = 0;
depthIterate = 0;

// Cutscene values
trgGone = false;
totalActions[0] = 0;
longestRowLength = 0;
actorRowTxt[0] = "obj_player";

for (i = 0; i < instance_number(obj_npc_editor) + 1; i += 1) {
	rowLength[i] = 0;
}

// Instance IDs
instId1[0] = "inst_"; // Instance object
instId2 = "";
instId3 = "XXXXXXXXXX"; // Object id
instId4[0] = "XXXXXXXXXX";

for (i = 0; i < 8; i += 1) {
	instId1[0] = instId1[0] + string_upper(choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"));
}
for (i = 0; i < 36; i += 1) {
	if i = 8 || i = 13 || i = 18 || i = 23 {
		instId2 = instId2 + "-";
	} else {
		instId2 = instId2 + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
	}
}

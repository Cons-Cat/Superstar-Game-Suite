/// @description Initialize values
event_inherited();

str = "actor";
modeForSelectVal = 4;

width = 1;
height = 1;

canSelect = false;
select = 0;
placed = 0;
buttonSelected = 0;
depthIterate = 0;

floorTrg = 0;
trgFinal = obj_editor_terrain;
trgFinalTemp = -1;
platOn = 0;

blankCol = make_color_rgb(249,238,132);
orangeAnyways = false;

// Cutscene values
trgGone = false;
totalActions = 0;
longestRowLength = 0;
npcIdVal = instance_number(obj_npc_position);

with obj_trigger_region_parent {
	rowLength[instance_number(obj_npc_position)] = 0;
}

for (i = 0; i < instance_number(obj_npc_position) + 1; i += 1) {
	rowLength[i] = 0;
}

// Graphics IDs
instId1[0] = "inst_"; // Instance object
instId2 = "";
instId3 = "4294967295";
instId4[0] = "XXXXXXXXXX"; // Object id

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

trg = instance_create_layer(x+10,y+10,"Instances",obj_npc_level);
trg.trg = self.id;

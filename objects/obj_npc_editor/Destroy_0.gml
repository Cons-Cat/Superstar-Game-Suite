/// @description Insert description here
with obj_npc_editor {
	if npcIdVal > other.npcIdVal {
		npcIdVal -= 1;
	}
}

with obj_trigger_cutscene_region_editor {
	for (j = 1; j <= totalActions; j += 1) {
		if actionRowInd[j] = other.npcIdVal {
			actionInd[j] = -1; // Null action
			
		} else if actionRowInd[j] > other.npcIdVal {
			actionRowInd[j] -= 1;
		}
	}
}

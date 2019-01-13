/// @description Insert description here
with obj_npc_position {
	if npcIdVal > other.npcIdVal {
		npcIdVal -= 1;
	}
}

with obj_trigger_dialogue_region_editor {
	for (j = 1; j <= totalActions; j += 1) {
		if actionRowInd[j] = other.npcIdVal {
			actionInd[j] = -1; // Null action
			
		} else if actionRowInd[j] > other.npcIdVal {
			actionRowInd[j] -= 1;
		}
	}
	
	/*j = i + 1;
	
	actionColor[i] = actionColor[j];
	actionSelect[i] = actionSelect[j];
	actionDelete[i] = actionDelete[j];
	actionTime[i] = actionTime[j];
	actionRowInd[i] = actionRowInd[j];
	actionRowId[i] = actionRowId[j];
	*/
//}
}

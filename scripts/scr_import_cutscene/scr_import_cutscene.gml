function scr_import_cutscene() {
	var trgTo = argument[0];
	var trgFrom = argument[1];
	var eventIndex = argument[2];

	trgTo.cutsceneInstanceId = trgFrom;
	trgTo.totalActions = trgFrom.totalActions[eventIndex];

	for (j = 1; j <= trgFrom.totalActions[eventIndex]; j += 1) {
		trgTo.actionInd[j] = trgFrom.actionInd[j, eventIndex];
		trgTo.actionTime[j] = trgFrom.actionTime[j, eventIndex];
		trgTo.actionRowInd[j] = trgFrom.actionRowInd[j, eventIndex];
	
		trgTo.actionSelect[j] = false;
		trgTo.actionDelete[j] = false;
	
		if trgFrom.actionInd[j, eventIndex] = 0 { // Walk action
			trgTo.xNode[j] = trgFrom.xNode[j, eventIndex];
			trgTo.yNode[j] = trgFrom.yNode[j, eventIndex];
		}
	
		if trgFrom.actionInd[j, eventIndex] = 1 { // Rotation action
			trgTo.angleRot[j] = trgFrom.angleRot[j, eventIndex];
			trgTo.angleRotExport[j] = trgFrom.angleRotExport[j, eventIndex];
		}
	
		if trgFrom.actionInd[j, eventIndex] = 2 { // Dialogue action
		#region
		
			trgTo.xOffDialogue[j] = trgFrom.xOffDialogue[j, eventIndex];
			trgTo.yOffDialogue[j] = trgFrom.yOffDialogue[j, eventIndex];
			trgTo.bubbleCount[j] = trgFrom.bubbleCount[j, eventIndex];
		
			for (i = 0; i <= trgFrom.bubbleCount[j]; i += 1) {
				trgTo.lineCount[j,i] = trgFrom.lineCount[j, scr_array_xy(i,eventIndex,trgFrom.eventsCount)];
				trgTo.bubbleX[j,i] = trgFrom.bubbleX[j, scr_array_xy(i,eventIndex,trgFrom.eventsCount)];
				trgTo.bubbleY[j,i] = trgFrom.bubbleY[j, scr_array_xy(i,eventIndex,trgFrom.eventsCount)];
			
				for (k = 0; k <= lineCount[j,i]; k += 1) {
					trgTo.lineStr[scr_array_xy(i,k,trgFrom.bubbleCount[j]),k] = trgFrom.lineStr[scr_array_xy(i,k,trgFrom.bubbleCount[j]), scr_array_xy(k,eventIndex,trgFrom.eventsCount)];
				}
			}
		
		#endregion
		}
	
		if trgFrom.actionInd[j, eventIndex] = 3 { // Camera pan action
			trgTo.xNode[j] = trgFrom.xNode[j, eventIndex];
			trgTo.yNode[j] = trgFrom.yNode[j, eventIndex];
			trgTo.zoomVal[j] = trgFrom.zoomVal[j, eventIndex];
		}
	
		if trgFrom.actionInd[j, eventIndex] = 5 { // Walk speed action
			trgTo.slowSpd[j] = trgFrom.slowSpd[j, eventIndex];
		}
	
		if trgFrom.actionInd[j, eventIndex] = 6 { // Arbitrary action
			trgTo.arbitraryInd[j] = trgFrom.arbitraryInd[j, eventIndex];
		}
	}



}

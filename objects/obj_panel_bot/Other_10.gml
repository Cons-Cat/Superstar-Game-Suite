/// @description Export event data.
// Importing handled by the script scr_import_cutscene()
show_debug_message(eventIndex);
if eventIndex =2 { show_message("BUIG")}

for (i = 0; i < rows; i += 1) {
	cutsceneInstanceId.rowLength[i, eventIndex] = self.rowLength[i];
	rowLength[i] = 0;
}

for (j = 1; j <= self.totalActions; j += 1) {
	cutsceneInstanceId.totalActions[eventIndex] = self.totalActions;
	cutsceneInstanceId.actionInd[j, eventIndex] = self.actionInd[j];
	cutsceneInstanceId.actionTime[j, eventIndex] = self.actionTime[j];
	cutsceneInstanceId.actionRowInd[j, eventIndex] = self.actionRowInd[j];
	
	if actionInd[j] = 0 { // Walk action
		cutsceneInstanceId.xNode[j, eventIndex] = self.xNode[j];
		cutsceneInstanceId.yNode[j, eventIndex] = self.yNode[j];
	}
	
	if actionInd[j] = 1 { // Rotation action
		cutsceneInstanceId.angleRot[j, eventIndex] = self.angleRot[j];
		cutsceneInstanceId.angleRotExport[j, eventIndex] = self.angleRotExport[j];
	}
	
	if actionInd[j] = 2 { // Dialogue action
		#region
		
		cutsceneInstanceId.xOffDialogue[j, eventIndex] = self.xOffDialogue[j];
		cutsceneInstanceId.yOffDialogue[j, eventIndex] = self.yOffDialogue[j];
		cutsceneInstanceId.bubbleCount[j, eventIndex] = self.bubbleCount[j];
		
		for (i = 0; i <= bubbleCount[j]; i += 1) {
			cutsceneInstanceId.lineCount[j, scr_array_xy(i,eventIndex,cutsceneInstanceId.eventsCount)] = self.lineCount[j,i];
			cutsceneInstanceId.bubbleX[j,scr_array_xy(i,eventIndex,cutsceneInstanceId.eventsCount)] = self.bubbleX[j,i];
			cutsceneInstanceId.bubbleY[j,scr_array_xy(i,eventIndex,cutsceneInstanceId.eventsCount)] = self.bubbleY[j,i];
			
			for (k = 0; k <= lineCount[j,i]; k += 1) {
				cutsceneInstanceId.lineStr[scr_array_xy(i,k,bubbleCount[j]),scr_array_xy(k,eventIndex,cutsceneInstanceId.eventsCount)] = self.lineStr[scr_array_xy(i,k,bubbleCount[j]),k];
			}
		}
						
		#endregion
	}
	
	if actionInd[j] = 3 { // Camera action
		cutsceneInstanceId.xNode[j, eventIndex] = self.xNode[j];
		cutsceneInstanceId.yNode[j, eventIndex] = self.yNode[j];
		cutsceneInstanceId.zoomVal[j, eventIndex] = self.zoomVal[j];
	}
	
	if actionInd[j] = 5 { // Walk speed action
		cutsceneInstanceId.slowSpd[j, eventIndex] = self.slowSpd[j];
	}
	
	if actionInd[j] = 6 { // Arbitrary action
		cutsceneInstanceId.arbitraryInd[j, eventIndex] = self.arbitraryInd[j];
	}
	
	actionInd[j] = -1;
}

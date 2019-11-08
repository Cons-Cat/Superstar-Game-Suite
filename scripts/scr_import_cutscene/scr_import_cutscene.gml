var trgTo = argument[0];
var trgFrom = argument[1];

trgTo.cutsceneInstanceId = self.id;
trgTo.totalActions = trgFrom.totalActions;

for (j = 1; j <= trgFrom.totalActions; j += 1) {
	trgTo.actionInd[j] = trgFrom.actionInd[j];
	trgTo.actionTime[j] = trgFrom.actionTime[j];
	trgTo.actionRowInd[j] = trgFrom.actionRowInd[j];
	//trgTo.actionRowId[j] = trgFrom.actionRowId[j];
	
	trgTo.actionSelect[j] = false;
	trgTo.actionDelete[j] = false;
	
	if trgFrom.actionInd[j] = 0 { // Walk action
		trgTo.xNode[j] = trgFrom.xNode[j];
		trgTo.yNode[j] = trgFrom.yNode[j];
	}
	
	if trgFrom.actionInd[j] = 1 { // Rotation action
		trgTo.angleRot[j] = trgFrom.angleRot[j];
		trgTo.angleRotExport[j] = trgFrom.angleRotExport[j];
	}
	
	if trgFrom.actionInd[j] = 2 { // Dialogue action
		trgTo.xOffDialogue[j] = trgFrom.xOffDialogue[j];
		trgTo.yOffDialogue[j] = trgFrom.yOffDialogue[j];
		trgTo.bubbleCount[j] = trgFrom.bubbleCount[j];
		
		for (i = 0; i <= trgFrom.bubbleCount[j]; i += 1) {
			trgTo.lineCount[j,i] = trgFrom.lineCount[j,i];
			trgTo.bubbleX[j,i] = trgFrom.bubbleX[j,i];
			trgTo.bubbleY[j,i] = trgFrom.bubbleY[j,i];
			
			for (k = 0; k <= lineCount[j,i]; k += 1) {
				trgTo.lineStr[scr_array_xy(i,k,trgFrom.bubbleCount[j]),k] = trgFrom.lineStr[scr_array_xy(i,k,trgFrom.bubbleCount[j]),k];
			}
		}
	}
	
	if trgFrom.actionInd[j] = 3 { // Camera pan action
		trgTo.xNode[j] = trgFrom.xNode[j];
		trgTo.yNode[j] = trgFrom.yNode[j];
		trgTo.zoomVal[j] = trgFrom.zoomVal[j];
	}
	
	if trgFrom.actionInd[j] = 5 { // Walk speed action
		trgTo.slowSpd[j] = trgFrom.slowSpd[j];
	}
	
	if trgFrom.actionInd[j] = 6 { // Arbitrary action
		trgTo.arbitraryInd[j] = trgFrom.arbitraryInd[j];
	}
}

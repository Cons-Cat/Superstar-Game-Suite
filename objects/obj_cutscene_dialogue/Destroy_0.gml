/// @description Transfer data
/*for (i = 0; i <= height; i += 1) {
	obj_panel_bot.str[timeIndex,i] = str[i];
}

obj_panel_bot.textRows[timeIndex] = self.textRows;
obj_panel_bot.dialogueWidth[timeIndex] = self.boxWidth;
obj_panel_bot.dialogueHeight[timeIndex] = self.boxHeight;
obj_panel_bot.xOffDialogue[timeIndex] = (trg.x - x);
obj_panel_bot.yOffDialogue[timeIndex] = (trg.y - trg.zfloor*20 - y);
*/

obj_panel_bot.xOffDialogue[timeIndex] = (trg.x - x);
//obj_panel_bot.yOffDialogue[timeIndex] = (trg.y - trg.zfloor*20 - y);
obj_panel_bot.yOffDialogue[timeIndex] = (trg.y - y);

obj_panel_bot.bubbleCount[timeIndex] = self.bubbleCount;

for (var i = 0; i <= bubbleCount; i += 1) {
	obj_panel_bot.lineCount[timeIndex,i] = self.lineCount[i];
	obj_panel_bot.longestLine[timeIndex,i] = self.longestLine[i];
	obj_panel_bot.bubbleX[timeIndex,i] = self.bubbleX[i];
	obj_panel_bot.bubbleY[timeIndex,i] = self.bubbleY[i];
	obj_panel_bot.hasText[timeIndex,i] = self.hasText[i];
	
	for (var j = 0; j <= lineCount[i]; j += 1) {
		obj_panel_bot.lineStr[scr_array_xy(i,j,bubbleCount),j] = self.lineStr[i,j];
	}
}

obj_panel_bot.xNode[timeIndex] = self.x;
obj_panel_bot.yNode[timeIndex] = self.y;
obj_camera_editor.canInputMove = true;

obj_trigger_region_parent.alarm[2] = 2;
obj_trigger_cutscene_region_editor.alarm[2] = 2;

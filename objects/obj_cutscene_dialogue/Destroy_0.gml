/// @description Transfer meta-data
for (i = 0; i <= height; i += 1) {
	obj_panel_bot.str[timeIndex,i] = str[i];
}

obj_panel_bot.textRows[timeIndex] = self.textRows;
obj_panel_bot.dialogueWidth[timeIndex] = self.width;
obj_panel_bot.dialogueHeight[timeIndex] = self.height;
obj_panel_bot.xOffDialogue[timeIndex] = (trg.x - placex);
obj_panel_bot.yOffDialogue[timeIndex] = (trg.y - placey);

obj_trigger_cutscene_region_editor.alarm[2] = 2;
